import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:natie_portfolio/data/model/experience.dart';
import 'package:natie_portfolio/data/model/score.dart';
import 'package:natie_portfolio/global/dimens.dart';
import 'package:natie_portfolio/global/routes.dart';
import 'package:natie_portfolio/global/strings.dart';
import 'package:natie_portfolio/data/model/project.dart';
import 'package:natie_portfolio/global/styles.dart';
import 'package:natie_portfolio/store/common/animation_store.dart';
import 'package:natie_portfolio/store/data/bio_store.dart';
import 'package:natie_portfolio/widget/common/buttons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../global/vars.dart';
import '../../l10n/app_localizations.dart';
import 'animated_view.dart';
import 'image_view.dart';
import 'list_view.dart';
import 'text_view.dart';

// region Common content

class CardItem extends StatefulWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color? color;
  final VoidCallback? onPressed;
  final VoidCallback? onHover;
  final bool hoverFeedback;
  final double hoverScale;
  final Duration hoverAnimationSpeed;

  const CardItem({
    super.key,
    required this.child,
    this.padding = Dimens.cardPadding,
    this.color,
    this.onPressed,
    this.onHover,
    this.hoverFeedback = false,
    this.hoverScale = 1.05,
    this.hoverAnimationSpeed = Vars.animationFast,
  });

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return AnimatedHover(
      scaleOnHover: widget.hoverScale,
      duration: widget.hoverAnimationSpeed,
      onPressed: widget.onPressed,
      onHover: widget.onHover,
      feedback: widget.hoverFeedback,
      child: Card(
        color: widget.color,
        child: Padding(padding: widget.padding, child: widget.child),
      ),
    );
  }
}

class IntlListItem extends StatefulWidget {
  final List<String> items;
  final List<String> itemsVi;
  final int index;

  const IntlListItem(this.items, this.itemsVi, this.index, {super.key});

  @override
  State<IntlListItem> createState() => _IntlListItemState();
}

class _IntlListItemState extends State<IntlListItem> {
  late List<String> _l;
  late List<String> _lv;
  late int _i;

  Widget _contentCard = const Nothing();
  final AnimationStore _visibleAni = AnimationStore();

  @override
  void initState() {
    super.initState();
    _l = widget.items;
    _lv = widget.itemsVi;
    _i = widget.index;
  }

  void _initContentCard() {
    _contentCard = Observer(
      builder: (context) {
        List<String> f;
        if (Strings.of(context).isEn) {
          f = _l.isNotEmpty ? _l : _lv;
        } else {
          f = _lv.isNotEmpty ? _lv : _l;
        }
        if (f.length < _i) return const Nothing();
        return SizedBox(
          width: Dimens.projectDetailsFuncWidth,
          child: CardItem(
            hoverFeedback: true,
            child: TextView(
              text: f[_i],
              textAlign: TextAlign.center,
              spaced: true,
              softWrap: true,
              padding: Dimens.projectDetailsFuncPadding,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _initContentCard();
    return VisibilityDetector(
      key: Key('${_l.hashCode}_$_i'),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction > .5) {
          if (!_visibleAni.willStart) _visibleAni.start();
        }
      },
      child: Observer(
        builder: (context) {
          return AnimatedFadeSlide(
            offset: _visibleAni.willStart ? Offset.zero : const Offset(0, -Dimens.projectDetailsFuncOffset),
            opacity: _visibleAni.willStart ? 1 : 0,
            duration: Vars.animationFast,
            child: _contentCard,
          );
        },
      ),
    );
  }
}

/// An empty widget
class Nothing extends StatelessWidget {
  const Nothing({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

/// A container with red background (for testing)
class RedContainer extends StatelessWidget {
  final Widget child;

  const RedContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) => Container(color: Colors.red, child: child);
}

// endregion

// region Project items

class ProjectMiniItem extends StatelessWidget {
  final Project project;

  const ProjectMiniItem(this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    return CardItem(
      onPressed: () {
        Routes.routemaster.push(Routes.project, queryParameters: {'id': project.id, 'disableAnimation': 'true'});
      },
      color: project.color,
      child: PaddedRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        padding: Dimens.projectItemContentPaddingHorizontal,
        children: [
          Container(
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: Builder(
              builder: (context) {
                if (project.iconUrl.isEmpty) {
                  return ClipRRect(
                    borderRadius: Dimens.roundedImageRadius,
                    child: Container(
                      color: Colors.white,
                      width: Dimens.projectItemIconSize,
                      height: Dimens.projectItemIconSize,
                    ),
                  );
                }
                return RoundedImageView(
                  project.iconUrl,
                  width: Dimens.projectItemIconSize,
                  height: Dimens.projectItemIconSize,
                );
              },
            ),
          ),
          Expanded(
            child: PaddedColumn(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              padding: Dimens.projectItemContentPadding,
              children: [
                TextView.header(text: project.title, color: Colors.white),
                Observer(
                  builder: (context) {
                    final isEn = Strings.of(context).isEn;
                    if (project.author.isEmpty && project.authorVi.isEmpty) {
                      return const Nothing();
                    }
                    var author = isEn ? project.author : project.authorVi;
                    if (author.isEmpty) {
                      author = isEn ? project.authorVi : project.author;
                    }
                    return TextView.subheader(text: author, color: Colors.white);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectTimestampItem extends StatefulWidget {
  final Project project;

  const ProjectTimestampItem(this.project, {super.key});

  @override
  State<ProjectTimestampItem> createState() => _ProjectTimestampItemState();
}

class _ProjectTimestampItemState extends State<ProjectTimestampItem> {
  late Project _p;

  final AnimationStore _visibleAni = AnimationStore();

  @override
  void initState() {
    super.initState();
    _p = widget.project;
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('${_p.id}_timestamp'),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction > .5) {
          if (!_visibleAni.willStart) _visibleAni.start();
        }
      },
      child: AnimatedFadeSlide(
        offset: _visibleAni.willStart ? Offset.zero : const Offset(0, -Dimens.projectDetailsFuncOffset),
        opacity: _visibleAni.willStart ? 1 : 0,
        duration: Vars.animationFast,
        child: Observer(
          builder: (context) {
            return SizedBox(
              width: Dimens.projectDetailsFuncWidth,
              child: CardItem(
                hoverFeedback: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextView.header(text: AppLocalizations.of(context)!.completion_date, color: _p.color),
                    Dimens.projectDetailsFuncPaddingBox,
                    TextView(
                      text: DateFormat.yMMMM(
                        Strings.of(context).language.name,
                      ).format(DateTime.fromMillisecondsSinceEpoch(_p.completionTimestamp ?? 0)),
                      spaced: true,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProjectAuthorItem extends StatefulWidget {
  final Project project;

  const ProjectAuthorItem(this.project, {super.key});

  @override
  State<ProjectAuthorItem> createState() => _ProjectAuthorItemState();
}

class _ProjectAuthorItemState extends State<ProjectAuthorItem> {
  late Project _p;

  final AnimationStore _visibleAni = AnimationStore();

  @override
  void initState() {
    super.initState();
    _p = widget.project;
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('${_p.id}_author'),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction > .5) {
          if (!_visibleAni.willStart) _visibleAni.start();
        }
      },
      child: AnimatedFadeSlide(
        offset: _visibleAni.willStart ? Offset.zero : const Offset(0, -Dimens.projectDetailsFuncOffset),
        opacity: _visibleAni.willStart ? 1 : 0,
        duration: Vars.animationFast,
        child: Observer(
          builder: (context) {
            final isEn = Strings.of(context).isEn;
            var author = isEn ? _p.author : _p.authorVi;
            if (author.isEmpty) author = isEn ? _p.authorVi : _p.author;
            return SizedBox(
              width: Dimens.projectDetailsFuncWidth,
              child: CardItem(
                hoverFeedback: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextView.header(text: AppLocalizations.of(context)!.author, color: _p.color),
                    Dimens.projectDetailsFuncPaddingBox,
                    TextView(text: author, spaced: true),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HostUrlItem extends StatefulWidget {
  final Project project;

  const HostUrlItem(this.project, {super.key});

  @override
  State<HostUrlItem> createState() => _HostUrlItemState();
}

class _HostUrlItemState extends State<HostUrlItem> {
  late Project _p;

  final AnimationStore _visibleAni = AnimationStore();

  @override
  void initState() {
    super.initState();
    _p = widget.project;
  }

  @override
  Widget build(BuildContext context) {
    if (_p.hostUrl.isEmpty) return const Nothing();
    return VisibilityDetector(
      key: Key('${_p.id}_host'),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction > .5) {
          if (!_visibleAni.willStart) _visibleAni.start();
        }
      },
      child: AnimatedFadeSlide(
        offset: _visibleAni.willStart ? Offset.zero : const Offset(0, -Dimens.projectDetailsFuncOffset),
        opacity: _visibleAni.willStart ? 1 : 0,
        duration: Vars.animationFast,
        child: Observer(
          builder: (context) {
            return SizedBox(
              width: Dimens.projectDetailsFuncWidth,
              child: CardItem(
                hoverFeedback: true,
                onPressed: () => launchUrlString(_p.hostUrl, mode: LaunchMode.externalApplication),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextView.header(text: AppLocalizations.of(context)!.host, color: _p.color),
                    Dimens.projectDetailsFuncPaddingBox,
                    TextBtn(
                      hoverFeedback: false,
                      textStyle: TextStyle(color: _p.color),
                      onPressed: () => launchUrlString(_p.hostUrl, mode: LaunchMode.externalApplication),
                      child: TextView(text: _p.hostUrl, spaced: true),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FunctionalityItem extends StatelessWidget {
  final Project p;
  final int index;

  const FunctionalityItem(this.p, this.index, {super.key});

  @override
  Widget build(BuildContext context) => IntlListItem(p.functionalities, p.functionalitiesVi, index);
}

class LearnedItem extends StatelessWidget {
  final Project p;
  final int index;

  const LearnedItem(this.p, this.index, {super.key});

  @override
  Widget build(BuildContext context) => IntlListItem(p.learned, p.learnedVi, index);
}

class TechItem extends StatelessWidget {
  final String tech;

  const TechItem(this.tech, {super.key});

  @override
  Widget build(BuildContext context) {
    final src = Vars.assets[tech] ?? '';
    return Tooltip(
      message: tech,
      verticalOffset: Dimens.projectDetailsTechSize / 2,
      child: CardItem(
        hoverFeedback: true,
        color: Colors.white,
        padding: Dimens.projectDetailsTechPaddingInternal,
        child: SvgImageView(src, height: Dimens.projectDetailsTechSize, fit: BoxFit.fitHeight),
      ),
    );
  }
}

// endregion

// region Bio items

class BioMiniItem extends StatelessWidget {
  const BioMiniItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final bioStore = context.read<BioStore>();
        final bio = bioStore.bio;
        return PaddedRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          padding: Dimens.drawerPaddingHorizontal,
          children: [
            InkWell(
              splashFactory: NoSplash.splashFactory,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => Routes.routemaster.push(Routes.about, queryParameters: {'disableAnimation': 'true'}),
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  shape: CircleBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor, width: Dimens.bioAvatarBorderSize),
                  ),
                ),
                child: Padding(
                  padding: Dimens.bioAvatarPadding,
                  child: FittedBox(
                    child: CircleImageView(
                      bio.avatarUrl,
                      width: Dimens.drawerAvatarSize,
                      height: Dimens.drawerAvatarSize,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PaddedColumn(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                padding: Dimens.projectItemContentPadding,
                children: [
                  TextBtn(
                    hoverFeedback: false,
                    onPressed: () =>
                        Routes.routemaster.push(Routes.about, queryParameters: {'disableAnimation': 'true'}),
                    padding: EdgeInsets.zero,
                    child: TextView.header(text: bio.name, color: Theme.of(context).primaryColor),
                  ),
                  Wrap(
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
                                  padding: Dimens.cardPadding,
                                  onPressed: () => launchUrlString(v, mode: LaunchMode.externalApplication),
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
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class BioScoreItem extends StatefulWidget {
  final Score score;
  final Color? color;

  const BioScoreItem(this.score, {super.key, this.color});

  @override
  State<BioScoreItem> createState() => _BioScoreItemState();
}

class _BioScoreItemState extends State<BioScoreItem> {
  late Score _s;
  late Color? _c;

  @override
  void initState() {
    super.initState();
    _s = widget.score;
    _c = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final _ = Strings.of(context).language;
        return SizedBox(
          width: Dimens.bioDetailsScoreSize,
          child: CardItem(
            hoverFeedback: true,
            child: PaddedColumn(
              padding: const EdgeInsets.all(Dimens.bioDetailsScorePaddingVertical),
              children: [
                TextView.header(text: _s.name, color: _c ?? Theme.of(context).primaryColor),
                TextView.subheader(
                  text:
                      '${_s.score}'
                      '${(_s.customData['alt'] != null) ? ' (${_s.customData['alt']!})' : ''}',
                  color: Theme.of(context).colorScheme.onSurface,
                  spaced: true,
                ),
                if (_s.customData['ref'] != null)
                  ElevatedBtn(
                    child: TextView(
                      text: AppLocalizations.of(context)!.scoreboard,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () => launchUrlString(_s.customData['ref']!, mode: LaunchMode.externalApplication),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BioExperienceItem extends StatefulWidget {
  final Experience exp;
  final Color? color;

  const BioExperienceItem(this.exp, {super.key, this.color});

  @override
  State<BioExperienceItem> createState() => _BioExperienceItemState();
}

class _BioExperienceItemState extends State<BioExperienceItem> {
  late Experience _e;
  late Color? _c;

  @override
  void initState() {
    super.initState();
    _e = widget.exp;
    _c = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final isEn = Strings.of(context).isEn;
        final styles = Styles.of(context);
        final theme = Theme.of(context);
        var name = _e.nameVi ?? _e.name;
        if (isEn) name = _e.name ?? _e.nameVi;
        var major = _e.majorVi ?? _e.major;
        if (isEn) major = _e.major ?? _e.majorVi;
        return CardItem(
          onPressed: () =>
              Routes.routemaster.push(Routes.project, queryParameters: {'filter': ?_e.projectFilter?.join('-')}),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: Dimens.bioDetailsExpSize),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                if (_e.imageUrls != null)
                  if (_e.imageUrls!.length > 1)
                    Align(
                      alignment: Alignment.centerRight,
                      child: ShaderMask(
                        blendMode: BlendMode.dstOut,
                        shaderCallback: (Rect rect) => const LinearGradient(
                          colors: [Colors.white, Colors.transparent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(rect),
                        child: RoundedImageView(
                          _e.imageUrls![1],
                          height: Dimens.bioDetailsExpSize,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                PaddedRow(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  padding: Dimens.bioDetailsExpPaddingHorizontal,
                  children: [
                    if (_e.imageUrls?.isEmpty == true)
                      ImageView(
                        _e.imageUrls![0],
                        width: Dimens.bioDetailsExpSize * .75,
                        height: Dimens.bioDetailsExpSize * .75,
                        fit: BoxFit.scaleDown,
                      ),
                    if (_e.imageUrls?.isEmpty != true)
                      SizedBox.fromSize(size: Size(Dimens.bioDetailsExpSize * .75, Dimens.bioDetailsExpSize * .75)),
                    PaddedColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      padding: Dimens.bioDetailsExpPaddingVertical,
                      children: [
                        TextView(
                          text: name,
                          style: styles.headerStyle.copyWith(color: _c ?? theme.primaryColor),
                        ),
                        TextView(
                          text: _e.getTimeRangeStr(context),
                          style: styles.subheaderStyle.copyWith(
                            color: (_c ?? theme.colorScheme.onSurface).withValues(alpha: .8),
                            fontWeight: FontWeight.bold,
                          ),
                          spaced: true,
                        ),
                        TextView(
                          text: major,
                          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// endregion
