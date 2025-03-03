import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mind_list/app_colors.dart';
import 'package:mind_list/firebase/firebase_functions.dart';
import 'package:mind_list/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import 'task_item.dart';

class TasksTab extends StatefulWidget {
  TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          width: double.infinity,
          height: 50,
        ),
        Column(
          children: [
            EasyDateTimeLine(
              locale: context.locale.toString(),
              initialDate: dateTime,
              onDateChange: (selectedDate) {
                dateTime = selectedDate;
                setState(() {});
              },
              headerProps: EasyHeaderProps(
                monthPickerType: MonthPickerType.switcher,
                dateFormatter: DateFormatter.fullDateDMY(),
                selectedDateStyle: TextStyle(
                    color: themeProvider.mode == ThemeMode.light
                        ? AppColors.backgroundLightColor
                        : AppColors.whiteColor),
              ),
              dayProps: EasyDayProps(
                  dayStructure: DayStructure.dayStrDayNum,
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        gradient: SweepGradient(colors: [
                          Color(0xFF5580E9),
                          Color(0xFFE3F2FD),
                        ])),
                  ),
                  todayStyle: DayStyle(
                      dayNumStyle: TextStyle(
                          color: themeProvider.mode == ThemeMode.light
                              ? AppColors.primaryColor
                              : AppColors.whiteColor)),
                  inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: themeProvider.mode == ThemeMode.light
                                  ? AppColors.blackColor
                                  : AppColors.whiteColor),
                          borderRadius: BorderRadius.circular(10)),
                      dayNumStyle: TextStyle(
                          color: themeProvider.mode == ThemeMode.light
                              ? AppColors.blackColor
                              : AppColors.whiteColor),
                      dayStrStyle: TextStyle(
                          color: themeProvider.mode == ThemeMode.light
                              ? AppColors.blackColor
                              : AppColors.whiteColor))),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: FirebaseFunctions.getTask(dateTime),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Column(
                    children: [Center(child: Text("something went wrong "))],
                  );
                }

                var tasks = snapshot.data?.docs.map((e) => e.data()).toList();

                if (tasks?.isEmpty ?? true) {
                  return Center(child: Text("no_tasks".tr()));
                }

                return Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.separated(
                    itemBuilder: (context, index) =>
                        TaskItem(model: tasks[index]),
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: 10,
                    ),
                    itemCount: tasks!.length,
                  ),
                ));
              },
            )
          ],
        ),
      ],
    );
  }
}
