import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:natie_portfolio/data/model/project.dart';

import 'firestore.dart';

class ProjectService {
  static CollectionReference<Map<String, dynamic>> projects =
      Firestore.instance.collection(Firestore.projects);

  static Future<void> setProject(Project p) async => await projects
      .doc(p.id)
      .set(p.toJson())
      .onError((e, st) => Firestore.onError(e, st));

  static Future<List<Project>> getProjects() async {
    final data = await projects
        .orderBy('completionDate')
        .get()
        .onError((e, st) => Firestore.onError(e, st));
    return data.docs.map((d) => Project.fromJson(d.data())).toList();
  }

  static Future<List<Project>> getFeaturedProjects() async {
    final data = await projects
        .orderBy('completionDate')
        .where('featured', isEqualTo: true)
        .get()
        .onError((e, st) => Firestore.onError(e, st));
    return data.docs.map((d) => Project.fromJson(d.data())).toList();
  }

  static Future<Project?> getProject(id) async {
    final data = await projects
        .doc(id)
        .get()
        .onError((e, st) => Firestore.onError(e, st));
    final d = data.data();
    return (d != null) ? Project.fromJson(d) : null;
  }
}