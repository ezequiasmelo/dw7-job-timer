import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../entities/project_status.dart';
import '../../../../view_models/project_view_model.dart';
import '../controller/project_detail_controller.dart';

class ProjectDetailAppbar extends SliverAppBar {
  ProjectDetailAppbar({
    super.key,
    required ProjectViewModel projectViewModel,
  }) : super(
          expandedHeight: 100,
          pinned: true,
          toolbarHeight: 100,
          title: Text(projectViewModel.name),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          flexibleSpace: Stack(
            children: [
              Align(
                alignment: const Alignment(0, 1.6),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${projectViewModel.tasks.length} tasks'),
                          Visibility(
                            visible: projectViewModel.status !=
                                ProjectStatus.finalizado,
                            replacement: const Text('Projeto Finalizado'),
                            child:
                                _NewTasks(projectViewModel: projectViewModel),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
}

class _NewTasks extends StatelessWidget {
  final ProjectViewModel projectViewModel;

  const _NewTasks({required this.projectViewModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Modular.to.pushNamed(
          '/project/task/',
          arguments: projectViewModel,
        );
        Modular.get<ProjectDetailController>().updateProject();
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const Text('Adicionar Task'),
        ],
      ),
    );
  }
}
