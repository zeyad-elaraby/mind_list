import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_list/app_colors.dart';
import 'package:mind_list/firebase/firebase_functions.dart';
import 'package:mind_list/firebase/task_model.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "add_new_task".tr(),
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: AppColors.primaryColor,
                      ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "you_must_enter_task_title".tr();
                  }
                },
                controller: titleController,
                style: Theme.of(context).textTheme.bodySmall,
                cursorColor: AppColors.primaryColor,
                decoration: InputDecoration(
                  label: Text(
                    "task_title".tr(),
                    style: Theme.of(context).textTheme.labelSmall!,
                  ),
                  enabled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: BorderSide(color: AppColors.primaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: BorderSide(color: AppColors.primaryColor)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: BorderSide(color: AppColors.errorColor)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: BorderSide(color: AppColors.errorColor)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "you_must_enter_task_description".tr();
                  }
                },
                controller: descriptionController,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 3,
                cursorColor: AppColors.primaryColor,
                decoration: InputDecoration(
                  label: Text(
                    "task_description".tr(),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  enabled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: BorderSide(color: AppColors.primaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: BorderSide(color: AppColors.primaryColor)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: BorderSide(color: AppColors.errorColor)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: BorderSide(color: AppColors.errorColor)),
                ),
              ),
              Text(
                "select_time".tr(),
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    showCalendar();
                  },
                  child: Text(
                    selectedDate.toString().substring(0, 10),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              // SizedBox(height: 15,),
              Spacer(),
              Center(
                child: FloatingActionButton(
                  onPressed: () {
                    return addTask();
                  },
                  child: Icon(
                    Icons.check,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addTask() {
    if (_formKey.currentState?.validate() == true) {
      TaskModel taskModel = TaskModel(
          title: titleController.text,
          description: descriptionController.text,
          date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch,
      userId: FirebaseAuth.instance.currentUser!.uid
      );
      FirebaseFunctions.addTask(taskModel);
      Navigator.pop(context);
    }
  }

  void showCalendar() async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
    }
    setState(() {});
  }
}
