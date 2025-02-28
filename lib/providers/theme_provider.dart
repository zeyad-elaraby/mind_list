import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
ThemeMode mode=ThemeMode.light;
changeTheme(ThemeMode themeMode){
mode=themeMode;
notifyListeners();

}
}