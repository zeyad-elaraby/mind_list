import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mind_list/firebase_options.dart';
import 'package:mind_list/home_screen.dart';
import 'package:mind_list/my_theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mind_list/providers/theme_provider.dart';
import 'package:mind_list/tabs/task_tab/edit_task_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => ThemeProvider(),
      child: EasyLocalization(
          saveLocale: true,
          supportedLocales: [Locale("en"), Locale("ar")],
          path: 'assets/translations',
          child: MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: MyThemeData.lightTheme,
      themeMode: themeProvider.mode,
      darkTheme: MyThemeData.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        EditTaskScreen.routeName: (context) => EditTaskScreen(),
      },
    );
  }
}
