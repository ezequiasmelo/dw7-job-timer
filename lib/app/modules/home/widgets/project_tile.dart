import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/ui/job_timer_icons.dart';
import '../../../view_models/project_view_model.dart';
import '../controller/home_controller.dart';

class ProjectTile extends StatelessWidget {
  final ProjectViewModel projectViewModel;

  const ProjectTile({
    super.key,
    required this.projectViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Modular.to.pushNamed(
          '/project/detail',
          arguments: projectViewModel,
        );
        Modular.get<HomeController>().updateList();
      },
      child: Container(
        constraints: const BoxConstraints(maxHeight: 90),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 4,
          ),
        ),
        child: Column(
          children: [
            _ProjectName(projectViewModel: projectViewModel),
            Expanded(
              child: _ProjectProgress(projectModel: projectViewModel),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectName extends StatelessWidget {
  final ProjectViewModel projectViewModel;

  const _ProjectName({required this.projectViewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(projectViewModel.name),
          Icon(
            JobTimerIcons.angle_double_right,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class _ProjectProgress extends StatelessWidget {
  final ProjectViewModel projectModel;

  const _ProjectProgress({required this.projectModel});

  @override
  Widget build(BuildContext context) {
    final totalTasks = projectModel.tasks
        .fold<int>(0, (previousValue, task) => previousValue += task.duration);
    var percent = 0.0;
    if (totalTasks > 0) {
      percent = totalTasks / projectModel.estimate;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: Colors.grey[400]!,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text('${projectModel.estimate}h'),
          )
        ],
      ),
    );
  }
}
