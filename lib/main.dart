import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mind_list/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {HomeScreen.routeName: (contex) => HomeScreen()},
    );
  }
}
