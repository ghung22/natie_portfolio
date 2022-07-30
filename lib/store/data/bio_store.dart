import 'package:mobx/mobx.dart';
import 'package:natie_portfolio/data/firebase/bio_service.dart';
import 'package:natie_portfolio/data/model/bio.dart';
import 'package:natie_portfolio/global/debug.dart';

part 'bio_store.g.dart';

class BioStore = _BioStore with _$BioStore;

abstract class _BioStore with Store {
  @observable
  Bio bio = const Bio();

  @action
  Future<void> getBio() async => bio = await BioService.getBio();

  @action
  Future<void> uploadHardData() async {
    await BioService.setBio(BioData.value);
    Debug.log('Upload complete');
  }
}