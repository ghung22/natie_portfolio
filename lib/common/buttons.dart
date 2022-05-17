import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  final Widget icon;
  final Function()? onPressed;

  const IconBtn({
    Key? key,
    this.icon = const Icon(Icons.question_mark_rounded),
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Theme.of(context).colorScheme.onSurface,
        padding: EdgeInsets.zero,
        shape: const CircleBorder(),
      ),
      child: icon,
      onPressed: onPressed,
    );
  }
}

class ElevatedBtn extends StatelessWidget {
  final Widget text;
  final Function()? onPressed;
  final EdgeInsetsGeometry padding;
  final bool circular;

  const ElevatedBtn({
    Key? key,
    this.text = const Text(''),
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    this.circular = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: padding,
        shape: circular
            ? const CircleBorder()
            : const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
      ),
      onPressed: onPressed,
      child: text,
    );
  }
}