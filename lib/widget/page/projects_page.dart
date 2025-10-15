import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:natie_portfolio/data/model/project.dart';
import 'package:natie_portfolio/global/mixin.dart';
import 'package:natie_portfolio/global/router.dart';
import 'package:natie_portfolio/global/vars.dart';
import 'package:natie_portfolio/global/widgets.dart';
import 'package:natie_portfolio/store/common/animation_store.dart';
import 'package:natie_portfolio/store/data/project_store.dart';
import 'package:natie_portfolio/widget/common/banner_item.dart';
import 'package:natie_portfolio/widget/common/buttons.dart';
import 'package:natie_portfolio/global/dimens.dart';
import 'package:natie_portfolio/widget/common/content_item.dart';
import 'package:natie_portfolio/widget/common/list_view.dart';
import 'package:natie_portfolio/widget/common/text_view.dart';
import 'package:natie_portfolio/widget/common/web_item.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';

class ProjectsPage extends StatefulWidget {
  final List<ProjectTag>? tags;

  const ProjectsPage({super.key, this.tags});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> with PostFrameMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PreferredSizeWidget _appBar = const WebAppBar();
  Widget _body = const Nothing();
  Widget _featured = const Nothing();
  Widget _others = const Nothing();

  final AnimationStore _introAni = AnimationStore();
  final _scrollController = ScrollController();
  ProjectStore? _projectStore;

  @override
  void initState() {
    super.initState();
    postFrame(() {
      _projectStore = context.read<ProjectStore>();
      _introAni.start();
      setState(() {});
    });
  }

  void _initAppBar() {
    _appBar = WebAppBar(
      leading: BackBtn(scaffoldKey: _scaffoldKey),
      title: TextBtn(
        textStyle: Theme.of(context).appBarTheme.titleTextStyle,
        hoverFeedback: false,
        onPressed: () => _scrollController.animateTo(0, duration: Vars.animationSlow, curve: Curves.easeOut),
        child: TextView(text: AppLocalizations.of(context)!.projects),
      ),
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

  // region Body

  void _initBody() {
    _initFeatured();
    _initOthers();
    _body = SingleChildScrollView(
      controller: _scrollController,
      child: PaddedColumn(
        padding: Dimens.pageContentPadding,
        children: [
          _featured,
          _others,
          const IgnorePadding(child: WebFooter()),
        ],
      ),
    );
  }

  void _initFeatured() {
    _featured = Observer(
      builder: (context) {
        if (_projectStore == null) return const Nothing();
        final p = _projectStore!.projects.getFeatured(widget.tags);
        return PaddedColumn(
          padding: Dimens.projectItemPaddingVertical,
          children: [
            TextView.header(text: AppLocalizations.of(context)!.featured_projects),
            ...p.map((p) {
              return CardItem(
                color: p.color,
                child: ConstrainedBox(
                  constraints: Dimens.pageContentMaxWidth,
                  child: ProjectBanner(
                    project: p,
                    onAction: () => context.go(Routes.project, extra: p),
                    isHomePage: true,
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  void _initOthers() {
    _others = Observer(
      builder: (context) {
        if (_projectStore == null) return const Nothing();
        final p = _projectStore!.projects.getOthers(widget.tags);
        return PaddedColumn(
          padding: Dimens.projectItemPaddingVertical,
          children: [
            TextView.header(text: AppLocalizations.of(context)!.more_projects),
            ...p.map((p) {
              return CardItem(
                color: p.color,
                child: ConstrainedBox(
                  constraints: Dimens.pageContentMaxWidth,
                  child: ProjectBanner(
                    project: p,
                    onAction: () => context.go(Routes.project, extra: p),
                    isHomePage: true,
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  // endregion

  @override
  Widget build(BuildContext context) {
    _initAppBar();
    _initBody();

    return Scaffold(key: _scaffoldKey, appBar: _appBar, drawer: Widgets.of(context).drawer, body: _body);
  }
}
