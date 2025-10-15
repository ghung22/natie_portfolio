import 'package:mobx/mobx.dart';
import 'package:natie_portfolio/data/model/project.dart';
import 'package:natie_portfolio/data/services/firestore_service.dart';
import 'package:natie_portfolio/global/debug.dart';

part 'project_store.g.dart';

class ProjectStore = _ProjectStore with _$ProjectStore;

abstract class _ProjectStore with Store {
  @observable
  Projects projects = Projects();

  @action
  Future<void> getProjects() async => projects = await FirestoreService.getProjects();

  @action
  Future<void> uploadHardData() async {
    for (Project p in ProjectData.data.values) {
      await FirestoreService.setProject(p);
    }
    Debug.log('Upload complete');
  }
}
