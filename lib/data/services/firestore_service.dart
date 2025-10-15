import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:natie_portfolio/data/model/bio.dart';
import 'package:natie_portfolio/data/model/project.dart';

import 'firestore.dart';

class FirestoreService {
  static CollectionReference<Map<String, dynamic>> bio = Firestore.instance.collection(Firestore.bio);
  static CollectionReference<Map<String, dynamic>> projects = Firestore.instance.collection(Firestore.projects);

  static bool get isOpen => false;

  static Future<void> setBio(Bio b) async => await bio
      .doc('bio')
      .set(b.toJson())
      .then((v) => Firestore.onDone('setBio'))
      .onError((e, st) => Firestore.onQueryError('setBio', e, st));

  static Future<Bio> getBio() async {
    if (isOpen) {
      final data = await bio.doc('bio').get().onError((e, st) => Firestore.onDocumentError('getBio', e, st));
      final d = data.data();
      if (d == null) throw 'Bio not exist in Firestore';
      Firestore.onDone('getBio', d);
      return Bio.fromJson(d);
    }
    return BioData.value;
  }

  static Future<void> setProject(Project p) async => await projects
      .doc(p.id)
      .set(p.toJson())
      .then((v) => Firestore.onDone('setProject'))
      .onError((e, st) => Firestore.onQueryError('setProject', e, st));

  static Future<Projects> getProjects() async {
    if (isOpen) {
      final data = await projects.get().onError((e, st) => Firestore.onQueryError('getProjects', e, st));
      final list = data.docs.map((d) => Project.fromJson(d.data())).toList();
      Firestore.onDone('getProjects', list);
      return Projects(list);
    }
    return ProjectData.data;
  }
}
