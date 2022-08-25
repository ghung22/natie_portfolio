import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:natie_portfolio/global/dimens.dart';
import 'package:natie_portfolio/global/strings.dart';
import 'package:natie_portfolio/global/styles.dart';
import 'package:natie_portfolio/store/global/language_store.dart';
import 'package:natie_portfolio/store/global/theme_store.dart';
import 'package:natie_portfolio/widget/common/animated_view.dart';
import 'package:natie_portfolio/widget/common/text_view.dart';
import 'package:provider/provider.dart';

import 'content_item.dart';
import 'image_view.dart';

class IconBtn extends StatelessWidget {
  final Widget child;
  final Color? color;
  final String tooltipText;
  final VoidCallback? onPressed;
  final bool ignoreScreenSize;

  const IconBtn({
    Key? key,
    required this.child,
    this.color,
    this.tooltipText = '',
    this.onPressed,
    this.ignoreScreenSize = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (Dimens.isSmall || ignoreScreenSize) {
        return Tooltip(
          message: tooltipText,
          waitDuration: const Duration(seconds: 1),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: color ?? Theme.of(context).colorScheme.onSurface,
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
          primary: color ?? Theme.of(context).colorScheme.onSurface,
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.btnIconPaddingHorizontal),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.btnRadius),
          ),
          textStyle: Styles.iconBtnLabelStyle,
        ),
        onPressed: onPressed,
        icon: child,
        label: TextView(text: tooltipText),
      );
    });
  }
}

class TextBtn extends StatelessWidget {
  final Widget child;
  final TextStyle? textStyle;
  final bool hoverFeedback;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;

  const TextBtn({
    Key? key,
    required this.child,
    this.textStyle,
    this.hoverFeedback = true,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(
      horizontal: Dimens.btnPaddingHorizontal,
      vertical: Dimens.btnPaddingVertical,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(textStyle?.color),
        padding: MaterialStateProperty.all(padding),
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.btnRadius)),
        )),
        textStyle: MaterialStateProperty.all(textStyle),
        splashFactory: hoverFeedback ? null : NoSplash.splashFactory,
        overlayColor: hoverFeedback
            ? null
            : MaterialStateProperty.all(Colors.transparent),
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
    Key? key,
    required this.child,
    this.color,
    this.elevation = Dimens.btnElevation,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(
      horizontal: Dimens.btnPaddingHorizontal,
      vertical: Dimens.btnPaddingVertical,
    ),
    this.circular = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedLanguageUpdate(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color ?? Theme.of(context).primaryColor,
          padding: padding,
          elevation: elevation,
          shape: circular
              ? const CircleBorder()
              : const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimens.btnRadius)),
                ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

// region Leading buttons

class BackBtn extends StatelessWidget {
  const BackBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (!Navigator.of(context).canPop()) return const Nothing();
      return IconBtn(
        tooltipText: AppLocalizations.of(context)!.back,
        onPressed: () => Navigator.of(context).pop(),
        ignoreScreenSize: false,
        child: const Icon(Icons.arrow_back_ios_new),
      );
    });
  }
}

class NavBtn extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const NavBtn({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconBtn(
      tooltipText: AppLocalizations.of(context)!.navigation,
      onPressed: () => scaffoldKey.currentState!.openDrawer(),
      ignoreScreenSize: false,
      child: const Icon(Icons.menu_rounded),
    );
  }
}

// endregion

// region Trailing buttons

class LanguageBtn extends StatelessWidget {
  final enImageUrl = 'https://flagcdn.com/w20/us.png';
  final viImageUrl = 'https://flagcdn.com/w20/vn.png';

  const LanguageBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        // Build the button
        return IconBtn(
          tooltipText: AppLocalizations.of(context)!.language,
          child: ImageView(
            Strings.isEn ? enImageUrl : viImageUrl,
            width: Dimens.iconBtnSize,
            errorWidget: Text(
              Strings.isEn ? Language.en.name : Language.vi.name,
              style: Styles.iconBtnErrorStyle,
            ),
          ),
          onPressed: () => context
              .read<LanguageStore>()
              .setActiveLanguage(Strings.isEn ? Language.vi : Language.en),
        );
      },
    );
  }
}

class ThemeBtn extends StatelessWidget {
  const ThemeBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return IconBtn(
          tooltipText: AppLocalizations.of(context)!.theme,
          child: Themes.isDarkMode
              ? const Icon(CupertinoIcons.moon)
              : const Icon(CupertinoIcons.sun_min),
          onPressed: () => context.read<ThemeStore>().setActiveTheme(
              Themes.isDarkMode ? ThemeMode.light : ThemeMode.dark),
        );
      },
    );
  }
}

// endregion