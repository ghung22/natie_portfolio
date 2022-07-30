import 'package:mobx/mobx.dart';
import 'package:natie_portfolio/data/shared_pref/shared_pref.dart';
import 'package:natie_portfolio/global/debug.dart';
import 'package:natie_portfolio/global/strings.dart';

part 'language_store.g.dart';

class LanguageStore = _LanguageStore with _$LanguageStore;

abstract class _LanguageStore with Store {
  @observable
  Language activeLanguage = Language.system;

  @action
  Future<void> getActiveLanguage() async =>
      activeLanguage = await SharedPref.getLanguage();

  @action
  Future<void> setActiveLanguage(Language language) async {
    if (await SharedPref.setLanguage(language)) {
      activeLanguage = language;
    } else {
      Debug.log('Failed to set language');
    }
  }
}