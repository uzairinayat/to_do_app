import 'package:flutter/material.dart' hide FilterChip;
import 'package:provider/provider.dart';
import 'package:to_do_app/Model/task_model.dart';
import 'package:to_do_app/Provider/taskprovider.dart';
import 'package:to_do_app/Widgets/add_task_button.dart';
import 'package:to_do_app/Widgets/filter.dart';
import 'package:to_do_app/Widgets/task_items.dart';

class MyTaskPage extends StatefulWidget {
  @override
  _MyTaskPageState createState() => _MyTaskPageState();
}

class _MyTaskPageState extends State<MyTaskPage> {
  TaskFilter _currentFilter = TaskFilter.all;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    List<Task> displayedTasks;
    switch (_currentFilter) {
      case TaskFilter.completed:
        displayedTasks = taskProvider.completedTasks;
        break;
      case TaskFilter.pending:
        displayedTasks = taskProvider.pendingTasks;
        break;
      default:
        displayedTasks = taskProvider.tasks;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Tasks',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 5),
          FilterChip(
            currentFilter: _currentFilter,
            onFilterChanged: (filter) {
              setState(() {
                _currentFilter = filter;
              });
            },
          ),
          Expanded(
            child: displayedTasks.isEmpty
                ? Center(child: Text('No tasks found'))
                : ListView(
                    children: displayedTasks
                        .map(
                          (task) => TaskItem(
                            task: task,
                            onToggleCompleted: (id) =>
                                taskProvider.toggleTaskCompletion(id),
                            onDelete: (id) => taskProvider.deleteTask(id),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
      floatingActionButton: AddTaskButton(),
    );
  }
}
