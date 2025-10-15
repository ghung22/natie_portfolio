import 'package:flutter/material.dart';
import 'package:natie_portfolio/store/global/theme_store.dart';
import 'package:provider/provider.dart';

import 'dimens.dart';

class Styles {
  Styles._(this._context);

  final BuildContext _context;

  static Styles of(BuildContext context) => Styles._(context);

  // TextView styles
  TextStyle get headerStyle => TextStyle(
    color: Theme.of(_context).primaryColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: Themes.fontDisplay,
  );

  TextStyle get subheaderStyle => TextStyle(color: Theme.of(_context).primaryColor, fontSize: 14);

  TextStyle get footerStyle => const TextStyle(color: Colors.black54);

  TextStyle get monospaceStyle => const TextStyle(fontFamily: Themes.fontMono);
  static const TextStyle spacedTextStyle = TextStyle(letterSpacing: 0.5);

  // Widget styles
  static const TextStyle bannerTitleStyle = TextStyle(fontSize: 64, fontWeight: FontWeight.bold);
  static const TextStyle bannerDescriptionStyle = TextStyle(fontSize: 20, height: 1.5);
  static const TextStyle bannerActionStyle = TextStyle(fontSize: 16);

  static const TextStyle iconBtnErrorStyle = TextStyle(fontFamily: Themes.fontMono);
  static const TextStyle iconBtnLabelStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  static const TextStyle textBtnLabelStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  // Content styles
  static const TextStyle bioNameStyle = TextStyle(fontSize: 40, fontWeight: FontWeight.bold);
  static const TextStyle bioDescriptionStyle = TextStyle(fontSize: 16, height: 1.5);

  static const TextStyle scoreNameStyle = TextStyle(
    fontFamily: Themes.fontDisplay,
    fontSize: 16,
    fontWeight: FontWeight.w900,
  );
  static const TextStyle scoreValueStyle = TextStyle(fontFamily: Themes.fontDisplay, fontSize: 32);
  static const TextStyle scoreValueMaxStyle = TextStyle(fontFamily: Themes.fontDisplay, fontSize: 14);
}

class MoreColors {
  static const gray36 = Color(0xff363636);
  static const gray28 = Color(0xff282828);

  static Color _shade(Color color, double factor) {
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness + factor).clamp(0, 1);
    return hsl.withLightness(lightness.toDouble()).toColor();
  }

  static Color lighter(Color color, {double magnitude = 1}) => _shade(color, .2 * magnitude);

  static Color darker(Color color, {double magnitude = 1}) => _shade(color, -.2 * magnitude);

  static Color onColor(Color color) => color.computeLuminance() > .5 ? Colors.black : Colors.white;

  static Color onColorShadow(Color color) => color.computeLuminance() > .5 ? Colors.white : Colors.black;

  static Color? inverse(Color? color) =>
      color?.withValues(red: 255 - color.r, green: 255 - color.g, blue: 255 - color.b);
}

class Themes {
  static const fontText = 'sf_text';
  static const fontDisplay = 'sf_display';
  static const fontMono = 'sf_mono';

  static ThemeData get light => _generateTheme(from: ThemeData.light());

  static ThemeData get dark => _generateTheme(from: ThemeData.dark());

  static ThemeMode themeMode(BuildContext context) {
    final themeStore = context.read<ThemeStore>();
    switch (themeStore.activeTheme) {
      case ThemeMode.system:
        return ThemeMode.light;
      case ThemeMode.light:
      case ThemeMode.dark:
        return themeStore.activeTheme;
    }
  }

  static bool isLightMode(BuildContext context) => themeMode(context) == ThemeMode.light;

  static bool isDarkMode(BuildContext context) => themeMode(context) == ThemeMode.dark;

  static ThemeData _generateTheme({required ThemeData from}) {
    final initialTheme = ThemeData(
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber),
      fontFamily: fontText,
      textTheme: from.textTheme,
    );
    final isLight = from.brightness == Brightness.light;
    final surfaceLowerColor = isLight ? from.scaffoldBackgroundColor : MoreColors.gray28;
    final surfaceUpperColor = isLight ? from.colorScheme.surface : MoreColors.gray36;
    return initialTheme.copyWith(
      // Global style
      brightness: from.brightness,
      colorScheme: initialTheme.colorScheme.copyWith(
        surface: surfaceUpperColor,
        onSurface: from.colorScheme.onSurface,
        surfaceContainerHighest: from.colorScheme.surfaceContainerHighest,
        onSurfaceVariant: from.colorScheme.onSurfaceVariant,
        inverseSurface: from.colorScheme.inverseSurface,
        onInverseSurface: from.colorScheme.onInverseSurface,
      ),
      dialogTheme: DialogThemeData(backgroundColor: from.dialogTheme.backgroundColor),
      dividerTheme: from.dividerTheme.copyWith(color: from.colorScheme.onSurface.withValues(alpha: .25)),
      hintColor: from.colorScheme.onSurface.withValues(alpha: .25),
      scaffoldBackgroundColor: surfaceLowerColor,
      textTheme: initialTheme.textTheme.copyWith(
        displayLarge: initialTheme.textTheme.displayLarge?.copyWith(fontFamily: fontDisplay),
        displayMedium: initialTheme.textTheme.displayMedium?.copyWith(fontFamily: fontDisplay),
        displaySmall: initialTheme.textTheme.displaySmall?.copyWith(fontFamily: fontDisplay),
      ),

      // Widget style
      appBarTheme: from.appBarTheme.copyWith(
        backgroundColor: surfaceLowerColor,
        foregroundColor: from.colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: from.colorScheme.onSurface.withValues(alpha: .75),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: from.bottomNavigationBarTheme.copyWith(
        backgroundColor: from.colorScheme.surface,
        selectedIconTheme: IconThemeData(color: initialTheme.primaryColor, size: from.iconTheme.size ?? 24 * 1.25),
        selectedItemColor: initialTheme.primaryColor,
        unselectedIconTheme: IconThemeData(color: from.colorScheme.onSurface.withValues(alpha: .5)),
        unselectedItemColor: from.colorScheme.onSurface.withValues(alpha: .5),
      ),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: from.colorScheme.surface),
      cardTheme: CardTheme(color: surfaceUpperColor, elevation: Dimens.cardElevation, shape: Dimens.cardBorder).data,
      chipTheme: ChipThemeData(
        shape: StadiumBorder(side: BorderSide(color: initialTheme.primaryColor)),
        backgroundColor: initialTheme.primaryColor.withValues(alpha: .25),
        selectedColor: initialTheme.primaryColor.withValues(alpha: .75),
      ),
      drawerTheme: from.drawerTheme.copyWith(backgroundColor: Colors.transparent, width: Dimens.drawerWidth),
      popupMenuTheme: PopupMenuThemeData(color: from.colorScheme.surface, elevation: 5, shape: Dimens.cardBorder),
    );
  }
}
