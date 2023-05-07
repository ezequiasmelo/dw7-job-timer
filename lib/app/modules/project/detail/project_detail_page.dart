import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ui/job_timer_icons.dart';
import '../../../entities/project_status.dart';
import '../../../view_models/project_view_model.dart';
import 'controller/project_detail_controller.dart';
import 'widgets/project_detail_appbar.dart';
import 'widgets/project_pie_chart.dart';
import 'widgets/project_task_tile.dart';

class ProjectDetailPage extends StatelessWidget {
  final ProjectDetailController controller;

  const ProjectDetailPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProjectDetailController, ProjectDetailState>(
        bloc: controller,
        listener: (context, state) {
          if (state.status == ProjectDetailStatus.failure) {
            AsukaSnackbar.alert('Erro interno');
          }
        },
        builder: (context, state) {
          final projectViewModel = state.projectViewModel;

          switch (state.status) {
            case ProjectDetailStatus.initial:
              return const Center(
                child: Text('Carregando projeto'),
              );
            case ProjectDetailStatus.loading:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            case ProjectDetailStatus.complete:
              return _buildProjectDetail(context, projectViewModel!);
            case ProjectDetailStatus.failure:
              if (projectViewModel != null) {
                return _buildProjectDetail(context, projectViewModel);
              }
              return const Center(
                child: Text('Erro ao carregar projeto'),
              );
          }
        },
      ),
    );
  }

  Widget _buildProjectDetail(
    BuildContext context,
    ProjectViewModel projectViewModel,
  ) {
    final totalTasks = projectViewModel.tasks.fold<int>(0, (totalValue, task) {
      return totalValue += task.duration;
    });

    return CustomScrollView(
      slivers: [
        ProjectDetailAppbar(projectViewModel: projectViewModel),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: ProjectPieChart(
                  projectEstimate: projectViewModel.estimate,
                  totalTask: totalTasks,
                ),
              ),
              ...projectViewModel.tasks
                  .map((task) => ProjectTaskTile(task: task))
                  .toList(),
            ],
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Visibility(
                visible: projectViewModel.status != ProjectStatus.finalizado,
                child: ElevatedButton.icon(
                  onPressed: () {
                    controller.finishProject();
                  },
                  icon: const Icon(JobTimerIcons.ok_circled2),
                  label: const Text('Finalizar Projeto'),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
