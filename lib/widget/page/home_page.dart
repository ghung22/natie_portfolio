// ignore: avoid_web_libraries_in_flutter
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:natie_portfolio/global/mixin.dart';
import 'package:natie_portfolio/global/router.dart';
import 'package:natie_portfolio/global/strings.dart';
import 'package:natie_portfolio/global/vars.dart';
import 'package:natie_portfolio/global/widgets.dart';
import 'package:natie_portfolio/store/common/animation_store.dart';
import 'package:natie_portfolio/store/data/bio_store.dart';
import 'package:natie_portfolio/store/data/project_store.dart';
import 'package:natie_portfolio/widget/common/animated_view.dart';
import 'package:natie_portfolio/widget/common/banner_item.dart';
import 'package:natie_portfolio/widget/common/buttons.dart';
import 'package:natie_portfolio/widget/common/content_item.dart';
import 'package:natie_portfolio/widget/common/list_view.dart';
import 'package:natie_portfolio/global/dimens.dart';
import 'package:natie_portfolio/widget/common/text_view.dart';
import 'package:natie_portfolio/widget/common/web_item.dart';
import 'package:provider/provider.dart';
import 'package:web/web.dart' hide Navigator;

import '../../l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with PostFrameMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PreferredSizeWidget _appBar = const WebAppBar();
  Widget _body = const Nothing();

  final _scrollController = ScrollController();
  final _introAni = AnimationStore();
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
      setState(() {});
      _introAni.start();
    });
  }

  void _initAppBar() {
    _appBar = WebAppBar(
      leading: NavBtn(scaffoldKey: _scaffoldKey),
      title: Observer(
        builder: (context) {
          final _ = Strings.of(context).language;
          return TextBtn(
            textStyle: Theme.of(context).appBarTheme.titleTextStyle,
            hoverFeedback: false,
            onPressed: () => _scrollController.animateTo(0, duration: Vars.animationSlow, curve: Curves.easeOut),
            child: TextView(textCallback: () => Strings.of(context).title),
          );
        },
      ),
      actions: const [LanguageBtn(), ThemeBtn()],
    );
  }

  void _initBody() {
    _body = SingleChildScrollView(
      controller: _scrollController,
      child: Observer(
        builder: (context) {
          if (_projectStore!.projects.isEmpty) return const Nothing();
          return PaddedColumn(
            padding: Dimens.projectItemPaddingVertical,
            paddingStartAndEnd: false,
            children: [
              // Welcome banner
              IgnorePadding(child: BioBanner(bio: _bioStore!.bio)),
              Dimens.projectItemPaddingBox,

              // Featured projects
              TextView.header(text: AppLocalizations.of(context)!.featured_projects),
              Padding(
                padding: Dimens.pageContentPaddingHorizontal,
                child: Wrap(
                  spacing: Dimens.projectItemPadding,
                  runSpacing: Dimens.projectItemPadding,
                  alignment: WrapAlignment.center,
                  children: _projectStore!.projects.featured
                      .map(
                        (p) => CardItem(
                          color: p.color,
                          child: ConstrainedBox(
                            constraints: Dimens.pageContentMaxWidth,
                            child: ProjectBanner(
                              project: p,
                              onAction: () => context.go(Routes.project, extra: p),
                              isHomePage: true,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const WebFooter(),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar,
      drawer: Widgets.of(context).drawer,
      body: SizedBox(
        width: window.screen.width.toDouble(),
        child: AnimatedFadeSlide(
          offset: _introAni.willStart ? Offset.zero : const Offset(0, -Dimens.bannerSlideOffset),
          opacity: _introAni.willStart ? 1 : 0,
          duration: Vars.animationSluggish,
          curve: Curves.easeOut,
          child: _body,
        ),
      ),
    );
  }
}
