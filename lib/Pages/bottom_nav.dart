import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Pages/home_page.dart';
import 'package:to_do_app/Pages/mytask_page.dart';
import 'package:to_do_app/Provider/taskprovider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [HomePage(), MyTaskPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasDueToday = Provider.of<TaskProvider>(context).hasDueTodayTasks;

    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: GNav(
            gap: 8,
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            activeColor: Colors.white,
            color: Colors.grey[600],
            tabBackgroundColor: Colors.teal,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
                leading: hasDueToday
                    ? Stack(
                        children: [
                          Icon(Icons.home,),
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 8,
                                minHeight: 8,
                              ),
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
              GButton(icon: Icons.task, text: 'My Tasks'),
            ],
          ),
        ),
      ),
    );
  }
}
