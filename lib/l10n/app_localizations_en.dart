// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get about_me => 'About me';

  @override
  String get author => 'Made by';

  @override
  String get back => 'Back';

  @override
  String get completion_date => 'Completion date';

  @override
  String get contact => 'Contact me';

  @override
  String get copyright => '© 2026 Natie Portfolio - Made with Flutter';

  @override
  String get details => 'More details';

  @override
  String get explore => 'Explore more';

  @override
  String get experience => 'Work experience & Education';

  @override
  String get featured_projects => 'Featured Projects';

  @override
  String get home => 'Home';

  @override
  String get host => 'Reference';

  @override
  String get language => 'Language';

  @override
  String get more_projects => 'More projects';

  @override
  String get navigate_to => 'Navigate to';

  @override
  String get navigation => 'Navigation';

  @override
  String get projects => 'My projects';

  @override
  String route_unknown(String route) {
    return 'No route found for $route';
  }

  @override
  String get scoreboard => 'See scoreboard';

  @override
  String get scores => 'Academic grades';

  @override
  String get search => 'Search';

  @override
  String get see_more => 'Press me to see more';

  @override
  String get tech_used => 'Technology used:';

  @override
  String get theme => 'Theme';

  @override
  String welcome(String name) {
    return 'Hi! This is\n$name';
  }

  @override
  String what_i_learned(String name) {
    return 'Thanks to $name, I have learned to…';
  }

  @override
  String what_you_can_do(String name) {
    return 'With $name, you can…';
  }

  @override
  String get z => 'Z';
}
