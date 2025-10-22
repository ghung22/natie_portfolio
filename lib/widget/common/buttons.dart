import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:natie_portfolio/global/dimens.dart';
import 'package:natie_portfolio/global/routes.dart';
import 'package:natie_portfolio/global/strings.dart';
import 'package:natie_portfolio/global/styles.dart';
import 'package:natie_portfolio/global/vars.dart';
import 'package:natie_portfolio/store/global/language_store.dart';
import 'package:natie_portfolio/store/global/theme_store.dart';
import 'package:natie_portfolio/widget/common/animated_view.dart';
import 'package:natie_portfolio/widget/common/text_view.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import 'image_view.dart';

class IconBtn extends StatelessWidget {
  final Widget child;
  final Color? color;
  final String tooltipText;
  final VoidCallback? onPressed;
  final bool ignoreScreenSize;

  const IconBtn({
    super.key,
    required this.child,
    this.color,
    this.tooltipText = '',
    this.onPressed,
    this.ignoreScreenSize = true,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (Dimens.isSmall(context) || ignoreScreenSize) {
          return Tooltip(
            message: tooltipText,
            waitDuration: const Duration(seconds: 1),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: color ?? Theme.of(context).colorScheme.onSurface,
                padding: EdgeInsets.zero,
                shape: const CircleBorder(),
              ),
              onPressed: onPressed,
              child: child,
            ),
          );
        }
        return TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: color ?? Theme.of(context).colorScheme.onSurface,
            padding: Dimens.btnIconPaddingHorizontal,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.btnRadius)),
            textStyle: Styles.iconBtnLabelStyle,
          ),
          onPressed: onPressed,
          icon: child,
          label: TextView(text: tooltipText),
        );
      },
    );
  }
}

class TextBtn extends StatelessWidget {
  final Widget child;
  final TextStyle? textStyle;
  final bool hoverFeedback;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry? alignment;

  const TextBtn({
    super.key,
    required this.child,
    this.textStyle,
    this.hoverFeedback = true,
    this.onPressed,
    this.padding = Dimens.btnPadding,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(textStyle?.color),
        padding: WidgetStateProperty.all(padding),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Dimens.btnRadius))),
        ),
        textStyle: WidgetStateProperty.all(textStyle),
        splashFactory: hoverFeedback ? null : NoSplash.splashFactory,
        overlayColor: hoverFeedback ? null : WidgetStateProperty.all(Colors.transparent),
        alignment: alignment,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

class ElevatedBtn extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double elevation;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final bool circular;

  const ElevatedBtn({
    super.key,
    required this.child,
    this.color,
    this.elevation = Dimens.btnElevation,
    this.onPressed,
    this.padding = Dimens.btnPadding,
    this.circular = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedLanguageUpdate(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle: Styles.textBtnLabelStyle,
          backgroundColor: color ?? Theme.of(context).primaryColor,
          padding: padding,
          elevation: elevation,
          shape: circular
              ? const CircleBorder()
              : const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Dimens.btnRadius))),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

// region Leading buttons

class BackBtn extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const BackBtn({super.key, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (Routes.alwaysUseNavigationDrawer || !Routes.routemaster.history.canGoBack) {
          return NavBtn(scaffoldKey: scaffoldKey);
        }
        return IconBtn(
          tooltipText: AppLocalizations.of(context)!.back,
          onPressed: () => Routes.routemaster.pop(),
          ignoreScreenSize: false,
          child: const Icon(Icons.arrow_back_ios_new),
        );
      },
    );
  }
}

class NavBtn extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const NavBtn({super.key, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return IconBtn(
      tooltipText: AppLocalizations.of(context)!.navigation,
      onPressed: () {
        if (scaffoldKey != null) {
          scaffoldKey!.currentState!.openDrawer();
        } else {
          Vars.globalScaffoldKey.currentState!.openDrawer();
        }
      },
      ignoreScreenSize: false,
      child: const Icon(Icons.menu_rounded),
    );
  }
}

// endregion

// region Trailing buttons

class LanguageBtn extends StatelessWidget {
  const LanguageBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        // Build the button
        final isEn = Strings.of(context).isEn;
        return IconBtn(
          tooltipText: AppLocalizations.of(context)!.language,
          child: ImageView(
            (isEn ? Vars.assets['en'] : Vars.assets['vn']) ?? '',
            width: Dimens.iconBtnSize,
            errorWidget: Text(isEn ? Language.en.name : Language.vi.name, style: Styles.iconBtnErrorStyle),
          ),
          onPressed: () => context.read<LanguageStore>().setActiveLanguage(isEn ? Language.vi : Language.en),
        );
      },
    );
  }
}

class ThemeBtn extends StatelessWidget {
  const ThemeBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final isDark = Themes.isDarkMode(context);
        return IconBtn(
          tooltipText: AppLocalizations.of(context)!.theme,
          child: isDark ? const Icon(CupertinoIcons.moon) : const Icon(CupertinoIcons.sun_min),
          onPressed: () => context.read<ThemeStore>().setActiveTheme(isDark ? ThemeMode.light : ThemeMode.dark),
        );
      },
    );
  }
}

// endregion
