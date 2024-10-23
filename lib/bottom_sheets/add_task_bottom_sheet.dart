import 'package:flutter/material.dart';
import 'package:mind_list/app_colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Add new Task",
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
                  return "enter task title";
                }
              },
              style: Theme.of(context).textTheme.bodySmall,
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                  label: Text(
                    " enter Task title",
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
                  return "you must enter task description";
                }
              },
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 3,
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                  label: Text(
                    "Task description",
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
                    borderSide: BorderSide(color: AppColors.errorColor)),),
            ),
            Text(
              "Select time",
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
    );
  }

  void addTask() {
    if (_formKey.currentState?.validate() == true) {}
  }

  void showCalendar()async{
    var chosenDate= await  showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    setState(() {

      selectedDate=chosenDate??selectedDate;
    });
  }
}
