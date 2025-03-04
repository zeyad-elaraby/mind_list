import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mind_list/app_colors.dart';
import 'package:mind_list/firebase/firebase_functions.dart';
import 'package:mind_list/firebase/task_model.dart';
import 'package:mind_list/providers/theme_provider.dart';
import 'package:mind_list/tabs/task_tab/edit_task_screen.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatelessWidget {
  TaskItem({required this.model, super.key});
  TaskModel model;
  @override
  Widget build(BuildContext context) {
  ThemeProvider _themeProvider=Provider.of<ThemeProvider>(context);
    DateTime taskDate = DateTime.fromMillisecondsSinceEpoch(model.date);
    return Slidable(
      startActionPane:
          ActionPane(extentRatio: 0.4, motion: DrawerMotion(), children: [
        Theme(
          data: ThemeData(
              textTheme: TextTheme(bodySmall: TextStyle(fontSize: 12))),
          child: SlidableAction(
            onPressed: (context) {
              FirebaseFunctions.deleteTask(model.id);
            },
            icon: Icons.delete,
            label: "delete",
            backgroundColor: Colors.red,
            borderRadius: context.locale == Locale("en")
                ? BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20))
                : BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
          ),
        ),
      ]),
      endActionPane:
          ActionPane(extentRatio: 0.4, motion: DrawerMotion(), children: [
        Theme(
          data: ThemeData(
            textTheme: TextTheme(
              bodySmall:
                  TextStyle(fontSize: 12), // Adjust this to a smaller size
            ),
          ),
          child: SlidableAction(
            onPressed: (BuildContext context) {
              Navigator.pushNamed(context, EditTaskScreen.routeName,
                  arguments: model);
            },
            icon: Icons.edit,
            label: "edit",
            backgroundColor: Colors.blue,
            borderRadius: context.locale == Locale("en")
                ? BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))
                : BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
          ),
        ),
      ]),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color:_themeProvider.mode==ThemeMode.light? AppColors.whiteColor:AppColors.secondaryDarkColor,
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                height: 62,
                width: 4,
                decoration: BoxDecoration(
                    color: model.isDone == true
                        ? AppColors.greenColor
                        : AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(35)),
              ),
              Expanded(
                child: Padding(
                  padding: context.locale == Locale("en")
                      ? EdgeInsets.only(left: 20)
                      : EdgeInsets.only(right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        model.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: model.isDone == true
                                    ? AppColors.greenColor
                                    : AppColors.primaryColor),
                      ),
                      Text(
                        model.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 20,
                            color:_themeProvider.mode==ThemeMode.dark? AppColors.whiteColor:AppColors.secondaryDarkColor,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            "${taskDate.year}/${taskDate.month}/${taskDate.day}",
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              model.isDone == true
                  ? InkWell(
                      onTap: () {
                        model.isDone = false;
                        FirebaseFunctions.updateTask(model);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          "Done",
                          style: TextStyle(color: AppColors.greenColor),
                        ),
                      ))
                  : Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          model.isDone = true;
                          FirebaseFunctions.updateTask(model);
                        },
                        child: Icon(
                          Icons.check,
                          color: AppColors.whiteColor,
                          size: 40,
                        ),
                        style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor:
                                WidgetStatePropertyAll(AppColors.primaryColor)),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
