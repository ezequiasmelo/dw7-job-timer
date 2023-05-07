import '../../entities/project.dart';
import '../../entities/project_status.dart';
import '../../entities/project_task.dart';
import '../../repositories/projects/project_repository.dart';
import '../../view_models/project_task_view_model.dart';
import '../../view_models/project_view_model.dart';
import './project_service.dart';

class ProjectServiceImpl implements ProjectService {
  final ProjectRepository _projectRepository;

  ProjectServiceImpl({
    required ProjectRepository projectRepository,
  }) : _projectRepository = projectRepository;

  @override
  Future<void> register(ProjectViewModel projectViewModel) async {
    final project = Project()
      ..id = projectViewModel.id ?? 0
      ..name = projectViewModel.name
      ..status = projectViewModel.status
      ..estimate = projectViewModel.estimate;
    await _projectRepository.register(project);
  }

  @override
  Future<List<ProjectViewModel>> findByStatus(ProjectStatus status) async {
    final projects = await _projectRepository.findByStatus(status);
    return projects.map(ProjectViewModel.fromEntity).toList();
  }

  @override
  Future<ProjectViewModel> addTask(
      int projectId, ProjectTaskViewModel task) async {
    final projectTask = ProjectTask()
      ..name = task.name
      ..duration = task.duration;

    final project = await _projectRepository.addTask(projectId, projectTask);
    return ProjectViewModel.fromEntity(project);
  }

  @override
  Future<ProjectViewModel> findById(int projectId) async {
    final project = await _projectRepository.findById(projectId);
    return ProjectViewModel.fromEntity(project);
  }

  @override
  Future<void> finishProject(int projectId) =>
      _projectRepository.finishProject(projectId);
}
