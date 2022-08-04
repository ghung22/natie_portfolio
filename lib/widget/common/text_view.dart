import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:natie_portfolio/global/mixin.dart';
import 'package:natie_portfolio/global/styles.dart';
import 'package:natie_portfolio/global/vars.dart';
import 'package:natie_portfolio/store/common/animation_store.dart';

import 'animated_view.dart';

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
          letterSpacing: spaced
              ? Styles.spacedTextStyle.letterSpacing
              : style?.letterSpacing,
        ),
      );

  const TextView({
    Key? key,
    this.text,
    this.textCallback,
    this.color,
    this.style,
    this.spaced = false,
    this.padding = EdgeInsets.zero,
    this.textAlign = TextAlign.start,
    this.softWrap = false,
  })  : assert(text != null && textCallback == null ||
            textCallback != null && text == null),
        super(key: key);

  TextView.header({
    Key? key,
    this.text,
    this.textCallback,
    this.color,
    this.spaced = false,
    this.padding = EdgeInsets.zero,
    this.textAlign = TextAlign.start,
    this.softWrap = false,
  })  : style = Styles.headerStyle,
        assert(text != null && textCallback == null ||
            textCallback != null && text == null),
        super(key: key);

  TextView.subheader({
    Key? key,
    this.text,
    this.textCallback,
    this.color,
    this.spaced = false,
    this.padding = EdgeInsets.zero,
    this.textAlign = TextAlign.start,
    this.softWrap = false,
  })  : style = Styles.subheaderStyle,
        assert(text != null && textCallback == null ||
            textCallback != null && text == null),
        super(key: key);

  TextView.footer({
    Key? key,
    this.text,
    this.textCallback,
    this.color,
    this.spaced = false,
    this.padding = EdgeInsets.zero,
    this.textAlign = TextAlign.start,
    this.softWrap = false,
  })  : style = Styles.footerStyle,
        assert(text != null && textCallback == null ||
            textCallback != null && text == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedLanguageUpdate(
      child: Padding(
        padding: padding,
        child: text != null
            ? textWidget
            : Observer(builder: (context) => textWidget),
      ),
    );
  }
}

class AnimatedTypingText extends StatefulWidget {
  final String? text;
  final String Function()? textCallback;
  final Color? color;
  final TextStyle? style;
  final bool spaced;
  final EdgeInsets padding;
  final TextAlign textAlign;
  final bool softWrap;
  final bool showCursor;
  final bool blinkingCursor;
  final Duration stepDuration;
  final VoidCallback? onDone;

  const AnimatedTypingText({
    Key? key,
    this.text,
    this.textCallback,
    this.color,
    this.style,
    this.spaced = false,
    this.padding = EdgeInsets.zero,
    this.textAlign = TextAlign.start,
    this.softWrap = false,
    this.showCursor = true,
    this.blinkingCursor = true,
    this.stepDuration = Vars.animationFlash,
    this.onDone,
  })  : assert(text != null && textCallback == null ||
            textCallback != null && text == null),
        super(key: key);

  @override
  State<AnimatedTypingText> createState() => _AnimatedTypingTextState();
}

class _AnimatedTypingTextState extends State<AnimatedTypingText>
    with PostFrameMixin {
  String _txt = '';

  final AnimationStore animationStore = AnimationStore();

  String get _txtSub => _txt.substring(0, animationStore.intData);

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
    animationStore.setDataLimit(
      lowerLimit: 0,
      upperLimit: _txt.length,
    );
    postFrame(() {
      animationStore.start();
      Timer.periodic(Vars.animationFlash, (timer) {
        if (!mounted) timer.cancel();
        if (animationStore.intDataMaxed) {
          timer.cancel();
          widget.onDone?.call();
        }
        animationStore.increment();
        if (_txtSub.contains(RegExp(r'[\s\t\n]$'))) animationStore.increment();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return TextView(
        text: '$_txtSub$_txtCursor',
        color: widget.color,
        style: widget.style,
        spaced: widget.spaced,
        padding: widget.padding,
        textAlign: widget.textAlign,
        softWrap: widget.softWrap,
      );
    });
  }
}