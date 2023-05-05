import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../entities/project_status.dart';
import '../../../services/projects/project_service.dart';
import '../../../view_models/project_view_model.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final ProjectService _projectService;

  HomeController({
    required ProjectService projectService,
  })  : _projectService = projectService,
        super(HomeState.initial());

  Future<void> loadProjects() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final projects = await _projectService.findByStatus(state.projectFilter);
      emit(state.copyWith(status: HomeStatus.complete, projects: projects));
    } catch (e, s) {
      log('Erro ao buscar os projetos', error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> filter(ProjectStatus status) async {
    emit(state.copyWith(status: HomeStatus.loading, projects: []));
    final projects = await _projectService.findByStatus(status);
    emit(
      state.copyWith(
        status: HomeStatus.complete,
        projects: projects,
        projectFilter: status,
      ),
    );
  }

  void updateList() => filter(state.projectFilter);
}
