import 'package:flutter/material.dart';
import 'package:mind_list/firebase_options.dart';
import 'package:mind_list/home_screen.dart';
import 'package:mind_list/my_theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mind_list/tabs/task_tab/edit_task_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyThemeData.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        EditTaskScreen.routeName: (context) => EditTaskScreen(),
      },
    );
  }
}
