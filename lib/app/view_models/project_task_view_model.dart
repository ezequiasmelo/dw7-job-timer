import '../entities/project_task.dart';

class ProjectTaskViewModel {
  int? id;
  String name;
  int duration;

  ProjectTaskViewModel({
    this.id,
    required this.name,
    required this.duration,
  });

  factory ProjectTaskViewModel.fromEntity(ProjectTask task) {
    return ProjectTaskViewModel(
      id: task.id,
      name: task.name,
      duration: task.duration,
    );
  }
}
