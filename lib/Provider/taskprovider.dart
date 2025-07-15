import 'package:flutter/material.dart';
import 'package:to_do_app/Model/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  List<Task> get dueTodayTasks {
    final today = DateTime.now();
    return _tasks.where((task) => 
        !task.isCompleted && 
        task.dueDate.year == today.year &&
        task.dueDate.month == today.month &&
        task.dueDate.day == today.day).toList();
  }

  List<Task> get completedTasks {
    return _tasks.where((task) => task.isCompleted).toList();
  }

  List<Task> get pendingTasks {
    return _tasks.where((task) => !task.isCompleted).toList();
  }

  bool get hasDueTodayTasks => dueTodayTasks.isNotEmpty;

  void toggleTaskCompletion(String taskId) {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index >= 0) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;

      if (_tasks[index].isCompleted && isDueToday(_tasks[index])) {
        _tasks[index].dueDate = DateTime.now();
      }
      
      notifyListeners();
    }
  }

  bool isDueToday(Task task) {
    final today = DateTime.now();
    return task.dueDate.year == today.year &&
           task.dueDate.month == today.month &&
           task.dueDate.day == today.day;
  }

  

  void addTask(Task newTask) {
    _tasks.add(newTask);
    notifyListeners();
  }



  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }
}