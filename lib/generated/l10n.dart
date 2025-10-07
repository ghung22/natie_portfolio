// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `About me`
  String get about_me {
    return Intl.message('About me', name: 'about_me', desc: '', args: []);
  }

  /// `Made by`
  String get author {
    return Intl.message('Made by', name: 'author', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Completion date`
  String get completion_date {
    return Intl.message('Completion date', name: 'completion_date', desc: '', args: []);
  }

  /// `Contact me`
  String get contact {
    return Intl.message('Contact me', name: 'contact', desc: '', args: []);
  }

  /// `© 2021 Natie Portfolio - Made with Flutter`
  String get copyright {
    return Intl.message('© 2021 Natie Portfolio - Made with Flutter', name: 'copyright', desc: '', args: []);
  }

  /// `More details`
  String get details {
    return Intl.message('More details', name: 'details', desc: '', args: []);
  }

  /// `Explore more`
  String get explore {
    return Intl.message('Explore more', name: 'explore', desc: '', args: []);
  }

  /// `Work experience & Education`
  String get experience {
    return Intl.message('Work experience & Education', name: 'experience', desc: '', args: []);
  }

  /// `Featured Projects`
  String get featured_projects {
    return Intl.message('Featured Projects', name: 'featured_projects', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Reference`
  String get host {
    return Intl.message('Reference', name: 'host', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `More projects`
  String get more_projects {
    return Intl.message('More projects', name: 'more_projects', desc: '', args: []);
  }

  /// `Navigate to`
  String get navigate_to {
    return Intl.message('Navigate to', name: 'navigate_to', desc: '', args: []);
  }

  /// `Navigation`
  String get navigation {
    return Intl.message('Navigation', name: 'navigation', desc: '', args: []);
  }

  /// `My projects`
  String get projects {
    return Intl.message('My projects', name: 'projects', desc: '', args: []);
  }

  /// `No route found for {route}`
  String route_unknown(String route) {
    return Intl.message(
      'No route found for $route',
      name: 'route_unknown',
      desc: 'Error for providing an unknown route.',
      args: [route],
    );
  }

  /// `See scoreboard`
  String get scoreboard {
    return Intl.message('See scoreboard', name: 'scoreboard', desc: '', args: []);
  }

  /// `Academic grades`
  String get scores {
    return Intl.message('Academic grades', name: 'scores', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Press me to see more`
  String get see_more {
    return Intl.message('Press me to see more', name: 'see_more', desc: '', args: []);
  }

  /// `Technology used:`
  String get tech_used {
    return Intl.message('Technology used:', name: 'tech_used', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Hi! This is\n{name}`
  String welcome(String name) {
    return Intl.message('Hi! This is\n$name', name: 'welcome', desc: 'A welcome message for the viewer.', args: [name]);
  }

  /// `Thanks to {name}, I have learned to…`
  String what_i_learned(String name) {
    return Intl.message(
      'Thanks to $name, I have learned to…',
      name: 'what_i_learned',
      desc: 'Header for the learned section of Project Details.',
      args: [name],
    );
  }

  /// `With {name}, you can…`
  String what_you_can_do(String name) {
    return Intl.message(
      'With $name, you can…',
      name: 'what_you_can_do',
      desc: 'Header for the functionality section of Project Details.',
      args: [name],
    );
  }

  /// `Z`
  String get z {
    return Intl.message('Z', name: 'z', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en'), Locale.fromSubtags(languageCode: 'vi')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
