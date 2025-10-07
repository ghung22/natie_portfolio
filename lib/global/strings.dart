import 'package:flutter/material.dart';
import 'package:natie_portfolio/store/data/bio_store.dart';
import 'package:natie_portfolio/store/global/language_store.dart';
import 'package:provider/provider.dart';

enum Language { system, en, vi }

class Strings {
  static BuildContext? _context;

  static void init(BuildContext context) => _context = context;

  static Language get language {
    if (_context == null) return Language.en;
    final languageStore = _context!.read<LanguageStore>();
    switch (languageStore.activeLanguage) {
      case Language.system:
        Locale locale = Localizations.localeOf(_context!);
        return locale.languageCode == Language.en.name ? Language.en : Language.vi;
      case Language.en:
      case Language.vi:
        return languageStore.activeLanguage;
    }
  }

  static bool get isEn => Strings.language == Language.en;

  static bool get isVi => Strings.language == Language.vi;

  static Locale get locale => Locale(language.name);

  static String get title {
    try {
      final bio = _context!.read<BioStore>().bio;
      return language == Language.en ? bio.title : bio.titleVi;
    } catch (e) {
      return '';
    }
  }
}
