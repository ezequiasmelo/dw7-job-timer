import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../../../services/projects/project_service.dart';
import '../../../../view_models/project_task_view_model.dart';
import '../../../../view_models/project_view_model.dart';

part 'task_state.dart';

class TaskController extends Cubit<TaskStatus> {
  late final ProjectViewModel _projectViewModel;
  final ProjectService _projectService;

  TaskController({
    required ProjectService projectService,
  })  : _projectService = projectService,
        super(TaskStatus.initial);

  void setProject(ProjectViewModel projectViewModel) =>
      _projectViewModel = projectViewModel;

  Future<void> register(String name, int duration) async {
    try {
      emit(TaskStatus.loading);
      final task = ProjectTaskViewModel(
        name: name,
        duration: duration,
      );
      await _projectService.addTask(
        _projectViewModel.id!,
        task,
      );
      emit(TaskStatus.success);
    } catch (e, s) {
      log('Erro ao salvar task', error: e, stackTrace: s);
      emit(TaskStatus.failure);
    }
  }
}
