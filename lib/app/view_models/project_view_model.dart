import 'package:isar/isar.dart';

import '../entities/project.dart';
import '../entities/project_status.dart';
import 'project_task_view_model.dart';

class ProjectViewModel {
  final Id? id;
  final String name;
  final int estimate;
  final ProjectStatus status;
  final List<ProjectTaskViewModel> tasks;

  ProjectViewModel({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.estimate,
    required this.status,
    required this.tasks,
  });

  factory ProjectViewModel.fromEntity(Project project) {
    project.tasks.loadSync();
    return ProjectViewModel(
      id: project.id,
      name: project.name,
      estimate: project.estimate,
      status: project.status,
      tasks: project.tasks.map(ProjectTaskViewModel.fromEntity).toList(),
    );
  }
}
