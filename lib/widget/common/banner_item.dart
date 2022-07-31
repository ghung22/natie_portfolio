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
/// * [imageUrl]    : The image to be shown on the right side of the banner
/// * [primary]     : Main color of the banner
/// * [action]      : The button to be shown below the description
/// * [onAction]    : The function to be called when the button is pressed
/// * [leftSide]    : The left side of the banner, overrides [title] and such
/// * [rightSide]   : The right side of the banner, overrides the image widget
/// --------------------------------------------------------------------------
class BannerItem extends StatefulWidget {
  final Widget title;
  final Widget description;
  final String imageUrl;
  final Color? primary;
  final Widget? action;
  final VoidCallback? onAction;
  final Widget? leftSide;
  final Widget? rightSide;

  const BannerItem({
    Key? key,
    required this.title,
    required this.description,
    this.imageUrl = '',
    this.primary,
    this.action,
    this.onAction,
    this.leftSide,
    this.rightSide,
  }) : super(key: key);

  @override
  State<BannerItem> createState() => _BannerItemState();
}

class _BannerItemState extends State<BannerItem> with PostFrameMixin {
  late Widget _title;
  late Widget _description;
  late String _imageUrl;
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
    _imageUrl = widget.imageUrl;
    _primary = widget.primary ?? Colors.transparent;
    _action = widget.action;
    _onAction = widget.onAction;

    postFrame(() {
      _initLeftSide();
      _initRightSide();
    });
  }

  void _initLeftSide() {
    _leftSide = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.bannerPaddingHorizontal,
        vertical: Dimens.bannerPaddingVertical,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: Dimens.bannerContentLeftMaxWidth,
        ),
        child: PaddedColumn(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          padding:
              const EdgeInsets.symmetric(vertical: Dimens.bannerContentPadding),
          children: [
            Material(
              color: Colors.transparent,
              textStyle: Styles.bannerTitleStyle
                  .copyWith(color: MoreColors.onColor(_primary)),
              child: _title,
            ),
            Material(
              color: Colors.transparent,
              textStyle: Styles.bannerDescriptionStyle
                  .copyWith(color: MoreColors.onColor(_primary)),
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
        ),
      ),
    );
  }

  void _initRightSide() {
    _rightSide = Align(
      alignment: Alignment.bottomRight,
      child: ImageView(
        _imageUrl,
        onFinish: () {
          if (!_introAni.willStart) _introAni.start();
        },
      ),
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
      child: Container(
        width: double.infinity,
        height: Dimens.bannerHeight,
        color: _primary,
        child: Observer(builder: (context) {
          return Stack(
            children: [
              widget.rightSide != null
                  ? widget.rightSide!
                  : FadeSlideAnimation(
                      offset: _introAni.willStart
                          ? Offset.zero
                          : const Offset(Dimens.bannerSlideOffset, 0),
                      opacity: _introAni.willStart ? 1 : 0,
                      duration: Vars.animationSluggish,
                      curve: Curves.easeOut,
                      child: _rightSide,
                    ),
              widget.leftSide != null
                  ? widget.leftSide!
                  : FadeSlideAnimation(
                offset: _introAni.willStart
                    ? Offset.zero
                    : const Offset(-Dimens.bannerSlideOffset, 0),
                opacity: _introAni.willStart ? 1 : 0,
                duration: Vars.animationSluggish,
                curve: Curves.easeOut,
                child: _leftSide,
              ),
            ],
          );
        }),
      ),
    );
  }
}

class ProjectBanner extends StatelessWidget {
  final Project project;
  final VoidCallback? onAction;
  final bool isHomePage;

  const ProjectBanner({
    Key? key,
    required this.project,
    this.onAction,
    this.isHomePage = false,
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
        imageUrl: project.imageUrls.isNotEmpty ? project.imageUrls[0] : '',
        primary: project.color,
        action: onAction == null
            ? null
            : Observer(builder: (context) {
                Strings.isEn;
                return TextView(text: AppLocalizations.of(context)!.explore);
              }),
        onAction: onAction,
      );

  @override
  Widget build(BuildContext context) {
    if (isHomePage) {
      return Hero(
        tag: '${Routes.project}/${project.id}/banner',
        child: _bannerWidget,
      );
    } else {
      return _bannerWidget;
    }
  }
}

class BioBanner extends StatelessWidget {
  final Bio bio;
  final VoidCallback? onAction;

  const BioBanner({
    Key? key,
    required this.bio,
    this.onAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bio.isEmpty) return const Nothing();
    return BannerItem(
      title: Observer(builder: (context) {
        Strings.isEn;
        return TextView(
          text: AppLocalizations.of(context)!.welcome(bio.name),
          softWrap: true,
        );
      }),
      description: Observer(builder: (context) {
        return TextView(
          text: Strings.isEn ? bio.description : bio.descriptionVi,
          spaced: true,
          softWrap: true,
        );
      }),
      imageUrl: bio.avatarUrl,
      // primary: bio.colors,
      primary: Colors.white,
      action: Observer(builder: (context) {
        Strings.isEn;
        return TextView(text: AppLocalizations.of(context)!.details);
      }),
      onAction: onAction,
    );
  }
}