import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:natie_portfolio/global/dimens.dart';

class WebAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final bool primary;
  final double toolbarOpacity;
  final double bottomOpacity;
  final double? leadingWidth;

  const WebAppBar({
    Key? key,
    this.leading,
    this.automaticallyImplyLeading = false,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.primary = true,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.leadingWidth,
  }) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, kToolbarHeight),
      child: Observer(builder: (context) {
        return Stack(
          children: [
            AppBar(
              leading: Dimens.isMedium ? leading : null,
              automaticallyImplyLeading: automaticallyImplyLeading,
              title: title,
              actions: actions,
              flexibleSpace: flexibleSpace,
              bottom: bottom,
              primary: primary,
              toolbarOpacity: toolbarOpacity,
              bottomOpacity: bottomOpacity,
              leadingWidth: leadingWidth,
            ),
            if (!Dimens.isMedium && leading != null)
              Align(
                alignment: Alignment.centerLeft,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: kToolbarHeight),
                  child: leading!,
                ),
              ),
          ],
        );
      }),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}