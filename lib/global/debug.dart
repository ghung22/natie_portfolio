// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';

class Debug {
  static bool get isProduction => Uri.base.path.contains('natie-portfolio');

  static bool get isTesting => !isProduction;

  static void log(Object message, {bool useDebugPrint = false, String caller = 'App'}) {
    if (isProduction) return;
    if (useDebugPrint) {
      debugPrint('$caller: $message');
    } else {
      print('$caller: $message');
    }
  }
}
