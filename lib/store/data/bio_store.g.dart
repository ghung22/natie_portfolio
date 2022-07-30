// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bio_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BioStore on _BioStore, Store {
  late final _$bioAtom = Atom(name: '_BioStore.bio', context: context);

  @override
  Bio get bio {
    _$bioAtom.reportRead();
    return super.bio;
  }

  @override
  set bio(Bio value) {
    _$bioAtom.reportWrite(value, super.bio, () {
      super.bio = value;
    });
  }

  late final _$getBioAsyncAction =
      AsyncAction('_BioStore.getBio', context: context);

  @override
  Future<void> getBio() {
    return _$getBioAsyncAction.run(() => super.getBio());
  }

  late final _$uploadHardDataAsyncAction =
      AsyncAction('_BioStore.uploadHardData', context: context);

  @override
  Future<void> uploadHardData() {
    return _$uploadHardDataAsyncAction.run(() => super.uploadHardData());
  }

  @override
  String toString() {
    return '''
bio: ${bio}
    ''';
  }
}
