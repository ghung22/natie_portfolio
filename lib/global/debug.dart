// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';

class Debug {
  static void log(
    Object message, {
    bool useDebugPrint = false,
    String caller = 'App',
  }) {
    final domain = Uri.base.path;
    if (domain.contains('natie-portfolio')) return;
    if (useDebugPrint) {
      debugPrint('$caller: $message');
    } else {
      print('$caller: $message');
    }
  }
}