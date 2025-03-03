import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;
  late SharedPreferences storage;

 Future<void> getTheme() async {
    storage = await SharedPreferences.getInstance();
    if(storage.getBool("isDark")??false){
      mode=ThemeMode.dark;
    }else{
      mode=ThemeMode.light;
    }
    // notifyListeners();
  }

  changeTheme(ThemeMode themeMode) {
    mode = themeMode;
    notifyListeners();
   bool isDark=mode ==ThemeMode.dark?true:false;
   _saveTheme(isDark);
  }

  _saveTheme(bool isDark) {
    storage.setBool("isDark", isDark);
  }
}
