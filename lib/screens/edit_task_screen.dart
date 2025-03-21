// lib/screens/edit_task_screen.dart
import 'package:flutter/material.dart';
import 'package:todolist/providers/task_provider.dart';
import 'package:todolist/models/task.dart';
import 'package:provider/provider.dart';

class EditTaskScreen extends StatelessWidget {
  final Task task;
  final _titleController = TextEditingController();

  EditTaskScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    _titleController.text = task.title;

    return Scaffold(
      appBar: AppBar(title: Text('Editar Tarea')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título de la tarea'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text.trim();
                if (title.isNotEmpty) {
                  task.title = title;
                  Provider.of<TaskProvider>(context, listen: false)
                      .updateTask(task);
                  Navigator.pop(context);
                }
              },
              child: Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
