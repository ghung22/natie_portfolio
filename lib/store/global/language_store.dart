import 'package:mobx/mobx.dart';
import 'package:natie_portfolio/data/shared_pref/shared_pref.dart';
import 'package:natie_portfolio/global/debug.dart';
import 'package:natie_portfolio/global/strings.dart';
import 'package:natie_portfolio/global/vars.dart';

part 'language_store.g.dart';

class LanguageStore = _LanguageStore with _$LanguageStore;

abstract class _LanguageStore with Store {
  @observable
  Language activeLanguage = Language.system;

  @observable
  bool changingLanguage = false;

  @action
  Future<void> getActiveLanguage() async =>
      activeLanguage = await SharedPref.getLanguage();

  @action
  Future<void> setActiveLanguage(Language language) async {
    changingLanguage = true;
    await Future.delayed(Vars.animationFast);
    if (await SharedPref.setLanguage(language)) {
      activeLanguage = language;
    } else {
      Debug.log('Failed to set language');
    }
    await Future.delayed(Vars.animationFast);
    changingLanguage = false;
  }
}