// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:natie_portfolio/global/dimens.dart';
import 'package:natie_portfolio/global/mixin.dart';
import 'package:natie_portfolio/global/router.dart';
import 'package:natie_portfolio/global/strings.dart';
import 'package:natie_portfolio/global/styles.dart';
import 'package:natie_portfolio/store/data/bio_store.dart';
import 'package:natie_portfolio/store/data/project_store.dart';
import 'package:natie_portfolio/store/global/dimen_store.dart';
import 'package:natie_portfolio/widget/common/banner_item.dart';
import 'package:natie_portfolio/widget/common/buttons.dart';
import 'package:natie_portfolio/widget/common/content_item.dart';
import 'package:natie_portfolio/widget/common/list_view.dart';
import 'package:natie_portfolio/widget/common/text_view.dart';
import 'package:natie_portfolio/widget/common/web_item.dart';
import 'package:provider/provider.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({Key? key}) : super(key: key);

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> with PostFrameMixin {
  PreferredSizeWidget _appBar = const WebAppBar();
  Widget _body = const Nothing();
  Widget _navSect = const Nothing();
  Widget _infoSect = const Nothing();
  Widget _testSect = const Nothing();

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
    });
  }

  void _initAppBar() {
    _appBar = WebAppBar(
      leading: const BackBtn(),
      title: Observer(builder: (context) {
        return TextView(
            textCallback: () => '${context.read<DimenStore>().size}');
      }),
      actions: const [LanguageBtn(), ThemeBtn()],
    );
  }

  // region Body

  void _initBody() {
    _initNavSect();
    _initInfoSect();
    _initTestSect();
    _body = SingleChildScrollView(
      child: PaddedColumn(
        padding:
            const EdgeInsets.symmetric(vertical: Dimens.pageContentPaddingHorizontal),
        children: [
          // Navigation
          _navSect,
          // Debug information
          _infoSect,
          // Testing grounds
          _testSect,
          // Footer
          const IgnorePadding(child: WebFooter()),
        ],
      ),
    );
  }

  void _initNavSect() {
    _navSect = PaddedColumn(
      padding:
      const EdgeInsets.symmetric(vertical: Dimens.projectItemPadding),
      children: [
        TextView.header(text: AppLocalizations.of(context)!.navigate_to),
        Wrap(
          spacing: Dimens.projectItemPadding,
          runSpacing: Dimens.projectItemPadding,
          children: Routes.list.map((r) {
            return ElevatedBtn(
              onPressed: () => Navigator.pushNamed(
                context,
                r,
                arguments: r == Routes.project
                    ? _projectStore?.projects.first
                    : null,
              ),
              child: TextView(text: r),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _initInfoSect() {
    _infoSect = PaddedColumn(
      padding:
      const EdgeInsets.symmetric(vertical: Dimens.projectItemPadding),
      children: [
        TextView.header(text: 'Debug information'),
        Wrap(
          spacing: Dimens.projectDetailsTechPaddingHorizontal,
          runSpacing: Dimens.projectDetailsTechPaddingVertical,
          children: [
            const SizedBox(
              width: 64,
              height: 64,
              child: CardItem(
                hoverFeedback: true,
                color: Colors.amber,
                child: TextView(text: 'Org'),
              ),
            ),
            for (var i = .5; i < 3; i += .5)
              SizedBox(
                width: 64,
                height: 64,
                child: CardItem(
                  hoverFeedback: true,
                  color: MoreColors.lighter(Colors.amber, magnitude: i),
                  child: TextView(text: 'L-$i'),
                ),
              ),
            for (var i = .5; i < 3; i += .5)
              SizedBox(
                width: 64,
                height: 64,
                child: CardItem(
                  hoverFeedback: true,
                  color: MoreColors.darker(Colors.amber, magnitude: i),
                  child: TextView(text: 'D-$i'),
                ),
              ),
          ],
        ),
        Wrap(
          spacing: Dimens.projectItemPadding,
          runSpacing: Dimens.projectItemPadding,
          children: [
            CardItem(
              child: PaddedColumn(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimens.projectItemPadding),
                children: [
                  TextView.subheader(text: 'Platform'),
                  const TextView(text: (kIsWeb ? 'Web' : 'Mobile')),
                  const TextView(
                      text: (kDebugMode ? 'Debug' : 'Release/Profile')),
                ],
              ),
            ),
            CardItem(
              child: PaddedColumn(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimens.projectItemPadding),
                children: [
                  TextView.subheader(text: 'States'),
                  TextView(
                      text: 'Screen size:'
                          '${window.screen?.width}x${window.screen?.height}'),
                  Observer(builder: (context) {
                    return TextView(text: 'Language: ${Strings.language}');
                  }),
                  Observer(builder: (context) {
                    return TextView(text: 'Theme: ${Themes.themeMode}');
                  }),
                ],
              ),
            ),
            CardItem(
              child: PaddedColumn(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimens.projectItemPadding),
                children: [
                  TextView.subheader(text: 'Data'),
                  Observer(builder: (context) {
                    return TextView(text: 'ProSize: ${_projectStore?.projects
                        .length}');
                  }),
                  Observer(builder: (context) {
                    return TextView(text: 'BioLoaded: ${_bioStore?.bio.name}');
                  }),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _initTestSect() {
    _testSect = PaddedColumn(
      padding:
      const EdgeInsets.symmetric(vertical: Dimens.projectItemPadding),
      children: [
        Observer(builder: (context) {
          if (_projectStore == null) return const Nothing();
          if (_projectStore!.projects.isEmpty) return const Nothing();
          return PaddedColumn(
            padding: const EdgeInsets.symmetric(
                vertical: Dimens.pageContentPaddingHorizontal),
            paddingStartAndEnd: false,
            children: [
              ProjectBanner(
                project: _projectStore!.projects.first!,
                isHomePage: true,
              ),
              ProjectBanner(project: _projectStore!.projects.first!),
            ],
          );
        }),
      ],
    );
  }

  // endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: SizedBox(
        width: window.screen?.width?.toDouble(),
        child: _body,
      ),
    );
  }
}