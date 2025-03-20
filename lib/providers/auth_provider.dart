import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_list/firebase/firebase_functions.dart';
import 'package:mind_list/firebase/user_model.dart';

class AuthenticationProvider extends ChangeNotifier {
  late User? firebaseUser;
   UserModel? userModel;

  AuthenticationProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }
  initUser() async {
    userModel = await FirebaseFunctions.readUser();
    notifyListeners();
  }
}
