import 'package:flutter/material.dart';
import 'package:to_do_app/Model/task_model.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function(String) onToggleCompleted;
  final Function(String) onDelete;
  final bool isTablet;

  const TaskItem({
    required this.task,
    required this.onToggleCompleted,
    required this.onDelete,
    this.isTablet = false,
  });

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: isTablet ? 8 : 4,
        horizontal: isTablet ? 8 : 4,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: isTablet ? 24 : 16,
          vertical: isTablet ? 12 : 8,
        ),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => onToggleCompleted(task.id),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          activeColor: Colors.teal,     
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: isTablet ? 20 : 16,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: isTablet ? 8 : 4),
                child: Text(
                  task.description,
                  style: TextStyle(
                    fontSize: isTablet ? 16 : 14,
                  ),
                ),
              ),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: isTablet ? 18 : 14,
                  color: Colors.grey,
                ),
                SizedBox(width: isTablet ? 8 : 4),
                Text(
                  _formatDate(task.dueDate),
                  style: TextStyle(
                    fontSize: isTablet ? 16 : 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
            size: isTablet ? 28 : 24,
          ),
          onPressed: () => onDelete(task.id),
        ),
      ),
    );
  }
}