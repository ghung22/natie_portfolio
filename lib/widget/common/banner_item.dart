import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:natie_portfolio/data/model/bio.dart';
import 'package:natie_portfolio/data/model/project.dart';
import 'package:natie_portfolio/global/dimens.dart';
import 'package:natie_portfolio/global/mixin.dart';
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

class BannerItem extends StatefulWidget {
  final Widget title;
  final Widget description;
  final String imageUrl;
  final Color? primary;
  final Widget? action;
  final VoidCallback? onAction;

  const BannerItem({
    Key? key,
    required this.title,
    required this.description,
    this.imageUrl = '',
    this.primary,
    this.action,
    this.onAction,
  }) : super(key: key);

  @override
  State<BannerItem> createState() => _BannerItemState();
}

class _BannerItemState extends State<BannerItem> with PostFrameMixin {
  late Widget _title;
  late Widget _description;
  late String _imageUrl;
  late Color _primary;
  late Widget? _actionLabel;
  late VoidCallback? _onAction;

  Color _textColor = Colors.white;
  Color _actionColor = Colors.white;
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
    _actionLabel = widget.action;
    _onAction = widget.onAction;

    postFrame(() {
      _initValues();
      _initLeftSide();
      _initRightSide();
    });
  }

  void _initValues() {
    _textColor = _primary.computeLuminance() > .5 ? Colors.black : Colors.white;
    final hsl = HSLColor.fromColor(_primary);
    _actionColor =
        hsl.withLightness((hsl.lightness + .2).clamp(0, 1)).toColor();
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
              child: _title,
              color: Colors.transparent,
              textStyle: Styles.bannerTitleStyle.copyWith(color: _textColor),
            ),
            Material(
              child: _description,
              color: Colors.transparent,
              textStyle:
                  Styles.bannerDescriptionStyle.copyWith(color: _textColor),
            ),
            if (_actionLabel != null)
              Padding(
                padding: const EdgeInsets.all(Dimens.bannerActionOffset),
                child: ElevatedBtn(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimens.bannerActionPaddingVertical,
                    horizontal: Dimens.bannerActionPaddingHorizontal,
                  ),
                  child: Material(
                    child: _actionLabel,
                    color: Colors.transparent,
                    textStyle: Styles.bannerActionStyle,
                  ),
                  onPressed: _onAction,
                  color: _actionColor,
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
              FadeSlideAnimation(
                offset: _introAni.willStart
                    ? Offset.zero
                    : const Offset(Dimens.bannerSlideOffset, 0),
                opacity: _introAni.willStart ? 1 : 0,
                duration: Vars.animationSluggish,
                curve: Curves.easeOut,
                child: _rightSide,
              ),
              FadeSlideAnimation(
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

  const ProjectBanner({
    Key? key,
    required this.project,
    this.onAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BannerItem(
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
      action: Observer(builder: (context) {
        Strings.isEn;
        return TextView(text: AppLocalizations.of(context)!.explore);
      }),
      onAction: onAction,
    );
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
      title: Observer(
        builder: (context) {
          Strings.isEn;
          return TextView(
            text: AppLocalizations.of(context)!.welcome(bio.name),
            softWrap: true,
          );
        }
      ),
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