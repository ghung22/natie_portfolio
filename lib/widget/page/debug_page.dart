// ignore: avoid_web_libraries_in_flutter
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:natie_portfolio/global/dimens.dart';
import 'package:natie_portfolio/global/mixin.dart';
import 'package:natie_portfolio/global/router.dart';
import 'package:natie_portfolio/global/strings.dart';
import 'package:natie_portfolio/global/styles.dart';
import 'package:natie_portfolio/global/widgets.dart';
import 'package:natie_portfolio/store/data/bio_store.dart';
import 'package:natie_portfolio/store/data/project_store.dart';
import 'package:natie_portfolio/store/global/dimen_store.dart';
import 'package:natie_portfolio/widget/common/buttons.dart';
import 'package:natie_portfolio/widget/common/content_item.dart';
import 'package:natie_portfolio/widget/common/list_view.dart';
import 'package:natie_portfolio/widget/common/text_view.dart';
import 'package:natie_portfolio/widget/common/web_item.dart';
import 'package:provider/provider.dart';
import 'package:web/web.dart' hide Navigator;

import '../../l10n/app_localizations.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({super.key});

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> with PostFrameMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
      leading: BackBtn(scaffoldKey: _scaffoldKey),
      title: Observer(
        builder: (context) {
          return TextView(textCallback: () => '${context.read<DimenStore>().size}');
        },
      ),
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
        padding: Dimens.pageContentPadding,
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
      padding: Dimens.projectItemPaddingVertical,
      children: [
        TextView.header(text: AppLocalizations.of(context)!.navigate_to),
        Wrap(
          spacing: Dimens.projectItemPadding,
          runSpacing: Dimens.projectItemPadding,
          children: Routes.list.map((r) {
            return ElevatedBtn(
              onPressed: () => context.go(r, extra: r == Routes.project ? _projectStore?.projects.first : null),
              child: TextView(text: r, color: Theme.of(context).colorScheme.onSurface),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _initInfoSect() {
    _infoSect = PaddedColumn(
      padding: Dimens.projectItemPaddingVertical,
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
                child: TextView(
                  text: 'Org',
                  style: TextStyle(backgroundColor: Colors.grey),
                ),
              ),
            ),
            for (var i = .5; i < 3; i += .5)
              SizedBox(
                width: 64,
                height: 64,
                child: CardItem(
                  hoverFeedback: true,
                  color: MoreColors.lighter(Colors.amber, magnitude: i),
                  child: TextView(
                    text: 'L-$i',
                    style: TextStyle(color: Colors.white, backgroundColor: Colors.black54),
                  ),
                ),
              ),
            for (var i = .5; i < 3; i += .5)
              SizedBox(
                width: 64,
                height: 64,
                child: CardItem(
                  hoverFeedback: true,
                  color: MoreColors.darker(Colors.amber, magnitude: i),
                  child: TextView(
                    text: 'D-$i',
                    style: TextStyle(color: Colors.black, backgroundColor: Colors.white60),
                  ),
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
                padding: Dimens.projectItemPaddingVertical,
                children: [
                  TextView.subheader(text: 'Platform'),
                  const TextView(text: (kIsWeb ? 'Web' : 'Mobile')),
                  const TextView(text: (kDebugMode ? 'Debug' : 'Release/Profile')),
                ],
              ),
            ),
            CardItem(
              child: PaddedColumn(
                padding: Dimens.projectItemPaddingVertical,
                children: [
                  TextView.subheader(text: 'States'),
                  TextView(
                    text:
                        'Screen size:'
                        '${window.screen.width}x${window.screen.height}',
                  ),
                  Observer(
                    builder: (context) {
                      return TextView(text: 'Language: ${Strings.of(context).language}');
                    },
                  ),
                  Observer(
                    builder: (context) {
                      return TextView(text: 'Theme: ${Themes.themeMode(context)}');
                    },
                  ),
                ],
              ),
            ),
            CardItem(
              child: PaddedColumn(
                padding: Dimens.projectItemPaddingVertical,
                children: [
                  TextView.subheader(text: 'Data'),
                  Observer(
                    builder: (context) {
                      return TextView(text: 'ProSize: ${_projectStore?.projects.length}');
                    },
                  ),
                  Observer(
                    builder: (context) {
                      return TextView(text: 'BioLoaded: ${_bioStore?.bio.name}');
                    },
                  ),
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
      padding: Dimens.projectItemPaddingVertical,
      children: [
        PaddedColumn(
          padding: Dimens.pageContentPadding,
          paddingStartAndEnd: false,
          children: [
            ..._projectStore!.projects.values.map((p) {
              return CardItem(
                padding: Dimens.pageContentPadding,
                color: Theme.of(context).colorScheme.inverseSurface,
                child: TextView(
                  text: JsonEncoder.withIndent('  ').convert(p.toJson()),
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  style: Styles.of(context).monospaceStyle.copyWith(fontSize: 9),
                  softWrap: true,
                ),
              );
            }),
          ],
        ),
      ],
    );
  }

  // endregion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar,
      drawer: Widgets.of(context).drawer,
      body: SizedBox(width: window.screen.width.toDouble(), child: _body),
    );
  }
}
