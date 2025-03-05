import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mind_list/app_colors.dart';
import 'package:mind_list/firebase/firebase_functions.dart';
import 'package:mind_list/firebase/task_model.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = "EditTaskScreen";
  EditTaskScreen({super.key});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  late TextEditingController titleController=TextEditingController();
  late TextEditingController descriptionController=TextEditingController();
  TaskModel? taskModel;
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    if(taskModel==null){
      taskModel =
      ModalRoute.of(context)?.settings.arguments as TaskModel;
      titleController.text= taskModel?.title??"";
      descriptionController.text =  taskModel?.description??"";

      selectedDate = DateTime.fromMillisecondsSinceEpoch(taskModel?.date??0);
    }


    return Scaffold(
        appBar: AppBar(
          title: Text("edit_screen".tr()),
        ),
        body: Stack(
          children: [
            Container(
              height: screenHeight * 0.08,
              color: AppColors.primaryColor,
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.1),
                child: Card(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "edit_task".tr(),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "enter_task_title".tr();
                              }
                            },
                            controller: titleController,
                            style: Theme.of(context).textTheme.bodySmall,
                            cursorColor: AppColors.primaryColor,
                            decoration: InputDecoration(
                              label: Text(
                                "enter_task_title".tr(),
                                style: Theme.of(context).textTheme.labelSmall!,
                              ),
                              enabled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide: BorderSide(
                                      color: AppColors.primaryColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide: BorderSide(
                                      color: AppColors.primaryColor)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide:
                                      BorderSide(color: AppColors.errorColor)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide:
                                      BorderSide(color: AppColors.errorColor)),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "enter_task_description".tr();
                              }
                            },
                            controller: descriptionController,
                            style: Theme.of(context).textTheme.bodySmall,
                            cursorColor: AppColors.primaryColor,
                            decoration: InputDecoration(
                              label: Text(
                                "enter_task_description".tr(),
                                style: Theme.of(context).textTheme.labelSmall!,
                              ),
                              enabled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide: BorderSide(
                                      color: AppColors.primaryColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide: BorderSide(
                                      color: AppColors.primaryColor)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide:
                                      BorderSide(color: AppColors.errorColor)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide:
                                      BorderSide(color: AppColors.errorColor)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: context.locale ==Locale("en")? EdgeInsets.only(left: 5):EdgeInsets.only(right: 5),
                          child: Text("select_time".tr()),
                        ),
                        InkWell(
                            onTap: () {
                              showCalendar();
                            },
                            child: Text(
                              selectedDate.toString().substring(0, 10),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            )),
                        Spacer(),
                        Padding(
                          padding:  EdgeInsets.only(bottom: screenHeight*0.05),
                          child: Center(
                            child: FloatingActionButton(
                              onPressed: () {
                                return updateTask();
                              },
                              child: Icon(
                                Icons.check,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ));
  }

  updateTask() async{
    if (_formKey.currentState?.validate() == true) {
      TaskModel taskModel = TaskModel(
          title: titleController.text,
          description: descriptionController.text,
          date: DateUtils.dateOnly(selectedDate!).millisecondsSinceEpoch
          ,isDone: this.taskModel?.isDone??false,
        id: this.taskModel?.id??"",

      );
     await FirebaseFunctions.updateTask(taskModel);
      Navigator.pop(context);
      print("============================done=====================");
    }
  }

  void showCalendar() async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      firstDate: selectedDate??DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
      initialDate: selectedDate,
    );

    setState(() {
      selectedDate = chosenDate != null ? chosenDate : selectedDate;
      print(selectedDate);
    });
  }
}
