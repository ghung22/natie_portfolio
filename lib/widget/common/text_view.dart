import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:natie_portfolio/data/model/countable_double.dart';
import 'package:natie_portfolio/global/debug.dart';
import 'package:natie_portfolio/global/dimens.dart';
import 'package:natie_portfolio/global/mixin.dart';
import 'package:natie_portfolio/global/styles.dart';
import 'package:natie_portfolio/global/vars.dart';
import 'package:natie_portfolio/store/common/animation_store.dart';

import 'animated_view.dart';
import 'list_view.dart';

// region TextView

/// A Text widget nested in some of the most used widgets.
class TextView extends StatelessWidget {
  final String? text;
  final String Function()? textCallback;
  final Color? color;
  final TextStyle? style;
  final bool spaced;
  final EdgeInsets padding;
  final TextAlign textAlign;
  final bool softWrap;

  Widget get textWidget => Text(
    text ?? textCallback!(),
    textAlign: textAlign,
    softWrap: softWrap,
    style: style?.copyWith(
      color: color ?? style?.color,
      letterSpacing: spaced ? Styles.spacedTextStyle.letterSpacing : style?.letterSpacing,
    ),
  );

  const TextView({
    super.key,
    this.text,
    this.textCallback,
    this.color,
    this.style,
    this.spaced = false,
    this.padding = EdgeInsets.zero,
    this.textAlign = TextAlign.start,
    this.softWrap = false,
  }) : assert(text != null && textCallback == null || textCallback != null && text == null);

  TextView.header({
    super.key,
    this.text,
    this.textCallback,
    this.color,
    this.spaced = false,
    this.padding = EdgeInsets.zero,
    this.textAlign = TextAlign.start,
    this.softWrap = false,
  }) : style = Styles.headerStyle,
       assert(text != null && textCallback == null || textCallback != null && text == null);

  TextView.subheader({
    super.key,
    this.text,
    this.textCallback,
    this.color,
    this.spaced = false,
    this.padding = EdgeInsets.zero,
    this.textAlign = TextAlign.start,
    this.softWrap = false,
  }) : style = Styles.subheaderStyle,
       assert(text != null && textCallback == null || textCallback != null && text == null);

  TextView.footer({
    super.key,
    this.text,
    this.textCallback,
    this.color,
    this.spaced = false,
    this.padding = EdgeInsets.zero,
    this.textAlign = TextAlign.start,
    this.softWrap = false,
  }) : style = Styles.footerStyle,
       assert(text != null && textCallback == null || textCallback != null && text == null);

  @override
  Widget build(BuildContext context) {
    return AnimatedLanguageUpdate(
      child: Padding(
        padding: padding,
        child: text != null ? textWidget : Observer(builder: (context) => textWidget),
      ),
    );
  }
}

// endregion

// region AnimatedTypingText

/// A Text widget with typing animation and a blinking cursor
class AnimatedTypingText extends StatefulWidget {
  final String? text;
  final String Function()? textCallback;
  final Color? color;
  final TextStyle? style;
  final bool spaced;
  final EdgeInsets padding;
  final TextAlign textAlign;
  final bool softWrap;

  // Animation
  final bool disableAnimation;
  final bool showCursor;
  final bool blinkingCursor;
  final Duration stepDuration;
  final VoidCallback? onDone;

  const AnimatedTypingText({
    super.key,
    this.text,
    this.textCallback,
    this.color,
    this.style,
    this.spaced = false,
    this.padding = EdgeInsets.zero,
    this.textAlign = TextAlign.start,
    this.softWrap = false,
    this.disableAnimation = false,
    this.showCursor = true,
    this.blinkingCursor = true,
    this.stepDuration = Vars.animationFlash,
    this.onDone,
  }) : assert(text != null && textCallback == null || textCallback != null && text == null);

  @override
  State<AnimatedTypingText> createState() => _AnimatedTypingTextState();
}

class _AnimatedTypingTextState extends State<AnimatedTypingText> with PostFrameMixin {
  String _txt = '';

  final AnimationStore _ani = AnimationStore();

  String get _txtSub => _txt.substring(0, _ani.intData);

  String get _txtCursor {
    if (!widget.showCursor) return '';
    if (!widget.blinkingCursor) return '|';
    bool showing = DateTime.now().millisecond % 1000 < 500;
    return showing ? '|' : '';
  }

  @override
  void initState() {
    super.initState();
    _txt = widget.text ?? widget.textCallback!();
    _ani.setDataLimit(lowerLimit: 0, upperLimit: _txt.length);
    if (widget.disableAnimation) _ani.setData(_txt.length);
    postFrame(() {
      _ani.start();
      Timer.periodic(widget.stepDuration, (timer) {
        if (!mounted) timer.cancel();
        if (_ani.intDataMaxed) {
          timer.cancel();
          widget.onDone?.call();
        }
        _ani.increment();
        if (_txtSub.contains(RegExp(r'[\s\t\n]$'))) _ani.increment();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return TextView(
          text: '$_txtSub$_txtCursor',
          color: widget.color,
          style: widget.style,
          spaced: widget.spaced,
          padding: widget.padding,
          textAlign: widget.textAlign,
          softWrap: widget.softWrap,
        );
      },
    );
  }
}

// endregion

// region AnimatedCountingText

class AnimatedCountingText extends StatefulWidget {
  final double value;
  final Color? color;
  final TextStyle? style;
  final bool spaced;
  final EdgeInsets padding;

  // Animation
  final bool disableAnimation;
  final double? dimension;
  final Duration duration;
  final Duration? stepDuration;
  final bool showIndicator;
  final double? indicatorWidth;
  final Widget? topSide;
  final Widget? bottomSide;
  final VoidCallback? onDone;

  const AnimatedCountingText({
    super.key,
    required this.value,
    this.color,
    this.style,
    this.spaced = false,
    this.padding = EdgeInsets.zero,
    this.disableAnimation = false,
    this.dimension,
    this.duration = const Duration(seconds: 2),
    this.stepDuration,
    this.showIndicator = true,
    this.indicatorWidth,
    this.topSide,
    this.bottomSide,
    this.onDone,
  });

  @override
  State<AnimatedCountingText> createState() => _AnimatedCountingTextState();
}

class _AnimatedCountingTextState extends State<AnimatedCountingText> with PostFrameMixin {
  late CountableDouble _value;
  Color _color = Colors.transparent;
  late Duration _stepDuration;

  final GlobalKey _stackKey = GlobalKey();
  final AnimationStore _ani = AnimationStore();

  double? get _stackSize {
    final rb = _stackKey.currentContext?.findRenderObject() as RenderBox?;
    if (rb == null) return null;
    return rb.size.height > rb.size.width ? rb.size.height : rb.size.width;
  }

  num get _strokeWidth {
    if (widget.indicatorWidth != null) return widget.indicatorWidth!;
    return 4 * ((widget.dimension ?? _stackSize ?? 0) / 100).floor().clamp(1, double.infinity);
  }

  @override
  void initState() {
    super.initState();
    _value = CountableDouble(widget.value);
    _ani.setDataLimit(lowerLimit: 0, upperLimit: _value.countValue);
    if (widget.disableAnimation) _ani.setData(_value.countValue);
    final stepValue = (_value.countValue / 100).ceil().clamp(1, double.infinity).toInt();
    _stepDuration =
        widget.stepDuration ?? Duration(microseconds: widget.duration.inMicroseconds ~/ _value.countValue ~/ stepValue);
    Debug.log(
      'Step: $stepValue ticks/'
      '${_stepDuration.inMicroseconds}μs/'
      '${widget.duration.inMilliseconds}ms',
      caller: 'AnimatedCountingText',
    );
    postFrame(() {
      _color = widget.color ?? Theme.of(context).primaryColor;
      _ani.start();
      Timer.periodic(_stepDuration, (timer) {
        if (!mounted) timer.cancel();
        if (_ani.intDataMaxed) {
          timer.cancel();
          widget.onDone?.call();
        }
        _ani.setData(_ani.intData + stepValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return SizedBox.square(
          dimension: widget.dimension ?? _stackSize,
          child: Stack(
            key: _stackKey,
            alignment: Alignment.center,
            children: [
              if (widget.showIndicator)
                Positioned.fill(
                  child: Observer(
                    builder: (context) {
                      return TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: _ani.intData / _value.countValue),
                        curve: Curves.easeInOut,
                        duration: _stepDuration,
                        builder: (context, value, _) {
                          return CircularProgressIndicator(
                            value: value.toDouble(),
                            valueColor: AlwaysStoppedAnimation(_color),
                            color: MoreColors.lighter(_color),
                            strokeWidth: _strokeWidth.toDouble(),
                          );
                        },
                      );
                    },
                  ),
                ),
              Opacity(
                opacity: 0,
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.cardPadding),
                  child: PaddedColumn(
                    padding: widget.padding,
                    children: [
                      if (widget.topSide != null) widget.topSide!,
                      TextView(
                        text: '$_value',
                        style: widget.style,
                        spaced: widget.spaced,
                        textAlign: TextAlign.start,
                        softWrap: false,
                      ),
                      if (widget.bottomSide != null) widget.bottomSide!,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimens.cardPadding),
                child: PaddedColumn(
                  padding: widget.padding,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.topSide != null) widget.topSide!,
                    TextView(
                      text: _value.parseCurrentValue(_ani.intData),
                      color: widget.color,
                      style: widget.style,
                      spaced: widget.spaced,
                      textAlign: TextAlign.start,
                      softWrap: false,
                    ),
                    if (widget.bottomSide != null) widget.bottomSide!,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// endregion
