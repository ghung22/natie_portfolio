import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:natie_portfolio/global/mixin.dart';
import 'package:natie_portfolio/global/router.dart';
import 'package:natie_portfolio/global/strings.dart';
import 'package:natie_portfolio/global/styles.dart';
import 'package:natie_portfolio/global/vars.dart';
import 'package:natie_portfolio/store/common/animation_store.dart';
import 'package:natie_portfolio/store/data/bio_store.dart';
import 'package:natie_portfolio/widget/common/buttons.dart';
import 'package:natie_portfolio/global/dimens.dart';
import 'package:natie_portfolio/widget/common/content_item.dart';
import 'package:natie_portfolio/widget/common/image_view.dart';
import 'package:natie_portfolio/widget/common/list_view.dart';
import 'package:natie_portfolio/widget/common/text_view.dart';
import 'package:natie_portfolio/widget/common/web_item.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../l10n/app_localizations.dart';

class AboutPage extends StatefulWidget {
  final bool disableAnimation;

  const AboutPage({super.key, this.disableAnimation = false});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with PostFrameMixin {
  PreferredSizeWidget _appBar = const WebAppBar();
  Widget _body = const Nothing();
  Widget _header = const Nothing();
  Widget _scores = const Nothing();
  Widget _experience = const Nothing();

  final AnimationStore _introAni = AnimationStore();
  final _scrollController = ScrollController();
  BioStore? _bioStore;

  @override
  void initState() {
    super.initState();
    postFrame(() {
      _bioStore = context.read<BioStore>();
      _introAni.start();
      setState(() {});
    });
  }

  void _initAppBar() {
    _appBar = WebAppBar(
      leading: const BackBtn(),
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

  // region Body

  void _initBody() {
    _initHeader();
    _initScores();
    _initExperience();
    _body = SingleChildScrollView(
      controller: _scrollController,
      child: PaddedColumn(
        padding: const EdgeInsets.symmetric(vertical: Dimens.bioDetailsPaddingVertical),
        children: [
          _header,
          _scores,
          _experience,
          IgnorePadding(
            child: Observer(
              builder: (context) {
                return WebFooter(color: _bioStore?.bio.colors.first);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _initHeader() {
    _header = Observer(
      builder: (context) {
        if (_bioStore == null) return const Nothing();
        final bio = _bioStore!.bio;
        return Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
          children: [
            TableRow(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: Dimens.bioHeight),
                  child: Builder(
                    builder: (context) {
                      final ava = DecoratedBox(
                        decoration: ShapeDecoration(
                          shape: CircleBorder(
                            side: BorderSide(color: bio.colors.first, width: Dimens.bioAvatarBorderSize),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(Dimens.bioAvatarPadding),
                          child: FittedBox(
                            child: CircleImageView(
                              bio.avatarUrl,
                              onFinish: () {
                                if (!_introAni.willStart) _introAni.start();
                              },
                            ),
                          ),
                        ),
                      );
                      if (widget.disableAnimation) return ava;
                      return Hero(tag: '${Routes.about}/avatar', child: ava);
                    },
                  ),
                ),
                PaddedColumn(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.bioDetailsPaddingHorizontal,
                    vertical: Dimens.bioDetailsPaddingVertical,
                  ),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: bio.name,
                      style: Styles.bioNameStyle.copyWith(color: bio.colors.first),
                    ),
                    TextView(
                      text: Strings.of(context).isEn ? bio.description : bio.descriptionVi,
                      style: Styles.bioDescriptionStyle,
                      spaced: true,
                      softWrap: true,
                    ),
                    TextView.header(text: AppLocalizations.of(context)!.contact),
                    Padding(
                      padding: const EdgeInsets.only(left: Dimens.bioDetailsPaddingHorizontal),
                      child: Wrap(
                        spacing: Dimens.bioDetailsContactPadding,
                        runSpacing: Dimens.bioDetailsContactPadding,
                        children: bio.contact
                            .map((k, v) {
                              return MapEntry(
                                k,
                                SizedBox(
                                  width: Dimens.bioDetailsContactSize,
                                  height: Dimens.bioDetailsContactSize,
                                  child: Tooltip(
                                    message: k,
                                    child: ElevatedBtn(
                                      color: Theme.of(context).colorScheme.surface,
                                      onPressed: () => launchUrlString(v, mode: LaunchMode.externalApplication),
                                      padding: const EdgeInsets.all(Dimens.cardPadding),
                                      child: SvgImageView(
                                        Vars.assets[k.toLowerCase()] ?? '',
                                        width: Dimens.bioDetailsContactSize,
                                        height: Dimens.bioDetailsContactSize,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })
                            .values
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _initScores() {
    _scores = Observer(
      builder: (context) {
        if (_bioStore == null) return const Nothing();
        final bio = _bioStore!.bio;
        return PaddedColumn(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.bioDetailsPaddingHorizontal,
            vertical: Dimens.bioDetailsPaddingVertical,
          ),
          children: [
            TextView.header(text: AppLocalizations.of(context)!.scores, color: bio.colors.first),
            Wrap(
              spacing: Dimens.bioDetailsScorePaddingHorizontal,
              runSpacing: Dimens.bioDetailsScorePaddingVertical,
              children: [
                ...bio.scores.map((s) {
                  return BioScoreItem(s, color: bio.colors.first);
                }),
              ],
            ),
          ],
        );
      },
    );
  }

  void _initExperience() {
    _experience = Observer(
      builder: (context) {
        if (_bioStore == null) return const Nothing();
        final bio = _bioStore!.bio;
        return PaddedColumn(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.bioDetailsPaddingHorizontal,
            vertical: Dimens.bioDetailsPaddingVertical,
          ),
          children: [
            TextView.header(text: AppLocalizations.of(context)!.experience, color: bio.colors.first),
            ...bio.experience.map((e) {
              return BioExperienceItem(e, color: bio.colors.first);
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

    return Scaffold(appBar: _appBar, body: _body);
  }
}
