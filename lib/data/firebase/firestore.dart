import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:natie_portfolio/global/debug.dart';
import 'package:natie_portfolio/store/data/bio_store.dart';
import 'package:natie_portfolio/store/data/project_store.dart';
import 'package:provider/provider.dart';

class Firestore {
  static Future<void> bootstrap(BuildContext context) async {
    await Future.wait([context.read<ProjectStore>().getProjects(), context.read<BioStore>().getBio()]);
  }

  static FirebaseFirestore get instance => FirebaseFirestore.instance;

  static const String projects = 'projects';
  static const String bio = 'bio';

  static Future<void> onDone(String caller, [Object? value]) async {
    Debug.log(value ?? 'No data', useDebugPrint: true, caller: caller);
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> onQueryError(
    String caller,
    Object? error,
    StackTrace stackTrace,
  ) async {
    Debug.log(stackTrace, useDebugPrint: true, caller: caller);
    throw error ?? 'Unknown error';
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> onDocumentError(
    String caller,
    Object? error,
    StackTrace stackTrace,
  ) async {
    Debug.log(stackTrace, useDebugPrint: true, caller: caller);
    throw error ?? 'Unknown error';
  }
}
