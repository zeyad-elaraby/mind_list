import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mind_list/app_constans.dart';
import 'package:mind_list/auth_screens/login_screen/login_screen.dart';
import 'package:mind_list/auth_screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:mind_list/auth_screens/signup_screen/signup_screen.dart';
import 'package:mind_list/firebase/firebase_options.dart';
import 'package:mind_list/home_screen.dart';
import 'package:mind_list/my_theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mind_list/providers/auth_provider.dart';
import 'package:mind_list/providers/theme_provider.dart';
import 'package:mind_list/tabs/task_tab/edit_task_screen.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  ThemeProvider themeProvider =ThemeProvider();
 await  themeProvider.getTheme();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (context) => themeProvider,),
        ChangeNotifierProvider(create: (context) => AuthenticationProvider(),),

      ],
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
    var authProvider=Provider.of<AuthenticationProvider>(context);
    return MaterialApp(
      scaffoldMessengerKey:scaffoldMessengerKey,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: MyThemeData.lightTheme,
      themeMode: themeProvider.mode,
      darkTheme: MyThemeData.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: authProvider.firebaseUser!=null?HomeScreen.routeName: OnBoardingScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        EditTaskScreen.routeName: (context) => EditTaskScreen(),
        OnBoardingScreen.routeName:(context)=> OnBoardingScreen(),
        SignupScreen.routeName: (context) => SignupScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
      },
    );
  }
}
