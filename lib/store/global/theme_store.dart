import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:natie_portfolio/data/services/shared_pref.dart';
import 'package:natie_portfolio/global/debug.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  @observable
  ThemeMode activeTheme = ThemeMode.system;

  @action
  Future<void> getActiveTheme() async => activeTheme = await SharedPref.getTheme();

  @action
  Future<void> setActiveTheme(ThemeMode theme) async {
    if (await SharedPref.setTheme(theme)) {
      activeTheme = theme;
    } else {
      Debug.log('Failed to set theme');
    }
  }
}
