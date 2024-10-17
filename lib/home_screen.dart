import 'package:flutter/material.dart';
import 'package:mind_list/app_colors.dart';
import 'package:mind_list/tabs/settings_tab/settings_tab.dart';
import 'package:mind_list/tabs/task_tab/tasks_list_tab.dart';
import 'bottom_sheets/add_task_bottom_sheet.dart';
class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          "Mind List",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: tabs[bottomNavIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTaskBottomSheet();
        },
        child: Icon(
          Icons.add,
          color: AppColors.whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        child: BottomNavigationBar(
            iconSize: 20,
            onTap: (value) {
              bottomNavIndex = value;
              setState(() {});
            },
            currentIndex: bottomNavIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined), label: ""),
            ]),
      ),
    );
  }

  addTaskBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.69),
      context: context,
      builder: (context) => AddTaskBottomSheet(),
    );
  }
  List<Widget> tabs = [
    TasksListTab(),
    SettingsTab(),
  ];
}
