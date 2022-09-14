import 'package:flutter/material.dart';

class Vars {
  static BuildContext? _context;

  static void init(BuildContext context) => _context = context;

  static const animationBlink = Duration(milliseconds: 25);
  static const animationFlash = Duration(milliseconds: 75);
  static const animationSwift = Duration(milliseconds: 150);
  static const animationFast = Duration(milliseconds: 300);
  static const animationSlow = Duration(milliseconds: 600);
  static const animationSluggish = Duration(milliseconds: 1200);

  static const assetRoot = 'assets';
  static const assetBrand = '$assetRoot/brand';
  static const assetContact = '$assetRoot/contact';
  static const assetTech = '$assetRoot/tech';
  static const assets = {
    'android': '$assetTech/android.svg',
    'firebase': '$assetTech/firebase.svg',
    'fit': '$assetBrand/fit.png',
    'flutter': '$assetTech/flutter.svg',
    'github': '$assetContact/github.svg',
    'gmail': '$assetContact/gmail.svg',
    'hcmus': '$assetBrand/hcmus.svg',
    'java': '$assetTech/java.svg',
    'jitsi': '$assetTech/jitsi.svg',
    'markdown': '$assetTech/markdown.svg',
    'ml_kit': '$assetTech/ml_kit.png',
    'mongodb': '$assetTech/mongodb.svg',
    'moodle': '$assetTech/moodle.svg',
    'sqlite': '$assetTech/sqlite.svg',
  };
}