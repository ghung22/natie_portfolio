import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:natie_portfolio/data/firebase/project_service.dart';
import 'package:natie_portfolio/data/model/project.dart';

part 'project_store.g.dart';

class ProjectStore = _ProjectStore with _$ProjectStore;

abstract class _ProjectStore with Store {
  @observable
  Projects projects = Projects([]);

  @action
  Future<void> getProjects() async =>
      projects = Projects(await ProjectService.getProjects());

  @action
  Future<void> uploadHardData() async {
    for (Project p in ProjectData.values) {
      await ProjectService.setProject(p);
    }
    if (kDebugMode) print('Upload complete');
  }
}