import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:mind_list/app_colors.dart';
import 'package:mind_list/firebase/firebase_functions.dart';

import 'task_item.dart';

class TasksTab extends StatefulWidget {
   TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
DateTime dateTime =DateTime.now();

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
              initialDate: dateTime,
              onDateChange: (selectedDate) {
                dateTime=selectedDate;
                setState(() {

                });
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
            StreamBuilder(
              stream: FirebaseFunctions.getTask(dateTime),
              builder: (BuildContext context,  snapshot) {

                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(snapshot.hasError){
                  return Column(
                    children: [
                      Center(child: Text("something went wrong "))
                    ],
                  );
                }

                var tasks=snapshot.data?.docs.map((e)=>e.data()).toList();

                if(tasks?.isEmpty??true){
                  return Center(child: Text("no tasks"));
                }

                return  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.separated(

                        itemBuilder: (context, index) => TaskItem(model: tasks[index]),
                        separatorBuilder: (BuildContext context, int index) => SizedBox(
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
