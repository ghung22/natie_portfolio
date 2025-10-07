import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('vi')];

  /// No description provided for @about_me.
  ///
  /// In en, this message translates to:
  /// **'About me'**
  String get about_me;

  /// No description provided for @author.
  ///
  /// In en, this message translates to:
  /// **'Made by'**
  String get author;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @completion_date.
  ///
  /// In en, this message translates to:
  /// **'Completion date'**
  String get completion_date;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact me'**
  String get contact;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'© 2021 Natie Portfolio - Made with Flutter'**
  String get copyright;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'More details'**
  String get details;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore more'**
  String get explore;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Work experience & Education'**
  String get experience;

  /// No description provided for @featured_projects.
  ///
  /// In en, this message translates to:
  /// **'Featured Projects'**
  String get featured_projects;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @host.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get host;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @more_projects.
  ///
  /// In en, this message translates to:
  /// **'More projects'**
  String get more_projects;

  /// No description provided for @navigate_to.
  ///
  /// In en, this message translates to:
  /// **'Navigate to'**
  String get navigate_to;

  /// No description provided for @navigation.
  ///
  /// In en, this message translates to:
  /// **'Navigation'**
  String get navigation;

  /// No description provided for @projects.
  ///
  /// In en, this message translates to:
  /// **'My projects'**
  String get projects;

  /// Error for providing an unknown route.
  ///
  /// In en, this message translates to:
  /// **'No route found for {route}'**
  String route_unknown(String route);

  /// No description provided for @scoreboard.
  ///
  /// In en, this message translates to:
  /// **'See scoreboard'**
  String get scoreboard;

  /// No description provided for @scores.
  ///
  /// In en, this message translates to:
  /// **'Academic grades'**
  String get scores;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @see_more.
  ///
  /// In en, this message translates to:
  /// **'Press me to see more'**
  String get see_more;

  /// No description provided for @tech_used.
  ///
  /// In en, this message translates to:
  /// **'Technology used:'**
  String get tech_used;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// A welcome message for the viewer.
  ///
  /// In en, this message translates to:
  /// **'Hi! This is\n{name}'**
  String welcome(String name);

  /// Header for the learned section of Project Details.
  ///
  /// In en, this message translates to:
  /// **'Thanks to {name}, I have learned to…'**
  String what_i_learned(String name);

  /// Header for the functionality section of Project Details.
  ///
  /// In en, this message translates to:
  /// **'With {name}, you can…'**
  String what_you_can_do(String name);

  /// No description provided for @z.
  ///
  /// In en, this message translates to:
  /// **'Z'**
  String get z;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
