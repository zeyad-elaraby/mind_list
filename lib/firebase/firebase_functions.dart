import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_list/firebase/task_model.dart';
import 'package:mind_list/firebase/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (taskModel, _) {
        return taskModel.toJson();
      },
    );
  }

  static void addTask(TaskModel taskModel) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    taskModel.id = docRef.id;
    docRef.set(taskModel);
  }

  static Stream<QuerySnapshot<TaskModel>> getTask(DateTime date) {
    var collection = getTasksCollection();
    return collection
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date",
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    var collection = getTasksCollection();
    return collection.doc(id).delete();
  }

  static Future<void> updateTask(TaskModel taskModel) {
    var collection = getTasksCollection();
    return collection.doc(taskModel.id).update(taskModel.toJson());
  }

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()!),
          toFirestore: (userModel, options) => userModel.toJson(),
        );
  }

  static addUser(UserModel userModel) {
    var collection = getUserCollection();
    var docRef = collection.doc(userModel.id);
    return docRef.set(userModel);
  }

  static Future<UserModel?> readUser() async {
    var collection = getUserCollection();
    DocumentSnapshot<UserModel> docRef = await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    var userData = docRef.data();
    return userData;
  }

  static Future<UserCredential?> createUserAccount(
      {required String email,
      required String password,
      required String userName,
      required int age,
      required String phone,
      required Function onSuccess,
      required Function onError}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = UserModel(
          id: credential.user!.uid,
          name: userName,
          email: email,
          age: age,
          phone: phone);
      addUser(userModel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e);
      } else if (e.code == 'email-already-in-use') {
        onError(e.toString());
      }
    } catch (e) {
      onError(e.toString());
    }
  }

  static Future<UserCredential?> loginInUser(
      {required String emailAddress,
      required String password,
      required Function onSuccess,
      required Function onError}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      if (credential != null) {
        onSuccess(credential.user);
      }
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.code} - ${e.message}");
      if (e.code == 'user-not-found') {
        onError("user not found");
      } else if (e.code == 'invalid-credential') {
        onError("wrong email or password");
      }else if (e.code == 'too-many-requests') {
        onError("Too many failed attempts. Please try again later.");
      }  else {
        onError("An error occurred. Please try again.");
      }
    } catch (e) {
      onError("An unexpected error occurred. Please try again.");
    }
  }
}
