import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Firestore {
  static FirebaseFirestore get instance => FirebaseFirestore.instance;

  static const String projects = 'projects';
  static const String bio = 'bio';

  static onError(error, stackTrace) async {
    if (kDebugMode) debugPrint(stackTrace);
    throw Exception(error);
  }
}