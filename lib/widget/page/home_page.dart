import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:natie_portfolio/global/mixin.dart';
import 'package:natie_portfolio/global/router.dart';
import 'package:natie_portfolio/global/strings.dart';
import 'package:natie_portfolio/global/vars.dart';
import 'package:natie_portfolio/store/data/bio_store.dart';
import 'package:natie_portfolio/store/data/project_store.dart';
import 'package:natie_portfolio/widget/common/banner_item.dart';
import 'package:natie_portfolio/widget/common/buttons.dart';
import 'package:natie_portfolio/widget/common/content_item.dart';
import 'package:natie_portfolio/widget/common/list_view.dart';
import 'package:natie_portfolio/global/dimens.dart';
import 'package:natie_portfolio/widget/common/text_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with PostFrameMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PreferredSizeWidget _appBar = AppBar();
  Widget _body = const Nothing();
  Widget _drawer = const Nothing();

  final _scrollController = ScrollController();
  ProjectStore? _projectStore;
  BioStore? _bioStore;

  @override
  void initState() {
    super.initState();
    postFrame(() {
      _projectStore = context.read<ProjectStore>();
      _bioStore = context.read<BioStore>();
      _initAppBar();
      _initBody();
      _initDrawer();
      setState(() {});
    });
  }

  void _initAppBar() {
    _appBar = AppBar(
      leading: IconBtn(
        tooltipText: AppLocalizations.of(context)!.navigation,
        child: const Icon(Icons.menu_rounded),
        onPressed: () => _scaffoldKey.currentState!.openDrawer(),
      ),
      centerTitle: true,
      title: Observer(builder: (context) {
        Strings.isEn;
        return TextBtn(
          textStyle: Theme.of(context).appBarTheme.titleTextStyle,
          hoverFeedback: false,
          onPressed: () => _scrollController.animateTo(
            0,
            duration: Vars.animationSlow,
            curve: Curves.easeOut,
          ),
          child: TextView(textCallback: () => Strings.title),
        );
      }),
      actions: [
        IconBtn(
          tooltipText: AppLocalizations.of(context)!.search,
          child: const Icon(CupertinoIcons.search),
          onPressed: () {},
        ),
        const LanguageBtn(),
        const ThemeBtn(),
      ],
    );
  }

  void _initBody() {
    _body = SingleChildScrollView(
      controller: _scrollController,
      child: Observer(builder: (context) {
        return PaddedColumn(
          padding:
              const EdgeInsets.symmetric(vertical: Dimens.projectItemPadding),
          paddingStartAndEnd: false,
          children: [
            // Welcome banner
            IgnorePadding(child: BioBanner(bio: _bioStore!.bio)),
            const SizedBox(height: Dimens.projectItemPadding),

            // Featured projects
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.pageContentPaddingHorizontal),
              child: Wrap(
                spacing: Dimens.projectItemPadding,
                runSpacing: Dimens.projectItemPadding,
                alignment: WrapAlignment.center,
                children: _projectStore!.projects.featured
                    .map((p) => CardItem(
                          color: p.color,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxWidth: Dimens.pageContentMaxWidth),
                            child: ProjectBanner(
                              project: p,
                              onAction: () => Navigator.of(context)
                                  .pushNamed(Routes.project, arguments: p),
                              isHomePage: true,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: Dimens.pageContentPaddingHorizontal),
          ],
        );
      }),
    );
  }

  void _initDrawer() {
    _drawer = Drawer(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.drawerPadding),
        child: CardItem(
          child: ListView(
            children: [
              DrawerHeader(
                child: PaddedColumn(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimens.drawerItemPadding),
                  children: [
                    // App icon
                    TextView.header(
                      text: AppLocalizations.of(context)!.navigate_to,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar,
      drawer: _drawer,
      body: SizedBox(
        width: window.screen?.width?.toDouble(),
        child: _body,
      ),
    );
  }
}