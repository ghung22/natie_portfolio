import 'package:flutter/cupertino.dart';

import 'content_item.dart';

class _Constants {
  static const List<Type> ignorePadding = [
    Nothing,
    IgnorePadding,
    PaddedColumn,
    PaddedRow,
    Column,
    Row,
    ListView,
    Expanded,
  ];
}

class PaddedColumn extends StatelessWidget {
  final EdgeInsets padding;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final bool paddingStartAndEnd;
  final List<Widget> children;

  const PaddedColumn({
    Key? key,
    required this.padding,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.paddingStartAndEnd = true,
    this.children = const <Widget>[],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      children: children.map((child) {
        if (_Constants.ignorePadding.contains(child.runtimeType)) {
          return child;
        }
        final noPad = !paddingStartAndEnd &&
            (child == children.first || child == children.last);
        return Padding(
          padding: noPad ? EdgeInsets.zero : padding,
          child: child,
        );
      }).toList(),
    );
  }
}

class PaddedRow extends StatelessWidget {
  final EdgeInsets padding;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final bool paddingStartAndEnd;
  final List<Widget> children;

  const PaddedRow({
    Key? key,
    required this.padding,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.paddingStartAndEnd = true,
    this.children = const <Widget>[],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      children: children.map((child) {
        if (_Constants.ignorePadding.contains(child.runtimeType)) return child;
        final noPad = !paddingStartAndEnd &&
            (child == children.first || child == children.last);
        return Padding(
          padding: noPad ? EdgeInsets.zero : padding,
          child: child,
        );
      }).toList(),
    );
  }
}

/// A wrapper to ignore padding in a padded widgets
class IgnorePadding extends StatelessWidget {
  final Widget child;

  const IgnorePadding({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => child;
}