import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'dimen_store.g.dart';

class DimenStore = _DimenStore with _$DimenStore;

abstract class _DimenStore with Store {
  @observable
  Size size = Size.zero;

  @computed
  double get width => size.width;

  @computed
  double get height => size.height;

  @action
  void updateScreenSize(Size size) {
    this.size = size;
  }
}
