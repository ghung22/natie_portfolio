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
import 'package:natie_portfolio/widget/common/buttons.dart';
import 'package:natie_portfolio/widget/common/content_item.dart';
import 'package:natie_portfolio/widget/common/list_view.dart';
import 'package:natie_portfolio/widget/common/text_view.dart';
import 'package:provider/provider.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({Key? key}) : super(key: key);

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> with PostFrameMixin {
  PreferredSizeWidget _appBar = AppBar();
  Widget _body = const Nothing();

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
    _appBar = AppBar(
      leading: const BackBtn(),
      centerTitle: true,
      title: Observer(builder: (context) {
        Strings.isEn;
        return TextView(textCallback: () => Strings.title);
      }),
      actions: const [LanguageBtn(), ThemeBtn()],
    );
  }

  void _initBody() {
    _body = SingleChildScrollView(
      child: PaddedColumn(
        padding:
            const EdgeInsets.symmetric(vertical: Dimens.projectItemPadding),
        children: [
          // Navigation
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
          const SizedBox(height: Dimens.pageContentPaddingHorizontal),

          // Debug information
          TextView.header(text: 'Debug information'),
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
            ],
          ),
          const SizedBox(height: Dimens.pageContentPaddingHorizontal),

          // Testing grounds
          Wrap(
            children: [
              const AnimatedCountingText(value: 5, color: Colors.red),
              AnimatedCountingText(
                value: 10,
                dimension: 360,
                style: Styles.bannerTitleStyle,
                topSide: TextView(text: 'top', style: Styles.headerStyle),
                bottomSide: const TextView(text: 'bottom'),
              ),
              AnimatedCountingText(
                value: 321,
                dimension: 240,
                color: Colors.green,
                style: Styles.subheaderStyle,
                spaced: true,
              ),
              const AnimatedCountingText(
                value: 950,
                bottomSide: TextView(text: 'k'),
                padding: EdgeInsets.symmetric(
                  vertical: Dimens.projectItemPadding,
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.pageContentPaddingHorizontal),
        ],
      ),
    );
  }

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