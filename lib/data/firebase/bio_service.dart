import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:natie_portfolio/data/model/bio.dart';

import 'firestore.dart';

class BioService {
  static CollectionReference<Map<String, dynamic>> bio =
      Firestore.instance.collection(Firestore.bio);

  static Future<void> setBio(Bio b) async => await bio
      .doc('bio')
      .set(b.toJson())
      .then((v) => Firestore.onDone('setBio'))
      .onError((e, st) => Firestore.onError('setBio', e, st));

  static Future<Bio> getBio() async {
    final data = await bio
        .doc('bio')
        .get()
        .onError((e, st) => Firestore.onError('getBio', e, st));
    final d = data.data();
    if (d == null) throw 'Bio not exist in Firestore';
    Firestore.onDone('getBio', d);
    return Bio.fromJson(d);
  }
}