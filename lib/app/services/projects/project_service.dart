import '../../entities/project_status.dart';
import '../../view_models/project_task_view_model.dart';
import '../../view_models/project_view_model.dart';

abstract class ProjectService {
  Future<void> register(ProjectViewModel projectViewModel);
  Future<List<ProjectViewModel>> findByStatus(ProjectStatus status);
  Future<ProjectViewModel> addTask(int projectId, ProjectTaskViewModel task);
  Future<ProjectViewModel> findById(int projectId);
  Future<void> finishProject(int projectId);
}
