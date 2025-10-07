import 'package:flutter/material.dart';

enum SnackbarType {
  info,
  positive,
  negative,
}

class Snackbars {
  static void showSnackbar(BuildContext context, SnackbarType type, String text,
      {String? actionLabel, VoidCallback? onAction}) {
    final ms = ScaffoldMessenger.of(context);
    ms.clearSnackBars();
    switch (type) {
      case SnackbarType.info:
        ms.showSnackBar(InfoSnackbar(
          context: context,
          text: text,
          actionLabel: actionLabel,
          onAction: onAction,
        ));
        return;
      case SnackbarType.positive:
        ms.showSnackBar(PositiveSnackbar(
          context: context,
          text: text,
          actionLabel: actionLabel,
          onAction: onAction,
        ));
        return;
      case SnackbarType.negative:
        ms.showSnackBar(NegativeSnackbar(
          context: context,
          text: text,
          actionLabel: actionLabel,
          onAction: onAction,
        ));
        return;
    }
  }
}

class InfoSnackbar extends SnackBar {
  final BuildContext context;
  final String text;
  final String? actionLabel;
  final VoidCallback? onAction;

  InfoSnackbar({
    super.key,
    required this.context,
    required this.text,
    this.actionLabel,
    this.onAction,
  }) : super(
          content: Text(text),
          action: actionLabel == null
              ? null
              : SnackBarAction(
                  label: actionLabel,
                  onPressed: onAction ?? () {},
                ),
        );
}

class PositiveSnackbar extends SnackBar {
  final BuildContext context;
  final String text;
  final String? actionLabel;
  final VoidCallback? onAction;

  PositiveSnackbar({
    super.key,
    required this.context,
    required this.text,
    this.actionLabel,
    this.onAction,
  }) : super(
          content: Text(text),
          backgroundColor: Theme.of(context).primaryColor,
          action: actionLabel == null
              ? null
              : SnackBarAction(
                  label: actionLabel,
                  onPressed: onAction ?? () {},
                ),
        );
}

class NegativeSnackbar extends SnackBar {
  final BuildContext context;
  final String text;
  final String? actionLabel;
  final VoidCallback? onAction;

  NegativeSnackbar({
    super.key,
    required this.context,
    required this.text,
    this.actionLabel,
    this.onAction,
  }) : super(
          content: Text(text),
          backgroundColor: Theme.of(context).colorScheme.error,
          action: actionLabel == null
              ? null
              : SnackBarAction(
                  label: actionLabel,
                  onPressed: onAction ?? () {},
                ),
        );
}