import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mind_list/app_colors.dart';
import 'package:mind_list/providers/auth_provider.dart';
import 'package:mind_list/tabs/settings_tab/settings_tab.dart';
import 'package:mind_list/tabs/task_tab/tasks_tab.dart';
import 'package:provider/provider.dart';
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

    var authProvider= Provider.of<AuthenticationProvider>(context);

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: RichText(text: TextSpan(children: [
          TextSpan(text: "hello ",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Color(0xFF191970)),),
          TextSpan(text: authProvider.userModel?.name??"",style: Theme.of(context).textTheme.titleLarge!.copyWith(overflow: TextOverflow.ellipsis,),),


        ])),
      ),
      body: tabs[bottomNavIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            
            context: context,
            builder: (context) => Padding(
              padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddTaskBottomSheet(),
            ),
          );        },
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


  List<Widget> tabs = [
    TasksTab(),
    SettingsTab(),
  ];
}
