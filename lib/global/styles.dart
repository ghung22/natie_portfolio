import 'package:flutter/material.dart';
import 'package:natie_portfolio/store/global/theme_store.dart';
import 'package:provider/provider.dart';

import 'dimens.dart';

class Styles {
  static BuildContext? _context;

  static void init(BuildContext context) => _context = context;

  // TextView styles
  static TextStyle get headerStyle => TextStyle(
    color: Theme.of(_context!).primaryColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: Themes.fontDisplay,
  );

  static TextStyle get subheaderStyle => TextStyle(color: Theme.of(_context!).primaryColor, fontSize: 14);

  static TextStyle get footerStyle => const TextStyle(color: Colors.black54);
  static const TextStyle spacedTextStyle = TextStyle(letterSpacing: 0.5);

  // Widget styles
  static const TextStyle bannerTitleStyle = TextStyle(fontSize: 64, fontWeight: FontWeight.bold);
  static const TextStyle bannerDescriptionStyle = TextStyle(fontSize: 20, height: 1.5);
  static const TextStyle bannerActionStyle = TextStyle(fontSize: 16);

  static const TextStyle iconBtnErrorStyle = TextStyle(fontFamily: 'monospace');
  static const TextStyle iconBtnLabelStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  // Content styles
  static const TextStyle bioNameStyle = TextStyle(fontSize: 40, fontWeight: FontWeight.bold);
  static const TextStyle bioDescriptionStyle = TextStyle(fontSize: 16, height: 1.5);

  static const TextStyle scoreNameStyle = TextStyle(
    fontFamily: Themes.fontDisplay,
    fontSize: 16,
    fontWeight: FontWeight.w900,
  );
  static const TextStyle scoreValueStyle = TextStyle(fontFamily: Themes.fontDisplay, fontSize: 32);
}

class MoreColors {
  static Color _shade(Color color, double factor) {
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness + factor).clamp(0, 1);
    return hsl.withLightness(lightness.toDouble()).toColor();
  }

  static Color lighter(Color color, {double magnitude = 1}) => _shade(color, .2 * magnitude);

  static Color darker(Color color, {double magnitude = 1}) => _shade(color, -.2 * magnitude);

  static Color onColor(Color color) => color.computeLuminance() > .5 ? Colors.black : Colors.white;

  static Color onColorShadow(Color color) => color.computeLuminance() > .5 ? Colors.white : Colors.black;
}

class Themes {
  static BuildContext? _context;

  static void init(BuildContext context) => _context = context;

  static const fontText = 'sf_text';
  static const fontDisplay = 'sf_display';

  static ThemeData get light => _generateTheme(from: ThemeData.light());

  static ThemeData get dark => _generateTheme(from: ThemeData.dark());

  static ThemeMode get themeMode {
    if (_context == null) return ThemeMode.light;
    final themeStore = _context!.read<ThemeStore>();
    switch (themeStore.activeTheme) {
      case ThemeMode.system:
        return ThemeMode.light;
      case ThemeMode.light:
      case ThemeMode.dark:
        return themeStore.activeTheme;
    }
  }

  static bool get isLightMode => themeMode == ThemeMode.light;

  static bool get isDarkMode => themeMode == ThemeMode.dark;

  static ThemeData _generateTheme({required ThemeData from}) {
    final initialTheme = ThemeData(primarySwatch: Colors.amber, fontFamily: fontText, textTheme: from.textTheme);
    return initialTheme.copyWith(
      // Global style
      brightness: from.brightness,
      colorScheme: initialTheme.colorScheme.copyWith(
        surface: from.colorScheme.surface,
        onSurface: from.colorScheme.onSurface,
        surfaceContainerHighest: from.colorScheme.surfaceContainerHighest,
        onSurfaceVariant: from.colorScheme.onSurfaceVariant,
        inverseSurface: from.colorScheme.inverseSurface,
        onInverseSurface: from.colorScheme.onInverseSurface,
      ),
      dialogTheme: DialogThemeData(backgroundColor: from.dialogTheme.backgroundColor),
      dividerTheme: from.dividerTheme.copyWith(color: from.colorScheme.onSurface.withValues(alpha: .25)),
      hintColor: from.colorScheme.onSurface.withValues(alpha: .25),
      scaffoldBackgroundColor: from.scaffoldBackgroundColor,
      textTheme: initialTheme.textTheme.copyWith(
        displayLarge: initialTheme.textTheme.displayLarge?.copyWith(fontFamily: fontDisplay),
        displayMedium: initialTheme.textTheme.displayMedium?.copyWith(fontFamily: fontDisplay),
        displaySmall: initialTheme.textTheme.displaySmall?.copyWith(fontFamily: fontDisplay),
      ),

      // Widget style
      appBarTheme: from.appBarTheme.copyWith(
        backgroundColor: from.colorScheme.surface,
        foregroundColor: from.colorScheme.onSurface,
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
      cardTheme: CardTheme(
        color: from.colorScheme.surface,
        elevation: Dimens.cardElevation,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Dimens.cardRadius))),
      ).data,
      chipTheme: ChipThemeData(
        shape: StadiumBorder(side: BorderSide(color: initialTheme.primaryColor)),
        backgroundColor: initialTheme.primaryColor.withValues(alpha: .25),
        selectedColor: initialTheme.primaryColor.withValues(alpha: .75),
      ),
      drawerTheme: from.drawerTheme.copyWith(backgroundColor: Colors.transparent, width: Dimens.drawerWidth),
      popupMenuTheme: PopupMenuThemeData(
        color: from.colorScheme.surface,
        elevation: 5,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Dimens.cardRadius))),
      ),
    );
  }
}
