// lib/providers/task_provider.dart
import 'package:flutter/material.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/services/database_service.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    try {
      _tasks = await DatabaseService().getTasks();
      notifyListeners();
    } catch (error) {
      print("Error al obtener tareas: $error");
    }
  }

  Future<void> addTask(Task task) async {
    print("Tarea creada: $task");
    await DatabaseService().insertTask(task);
    fetchTasks();
  }

  Future<void> updateTask(Task task) async {
    await DatabaseService().updateTask(task);
    fetchTasks();
  }

  Future<void> deleteTask(int id) async {
    await DatabaseService().deleteTask(id);
    fetchTasks();
  }

  Future<void> toggleCompletion(Task task) async {
    task.isCompleted = !task.isCompleted;
    await updateTask(task);
  }
}
