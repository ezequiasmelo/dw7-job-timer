import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/button_with_loader.dart';
import 'controller/task_controller.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, required this.controller});

  final TaskController controller;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _durationEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _durationEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskController, TaskStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        if (state == TaskStatus.success) {
          Navigator.pop(context);
        } else if (state == TaskStatus.failure) {
          AsukaSnackbar.alert('Erro ao salvar task').show();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Criar nova task',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(
                    label: Text('Nome da task'),
                  ),
                  validator: Validatorless.required('Nome obrigatório'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _durationEC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Duração da task'),
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required('Duração obrigatória'),
                    Validatorless.number('Permitido somente números'),
                  ]),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 49,
                  child: ButtonWithLoader<TaskController, TaskStatus>(
                    bloc: widget.controller,
                    selector: (state) => state == TaskStatus.loading,
                    label: 'Salvar',
                    onPressed: () {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        final name = _nameEC.text;
                        final duration = int.parse(_durationEC.text);
                        widget.controller.register(name, duration);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
