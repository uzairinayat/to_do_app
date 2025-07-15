import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Model/task_model.dart';
import 'package:to_do_app/Provider/taskprovider.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({Key? key}) : super(key: key);

  void _showAddTaskBottomSheet(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    DateTime dueDate = DateTime.now();
    String dateText = 'Today';

    showModalBottomSheet(
      backgroundColor: Colors.teal,
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add New Task',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    floatingLabelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),

                SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    floatingLabelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Date: ',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      dateText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: dueDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: Colors
                                      .teal,
                                  onPrimary: Colors
                                      .white, 
                                  onSurface: Colors.black, 
                                ),
                                scaffoldBackgroundColor: Colors.white,
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (selectedDate != null) {
                          dueDate = selectedDate;
                          final now = DateTime.now();
                          if (dueDate.year == now.year &&
                              dueDate.month == now.month &&
                              dueDate.day == now.day) {
                            dateText = 'Today';
                          } else {
                            dateText =
                                '${dueDate.day}/${dueDate.month}/${dueDate.year}';
                          }
                          (ctx as Element).markNeedsBuild();
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),

                    SizedBox(width: 8),
                    ElevatedButton(
                      child: Text(
                        'Add Task',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        if (titleController.text.isNotEmpty) {
                          final newTask = Task(
                            id: DateTime.now().toString(),
                            title: titleController.text,
                            description: descriptionController.text,
                            dueDate: dueDate,
                          );
                          taskProvider.addTask(newTask);
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add, color: Colors.white),
      backgroundColor: Colors.teal,
      onPressed: () => _showAddTaskBottomSheet(context),
    );
  }
}
