// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dimen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DimenStore on _DimenStore, Store {
  Computed<double>? _$widthComputed;

  @override
  double get width => (_$widthComputed ??=
          Computed<double>(() => super.width, name: '_DimenStore.width'))
      .value;
  Computed<double>? _$heightComputed;

  @override
  double get height => (_$heightComputed ??=
          Computed<double>(() => super.height, name: '_DimenStore.height'))
      .value;

  late final _$sizeAtom = Atom(name: '_DimenStore.size', context: context);

  @override
  Size get size {
    _$sizeAtom.reportRead();
    return super.size;
  }

  @override
  set size(Size value) {
    _$sizeAtom.reportWrite(value, super.size, () {
      super.size = value;
    });
  }

  late final _$_DimenStoreActionController =
      ActionController(name: '_DimenStore', context: context);

  @override
  void updateScreenSize(Size size) {
    final _$actionInfo = _$_DimenStoreActionController.startAction(
        name: '_DimenStore.updateScreenSize');
    try {
      return super.updateScreenSize(size);
    } finally {
      _$_DimenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
size: ${size},
width: ${width},
height: ${height}
    ''';
  }
}
