import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:natie_portfolio/store/data/bio_store.dart';
import 'package:natie_portfolio/store/global/language_store.dart';
import 'package:provider/provider.dart';

enum Language { system, en, vi }

class Strings {
  Strings._(this._context);

  final BuildContext _context;

  static Strings of(BuildContext context) => Strings._(context);

  Language get language {
    final languageStore = _context.read<LanguageStore>();
    switch (languageStore.activeLanguage) {
      case Language.system:
        final locale = Localizations.maybeLocaleOf(_context) ?? ui.PlatformDispatcher.instance.locale;
        return locale.languageCode == Language.en.name ? Language.en : Language.vi;
      case Language.en:
      case Language.vi:
        return languageStore.activeLanguage;
    }
  }

  bool get isEn => language == Language.en;

  bool get isVi => language == Language.vi;

  Locale get locale => Locale(language.name);

  String get title {
    try {
      final bio = _context.read<BioStore>().bio;
      return isEn ? bio.title : bio.titleVi;
    } catch (_) {
      return '';
    }
  }
}
