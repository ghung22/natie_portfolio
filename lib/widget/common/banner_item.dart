import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:natie_portfolio/data/model/bio.dart';
import 'package:natie_portfolio/data/model/project.dart';
import 'package:natie_portfolio/global/dimens.dart';
import 'package:natie_portfolio/global/mixin.dart';
import 'package:natie_portfolio/global/router.dart';
import 'package:natie_portfolio/global/strings.dart';
import 'package:natie_portfolio/global/styles.dart';
import 'package:natie_portfolio/global/vars.dart';
import 'package:natie_portfolio/store/common/animation_store.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'animated_view.dart';
import 'buttons.dart';
import 'content_item.dart';
import 'image_view.dart';
import 'list_view.dart';
import 'text_view.dart';

/// --------------------------------------------------------------------------
/// **A standard banner with text, image and a button**
/// **Parameters:**
/// * [title]       : The title widget to be shown on top left
/// * [description] : The description widget to be shown below the title
/// * [imageUrls]    : The images to be shown on the right side of the banner
/// * [primary]     : Main color of the banner
/// * [action]      : The button to be shown below the description
/// * [onAction]    : The function to be called when the button is pressed
/// * [leftSide]    : The left side of the banner, overrides [title] and such
/// * [rightSide]   : The right side of the banner, overrides the image widget
/// --------------------------------------------------------------------------
class BannerItem extends StatefulWidget {
  final Widget? title;
  final Widget? description;
  final List<String> imageUrls;
  final bool imageRounded;
  final Color? primary;
  final Widget? action;
  final VoidCallback? onAction;
  final Widget? leftSide;
  final Widget? rightSide;
  final bool disableAnimation;
  final Function()? onAnimationDone;

  const BannerItem({
    Key? key,
    required this.title,
    required this.description,
    this.imageUrls = const [],
    this.imageRounded = false,
    this.primary,
    this.action,
    this.onAction,
    this.leftSide,
    this.rightSide,
    this.disableAnimation = false,
    this.onAnimationDone,
  }) : super(key: key);

  @override
  State<BannerItem> createState() => _BannerItemState();
}

class _BannerItemState extends State<BannerItem> with PostFrameMixin {
  late Widget? _title;
  late Widget? _description;
  late List<String> _imageUrls;
  late Color _primary;
  late Widget? _action;
  late VoidCallback? _onAction;

  Widget _leftSide = const Nothing();
  Widget _rightSide = const Nothing();

  final AnimationStore _introAni = AnimationStore();

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _description = widget.description;
    _imageUrls = widget.imageUrls;
    _primary = widget.primary ?? Colors.transparent;
    _action = widget.action;
    _onAction = widget.onAction;

    postFrame(() {
      if (widget.leftSide == null) _initLeftSide();
      if (widget.rightSide == null) _initRightSide();
    });
  }

  void _initLeftSide() {
    _leftSide = PaddedColumn(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      padding:
          const EdgeInsets.symmetric(vertical: Dimens.bannerContentPadding),
      children: [
        if (_title != null)
          Material(
            color: Colors.transparent,
            textStyle: Styles.bannerTitleStyle.copyWith(
              color: MoreColors.onColor(_primary),
              shadows: [
                Shadow(
                  color: MoreColors.onColorShadow(_primary),
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: _title,
          ),
        if (_description != null)
          Material(
            color: Colors.transparent,
            textStyle: Styles.bannerDescriptionStyle.copyWith(
              color: MoreColors.onColor(_primary),
              shadows: [
                Shadow(
                  color: MoreColors.onColorShadow(_primary),
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: _description,
          ),
        if (_action != null)
          Padding(
            padding: const EdgeInsets.all(Dimens.bannerActionOffset),
            child: ElevatedBtn(
              padding: const EdgeInsets.symmetric(
                vertical: Dimens.bannerActionPaddingVertical,
                horizontal: Dimens.bannerActionPaddingHorizontal,
              ),
              onPressed: _onAction,
              color: MoreColors.lighter(_primary),
              child: Material(
                color: Colors.transparent,
                textStyle: Styles.bannerActionStyle,
                child: _action,
              ),
            ),
          ),
      ],
    );
  }

  void _initRightSide() {
    _rightSide = Align(
      alignment: Alignment.bottomRight,
      child: CarouselSlider(
          items: _imageUrls.map((url) {
            if (!widget.imageRounded) {
              if (_imageUrls.first == url) {
                return ImageView(url, onFinish: () {
                  if (!_introAni.willStart) _introAni.start();
                });
              }
              return ImageView(url);
            } else {
              if (_imageUrls.first == url) {
                return RoundedImageView(url, onFinish: () {
                  if (!_introAni.willStart) _introAni.start();
                });
              }
              return RoundedImageView(url);
            }
          }).toList(),
          options: CarouselOptions(
            aspectRatio: 9 / 16,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: Vars.animationFast,
            disableCenter: true,
            viewportFraction: 1,
            enlargeCenterPage: true,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('${widget.runtimeType}_${widget.hashCode}'),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction > .1) {
          if (!_introAni.willStart) _introAni.start();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: Dimens.bannerHeight,
            color: _primary,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
                minHeight: Dimens.bannerHeight,
                maxHeight: Dimens.bannerHeight,
                maxWidth: Dimens.pageContentMaxWidth),
            child: Stack(
              children: [
                // Right side below everything
                Builder(builder: (context) {
                  if (widget.rightSide != null) return widget.rightSide!;
                  return Observer(builder: (context) {
                    return AnimatedFadeSlide(
                      offset: _introAni.willStart
                          ? Offset.zero
                          : const Offset(Dimens.bannerSlideOffset, 0),
                      opacity: _introAni.willStart ? 1 : 0,
                      duration: Vars.animationSluggish,
                      curve: Curves.easeOut,
                      onEnd: widget.onAnimationDone,
                      disableAnimation: widget.disableAnimation,
                      child: _rightSide,
                    );
                  });
                }),

                // Left side, on top of the right
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.bannerPaddingHorizontal,
                    vertical: Dimens.bannerPaddingVertical,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: Dimens.bannerContentLeftMaxWidth,
                    ),
                    child: Builder(builder: (context) {
                      if (widget.leftSide != null) return widget.leftSide!;
                      return Observer(builder: (context) {
                        return AnimatedFadeSlide(
                          offset: _introAni.willStart
                              ? Offset.zero
                              : const Offset(-Dimens.bannerSlideOffset, 0),
                          opacity: _introAni.willStart ? 1 : 0,
                          duration: Vars.animationSluggish,
                          curve: Curves.easeOut,
                          disableAnimation: widget.disableAnimation,
                          child: _leftSide,
                        );
                      });
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectBanner extends StatelessWidget {
  final Project project;
  final VoidCallback? onAction;
  final bool isHomePage;
  final bool skipIntro;
  final Function()? onIntroDone;

  const ProjectBanner({
    Key? key,
    required this.project,
    this.onAction,
    this.isHomePage = false,
    this.skipIntro = false,
    this.onIntroDone,
  }) : super(key: key);

  Widget get _bannerWidget => BannerItem(
        title: TextView(text: project.title),
        description: Observer(builder: (context) {
          return TextView(
            text: Strings.isEn ? project.description : project.descriptionVi,
            spaced: true,
            softWrap: true,
          );
        }),
        imageUrls: project.imageUrls,
        imageRounded: true,
        primary: project.color,
        action: onAction == null
            ? null
            : Observer(builder: (context) {
                Strings.isEn;
                return TextView(text: AppLocalizations.of(context)!.explore);
              }),
        onAction: onAction,
        disableAnimation: skipIntro,
        onAnimationDone: onIntroDone,
      );

  @override
  Widget build(BuildContext context) {
    if (!isHomePage) {
      return _bannerWidget;
    }
    return Hero(
      tag: '${Routes.project}/${project.id}/banner',
      child: _bannerWidget,
    );
  }
}

class BioBanner extends StatelessWidget {
  final Bio bio;
  final bool skipIntro;
  final Function()? onIntroDone;

  final AnimationStore _introAni = AnimationStore();
  final AnimationStore _introSecondAni = AnimationStore();

  BioBanner({
    Key? key,
    required this.bio,
    this.skipIntro = false,
    this.onIntroDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bio.isEmpty) return const Nothing();
    Widget leftSide = PaddedColumn(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      padding:
          const EdgeInsets.symmetric(vertical: Dimens.bannerContentPadding),
      children: [
        Observer(builder: (context) {
          Strings.isEn;
          return AnimatedFadeSlide(
            offset: _introAni.willStart
                ? Offset.zero
                : const Offset(0, Dimens.bannerSlideOffset),
            opacity: _introAni.willStart ? 1 : 0,
            duration: Vars.animationSluggish,
            curve: Curves.easeOut,
            child: AnimatedTypingText(
              text: AppLocalizations.of(context)!.welcome(bio.name),
              style: Styles.bannerTitleStyle,
              softWrap: true,
              disableAnimation: skipIntro,
              onDone: () => _introSecondAni.start(),
            ),
          );
        }),
        Observer(builder: (context) {
          return AnimatedFadeSlide(
            offset: _introSecondAni.willStart
                ? Offset.zero
                : const Offset(0, Dimens.bannerSlideOffset),
            opacity: _introSecondAni.willStart ? 1 : 0,
            duration: Vars.animationSluggish,
            curve: Curves.easeOut,
            child: TextView(
              text: Strings.isEn ? bio.description : bio.descriptionVi,
              style: Styles.bannerDescriptionStyle,
              spaced: true,
              softWrap: true,
            ),
          );
        }),
        const SizedBox(height: Dimens.bannerContentPadding),
        Observer(builder: (context) {
          return AnimatedFadeSlide(
            offset: _introSecondAni.willStart
                ? Offset.zero
                : const Offset(0, Dimens.bannerSlideOffset),
            opacity: _introSecondAni.willStart ? 1 : 0,
            duration: Vars.animationSluggish,
            curve: Curves.easeOut,
            child: PaddedRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.bioScorePadding),
              paddingStartAndEnd: false,
              children: [
                ...bio.scores.map((s) {
                  return AnimatedCountingText(
                    value: s.score,
                    color: Colors.white,
                    dimension: Dimens.bioScoreSize,
                    style: Styles.scoreValueStyle,
                    spaced: true,
                    disableAnimation: skipIntro,
                    topSide: TextView(
                      text: s.name,
                      style: Styles.scoreNameStyle,
                      spaced: true,
                    ),
                  );
                }),
              ],
            ),
          );
        }),
      ],
    );

    Widget rightSide = Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(
            right: Dimens.bioRightSidePadding,
            bottom: Dimens.bioRightSidePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Observer(builder: (context) {
              return AnimatedFadeSlide(
                offset: _introSecondAni.willStart
                    ? Offset.zero
                    : const Offset(0, Dimens.bannerSlideOffset),
                opacity: _introSecondAni.willStart ? 1 : 0,
                duration: Vars.animationFast,
                curve: Curves.easeOut,
                child: SpeechBubble(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.cardPadding),
                    child:
                        TextView(text: AppLocalizations.of(context)!.see_more),
                  ),
                ),
              );
            }),
            const SizedBox(height: Dimens.bioScorePadding),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: Dimens.bioHeight),
              child: AnimatedHover(
                scaleOnHover: 1.2,
                duration: Vars.animationFast,
                onPressed: () => Navigator.of(context).pushNamed(Routes.about),
                child: Hero(
                  tag: '${Routes.about}/avatar',
                  child: DecoratedBox(
                    decoration: const ShapeDecoration(
                        shape: CircleBorder(
                      side: BorderSide(
                        color: Colors.white,
                        width: Dimens.bioAvatarBorderSize,
                      ),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(Dimens.bioAvatarPadding),
                      child: CircleImageView(
                        bio.avatarUrl,
                        onFinish: () {
                          if (!_introAni.willStart) _introAni.start();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return BannerItem(
      title: null,
      description: null,
      primary: bio.colors.first,
      leftSide: leftSide,
      rightSide: Observer(builder: (context) {
        return AnimatedFadeSlide(
          offset: _introAni.willStart
              ? Offset.zero
              : const Offset(-Dimens.bannerSlideOffset, 0),
          opacity: _introAni.willStart ? 1 : 0,
          duration: Vars.animationSluggish,
          curve: Curves.easeOut,
          child: rightSide,
        );
      }),
      disableAnimation: skipIntro,
      onAnimationDone: onIntroDone,
    );
  }
}