// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';

class Debug {
  static void log(
    Object message, {
    bool useDebugPrint = false,
    String caller = 'App',
  }) {
    if (!kReleaseMode) {
      if (useDebugPrint) {
        debugPrint('$caller: $message');
      } else {
        print('$caller: $message');
      }
    }
  }
}