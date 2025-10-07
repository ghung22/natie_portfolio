// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(String route) => "No route found for ${route}";

  static String m1(String name) => "Hi! This is\n${name}";

  static String m2(String name) => "Thanks to ${name}, I have learned to…";

  static String m3(String name) => "With ${name}, you can…";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about_me": MessageLookupByLibrary.simpleMessage("About me"),
    "author": MessageLookupByLibrary.simpleMessage("Made by"),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "completion_date": MessageLookupByLibrary.simpleMessage("Completion date"),
    "contact": MessageLookupByLibrary.simpleMessage("Contact me"),
    "copyright": MessageLookupByLibrary.simpleMessage("© 2021 Natie Portfolio - Made with Flutter"),
    "details": MessageLookupByLibrary.simpleMessage("More details"),
    "experience": MessageLookupByLibrary.simpleMessage("Work experience & Education"),
    "explore": MessageLookupByLibrary.simpleMessage("Explore more"),
    "featured_projects": MessageLookupByLibrary.simpleMessage("Featured Projects"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "host": MessageLookupByLibrary.simpleMessage("Reference"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "more_projects": MessageLookupByLibrary.simpleMessage("More projects"),
    "navigate_to": MessageLookupByLibrary.simpleMessage("Navigate to"),
    "navigation": MessageLookupByLibrary.simpleMessage("Navigation"),
    "projects": MessageLookupByLibrary.simpleMessage("My projects"),
    "route_unknown": m0,
    "scoreboard": MessageLookupByLibrary.simpleMessage("See scoreboard"),
    "scores": MessageLookupByLibrary.simpleMessage("Academic grades"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "see_more": MessageLookupByLibrary.simpleMessage("Press me to see more"),
    "tech_used": MessageLookupByLibrary.simpleMessage("Technology used:"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "welcome": m1,
    "what_i_learned": m2,
    "what_you_can_do": m3,
    "z": MessageLookupByLibrary.simpleMessage("Z"),
  };
}
