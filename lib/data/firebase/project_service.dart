import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:natie_portfolio/data/model/project.dart';

import 'firestore.dart';

class ProjectService {
  static CollectionReference<Map<String, dynamic>> projects =
      Firestore.instance.collection(Firestore.projects);

  static Future<void> setProject(Project p) async => await projects
      .doc(p.id)
      .set(p.toJson())
      .then((v) => Firestore.onDone('setProject'))
      .onError((e, st) => Firestore.onQueryError('setProject', e, st));

  static Future<Projects> getProjects() async {
    final data = await projects
        .get()
        .onError((e, st) => Firestore.onQueryError('getProjects', e, st));
    final list = data.docs.map((d) => Project.fromJson(d.data())).toList();
    Firestore.onDone('getProjects', list);
    return Projects(list);
  }
}