import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import '../../../view_models/project_view_model.dart';
import 'controller/task_controller.dart';
import 'task_page.dart';

class TaskModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        BlocBind.lazySingleton(
          (i) => TaskController(
            projectService: i(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) {
            final ProjectViewModel projectViewModel = args.data;
            return TaskPage(
              controller: Modular.get()..setProject(projectViewModel),
            );
          },
        ),
      ];
}
