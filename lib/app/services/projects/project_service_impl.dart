import '../../entities/project.dart';
import '../../entities/project_status.dart';
import '../../repositories/projects/project_repository.dart';
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
}
