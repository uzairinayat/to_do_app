import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Provider/quoteprovider.dart';
import 'package:to_do_app/Provider/taskprovider.dart';
import 'package:to_do_app/Widgets/quote_card.dart';
import 'package:to_do_app/Widgets/task_items.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600; // Typical tablet breakpoint
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (taskProvider.hasDueTodayTasks)
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.circle, color: Colors.red, size: 12),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? screenWidth * 0.1 : 0,
          ),
          child: Column(
            children: [
              Consumer<QuoteProvider>(
                builder: (context, quoteProvider, _) {
                  return QuoteCard(quote: quoteProvider.currentQuote);
                },
              ),

              // Tasks Section
              Padding(
                padding: EdgeInsets.all(isTablet ? 24 : 16),
                child: Text(
                  'Tasks Due Today',
                  style: TextStyle(
                    fontSize: isTablet ? 24 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (taskProvider.dueTodayTasks.isEmpty)
                Padding(
                  padding: EdgeInsets.all(isTablet ? 24 : 16),
                  child: Text(
                    'No tasks due today!',
                    style: TextStyle(fontSize: isTablet ? 18 : 16),
                  ),
                )
              else
                ...taskProvider.dueTodayTasks.map(
                  (task) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 24 : 8,
                    ),
                    child: TaskItem(
                      task: task,
                      onToggleCompleted: (id) =>
                          taskProvider.toggleTaskCompletion(id),
                      onDelete: (id) => taskProvider.deleteTask(id),
                      isTablet: isTablet,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
