// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AnimationStore on _AnimationStore, Store {
  Computed<bool>? _$intDataMaxedComputed;

  @override
  bool get intDataMaxed =>
      (_$intDataMaxedComputed ??= Computed<bool>(() => super.intDataMaxed,
              name: '_AnimationStore.intDataMaxed'))
          .value;

  late final _$willStartAtom =
      Atom(name: '_AnimationStore.willStart', context: context);

  @override
  bool get willStart {
    _$willStartAtom.reportRead();
    return super.willStart;
  }

  @override
  set willStart(bool value) {
    _$willStartAtom.reportWrite(value, super.willStart, () {
      super.willStart = value;
    });
  }

  late final _$intDataAtom =
      Atom(name: '_AnimationStore.intData', context: context);

  @override
  int get intData {
    _$intDataAtom.reportRead();
    return super.intData;
  }

  @override
  set intData(int value) {
    _$intDataAtom.reportWrite(value, super.intData, () {
      super.intData = value;
    });
  }

  late final _$_AnimationStoreActionController =
      ActionController(name: '_AnimationStore', context: context);

  @override
  void start() {
    final _$actionInfo = _$_AnimationStoreActionController.startAction(
        name: '_AnimationStore.start');
    try {
      return super.start();
    } finally {
      _$_AnimationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stop() {
    final _$actionInfo = _$_AnimationStoreActionController.startAction(
        name: '_AnimationStore.stop');
    try {
      return super.stop();
    } finally {
      _$_AnimationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDataLimit({int? lowerLimit, int? upperLimit}) {
    final _$actionInfo = _$_AnimationStoreActionController.startAction(
        name: '_AnimationStore.setDataLimit');
    try {
      return super.setDataLimit(lowerLimit: lowerLimit, upperLimit: upperLimit);
    } finally {
      _$_AnimationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setData(int data) {
    final _$actionInfo = _$_AnimationStoreActionController.startAction(
        name: '_AnimationStore.setData');
    try {
      return super.setData(data);
    } finally {
      _$_AnimationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void increment() {
    final _$actionInfo = _$_AnimationStoreActionController.startAction(
        name: '_AnimationStore.increment');
    try {
      return super.increment();
    } finally {
      _$_AnimationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrement() {
    final _$actionInfo = _$_AnimationStoreActionController.startAction(
        name: '_AnimationStore.decrement');
    try {
      return super.decrement();
    } finally {
      _$_AnimationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_AnimationStoreActionController.startAction(
        name: '_AnimationStore.reset');
    try {
      return super.reset();
    } finally {
      _$_AnimationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
willStart: ${willStart},
intData: ${intData},
intDataMaxed: ${intDataMaxed}
    ''';
  }
}
