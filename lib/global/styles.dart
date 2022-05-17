import 'package:flutter/material.dart';

class Styles {
  static BuildContext? _context;

  static void init(BuildContext context) {
    _context = context;
  }

  /// Style for header text
  static TextStyle headerStyle = TextStyle(
    color: Theme.of(_context!).primaryColor,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  /// Style for footer text
  static TextStyle footerStyle = const TextStyle(
    color: Colors.black54,
  );
}