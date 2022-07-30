// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProjectStore on _ProjectStore, Store {
  late final _$projectsAtom =
      Atom(name: '_ProjectStore.projects', context: context);

  @override
  Projects get projects {
    _$projectsAtom.reportRead();
    return super.projects;
  }

  @override
  set projects(Projects value) {
    _$projectsAtom.reportWrite(value, super.projects, () {
      super.projects = value;
    });
  }

  late final _$getProjectsAsyncAction =
      AsyncAction('_ProjectStore.getProjects', context: context);

  @override
  Future<void> getProjects() {
    return _$getProjectsAsyncAction.run(() => super.getProjects());
  }

  late final _$uploadHardDataAsyncAction =
      AsyncAction('_ProjectStore.uploadHardData', context: context);

  @override
  Future<void> uploadHardData() {
    return _$uploadHardDataAsyncAction.run(() => super.uploadHardData());
  }

  @override
  String toString() {
    return '''
projects: ${projects}
    ''';
  }
}
