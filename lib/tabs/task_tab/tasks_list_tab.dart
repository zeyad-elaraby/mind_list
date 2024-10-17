import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:mind_list/app_colors.dart';

import 'task_list_item.dart';

class TasksListTab extends StatelessWidget {
   TasksListTab({super.key});

  @override
  Widget build(BuildContext context) {
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
              initialDate: DateTime.now(),
              onDateChange: (selectedDate) {
                //`selectedDate` the new date selected.
              },
              headerProps: EasyHeaderProps(
                monthPickerType: MonthPickerType.switcher,
                dateFormatter: DateFormatter.fullDateDMY(),
                selectedDateStyle:
                TextStyle(color: AppColors.backgroundLightColor),
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
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.separated(

                    itemBuilder: (context, index) => TaskListItem(),
                    itemCount: 30,
                    separatorBuilder: (BuildContext context, int index) => SizedBox(
                      height: 10,
                    ),
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
