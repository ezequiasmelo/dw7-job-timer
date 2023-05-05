import 'package:isar/isar.dart';

import 'project_status.dart';
import 'project_task.dart';

part 'project.g.dart';

@collection
class Project {
  Id? id = Isar.autoIncrement;

  late String name;
  @enumerated
  late ProjectStatus status;

  final tasks = IsarLinks<ProjectTask>();
}
