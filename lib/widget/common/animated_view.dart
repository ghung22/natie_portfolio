import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:natie_portfolio/global/strings.dart';
import 'package:natie_portfolio/global/vars.dart';
import 'package:natie_portfolio/store/common/animation_store.dart';
import 'package:natie_portfolio/store/global/language_store.dart';
import 'package:provider/provider.dart';

// TODO: Add disableAnimation & fix animation repeat bug
// TODO: (When change lang + When returned from ProjectPage)
class AnimatedFadeSlide extends ImplicitlyAnimatedWidget {
  const AnimatedFadeSlide({
    super.key,
    required this.child,
    required this.offset,
    required this.opacity,
    bool disableAnimation = false,
    Duration duration = Vars.animationFast,
    super.curve,
    super.onEnd,
  }) : assert(opacity >= 0.0 && opacity <= 1.0),
       super(duration: !disableAnimation ? duration : Duration.zero);

  final Widget child;
  final Offset offset;
  final double opacity;

  @override
  ImplicitlyAnimatedWidgetState<AnimatedFadeSlide> createState() => _AnimatedFadeSlideState();
}

class _AnimatedFadeSlideState extends ImplicitlyAnimatedWidgetState<AnimatedFadeSlide> {
  Tween<Offset>? _offset;
  late Animation<Offset> _offsetAnimation;
  Tween<double>? _opacity;
  late Animation<double> _opacityAnimation;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _offset = visitor(_offset, widget.offset, (value) => Tween<Offset>(begin: value as Offset)) as Tween<Offset>?;
    _opacity = visitor(_opacity, widget.opacity, (value) => Tween<double>(begin: value as double)) as Tween<double>?;
  }

  @override
  void didUpdateTweens() {
    _offsetAnimation = animation.drive(_offset!);
    _opacityAnimation = animation.drive(_opacity!);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(opacity: _opacityAnimation, child: widget.child),
    );
  }
}

class AnimatedHover extends StatefulWidget {
  final Widget child;
  final double scaleOnHover;
  final Duration duration;
  final VoidCallback? onPressed;
  final VoidCallback? onHover;
  final bool feedback;

  const AnimatedHover({
    super.key,
    required this.child,
    required this.scaleOnHover,
    required this.duration,
    this.onPressed,
    this.onHover,
    this.feedback = true,
  });

  @override
  State<AnimatedHover> createState() => _AnimatedHoverState();
}

class _AnimatedHoverState extends State<AnimatedHover> with SingleTickerProviderStateMixin {
  late double _scaleOnHover;
  late VoidCallback? _onPressed;
  late bool _feedback;

  final AnimationStore _ani = AnimationStore();

  @override
  void initState() {
    super.initState();
    _scaleOnHover = widget.scaleOnHover;
    _onPressed = widget.onPressed;
    _feedback = widget.feedback;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return InkWell(
          onTap: _onPressed ?? (_feedback ? () {} : null),
          mouseCursor: _feedback && _onPressed == null ? MouseCursor.uncontrolled : null,
          splashFactory: NoSplash.splashFactory,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          onHover: (isHover) {
            if (!_feedback) return;
            if (isHover) {
              _ani.start();
              widget.onHover?.call();
            } else {
              _ani.stop();
            }
          },
          child: AnimatedScale(scale: _ani.willStart ? _scaleOnHover : 1, duration: widget.duration, child: widget.child),
        );
      }
    );
  }
}

class AnimatedLanguageUpdate extends StatelessWidget {
  final Widget child;

  const AnimatedLanguageUpdate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final _ = Strings.of(context).language;
        return AnimatedOpacity(
          duration: Vars.animationFast,
          opacity: context.read<LanguageStore>().changingLanguage ? 0 : 1,
          child: child,
        );
      },
    );
  }
}
