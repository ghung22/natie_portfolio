import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:natie_portfolio/data/firebase/bio_service.dart';
import 'package:natie_portfolio/data/model/bio.dart';

part 'bio_store.g.dart';

class BioStore = _BioStore with _$BioStore;

abstract class _BioStore with Store {
  @observable
  Bio projects = const Bio();

  @action
  Future<void> getBio() async => projects = await BioService.getBio();

  @action
  Future<void> uploadHardData() async {
    await BioService.setBio(BioData.value);
    if (kDebugMode) print('Upload complete');
  }
}