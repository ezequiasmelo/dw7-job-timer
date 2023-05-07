import 'package:isar/isar.dart';

import '../entities/project_task.dart';

class ProjectTaskViewModel {
  Id? id = Isar.autoIncrement;
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
