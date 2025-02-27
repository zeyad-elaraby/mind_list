import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mind_list/firebase/task_model.dart';

class FirebaseFunctions {
static  CollectionReference<TaskModel> getTasksCollection(){
 return FirebaseFirestore.instance.collection("Tasks").withConverter<TaskModel>(fromFirestore: (snapshot, _) {
    return TaskModel.fromJson(snapshot.data()!);
  }, toFirestore: (taskModel, _) {
    return taskModel.toJson();
  },);
}
static void addTask(TaskModel taskModel){
 var collection= getTasksCollection();
 var docRef=collection.doc();
 taskModel.id=docRef.id;
 docRef.set(taskModel);
 }
 static  Stream<QuerySnapshot<TaskModel>> getTask(DateTime date) {
  var collection = getTasksCollection();
  return collection.where("date",isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch ).snapshots();
 }
 static Future<void>  deleteTask(String id){
var collection= getTasksCollection();
return collection.doc(id).delete();
 }
 static Future<void> updateTask(TaskModel taskModel){
 var collection=getTasksCollection();
 return collection.doc(taskModel.id).update(taskModel.toJson());
 }
}