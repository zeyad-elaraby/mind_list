import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mind_list/app_colors.dart';
import 'package:mind_list/app_constans.dart';
import 'package:mind_list/firebase/firebase_functions.dart';
import 'package:mind_list/login_screen/login_screen.dart';

import '../app_colors.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});
  static const String routeName = "signup";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        // title: Text("signup"),
        backgroundColor: AppColors.whiteColor,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.lavenderBlue),
                borderRadius: BorderRadius.circular(12),
                shape: BoxShape.rectangle),
            child: Icon(
              Icons.navigate_before_rounded,
              size: 30,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 32),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "hello_register_to_get_started".tr(),
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: AppColors.blackColor,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "you_must_enter_user_name".tr();
                      }
                    },
                    controller: userNameController,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.blackColor),
                    cursorColor: AppColors.primaryColor,
                    decoration: InputDecoration(
                      fillColor: AppColors.offWhite,
                      filled: true,
                      label: Text(
                        "user_name".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Colors.grey),
                      ),
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "you_must_enter_email".tr();
                      }
                    },
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.blackColor),
                    cursorColor: AppColors.primaryColor,
                    decoration: InputDecoration(
                      fillColor: AppColors.offWhite,
                      filled: true,
                      label: Text(
                        "email".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Colors.grey),
                      ),
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "you_must_enter_phone".tr();
                      }
                    },
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.blackColor),
                    cursorColor: AppColors.primaryColor,
                    decoration: InputDecoration(
                      fillColor: AppColors.offWhite,
                      filled: true,
                      label: Text(
                        "phone".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Colors.grey),
                      ),
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "you_must_enter_age".tr();
                      }
                    },
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.blackColor),
                    cursorColor: AppColors.primaryColor,
                    decoration: InputDecoration(
                      fillColor: AppColors.offWhite,
                      filled: true,
                      label: Text(
                        "age".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Colors.grey),
                      ),
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "you_must_enter_password".tr();
                      }
                    },
                    obscureText: obscureText,
                    controller: passwordController,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.blackColor),
                    cursorColor: AppColors.primaryColor,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.all(0),
                      suffixIcon: IconButton(
                        onPressed: () {
                          obscureText = !obscureText;
                          setState(() {});
                        },
                        icon: obscureText == true
                            ? Icon(Icons.visibility_off_outlined)
                            : Icon(Icons.visibility),
                        iconSize: 25,
                        padding: EdgeInsets.all(0),
                      ),
                      fillColor: AppColors.offWhite,
                      filled: true,
                      label: Text(
                        "password".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Colors.grey),
                      ),
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lavenderBlue)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: ElevatedButton(
                      onPressed: () {
                        signUp();
                      },
                      child: Text("sign_up".tr(),
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.black)))),
                ),
                Center(
                  child: InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, LoginScreen.routeName),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "already_have_an_account?".tr(),
                          style: GoogleFonts.urbanist(
                              color: AppColors.blackColor, fontSize: 17)),
                      TextSpan(
                          text: "login_now".tr(),
                          style: GoogleFonts.urbanist(
                              color: Color(0xFF35C2C1), fontSize: 17)),
                    ])),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  signUp() {
    if (formKey.currentState!.validate()) {
      FirebaseFunctions.createUserAccount(
          email: emailController.text,
          password: passwordController.text,
          userName: userNameController.text,
          age: int.parse(ageController.text),
          phone: phoneController.text,
          onSuccess: () {
            scaffoldMessengerKey.currentState?.showSnackBar(
              SnackBar(
                content: Text('account_created_successfully'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8))),

                backgroundColor: Colors.green,
                action: SnackBarAction(
                  label: 'ok',
                  textColor: AppColors.blackColor,

                  onPressed: () {
                    // Perform an action when the user presses "Undo"
                    scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
                    print('Undo pressed!');
                  },
                ),
                duration: Duration(seconds: 3), // Optional: Set duration
              ),
            );
            Navigator.pushNamedAndRemoveUntil(
                context, LoginScreen.routeName, (context) => false);
          },
          onError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8))),
                content: Text(error),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'hide',
                  textColor: AppColors.blackColor,
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    print('Undo pressed!');
                  },
                ),
                duration: Duration(seconds: 3), // Optional: Set duration
              ),
            );
          });
      print(
          "------------------------------done----------------------------------");
    }
  }
}
