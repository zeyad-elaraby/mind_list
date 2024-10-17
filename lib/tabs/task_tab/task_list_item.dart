import 'package:flutter/material.dart';
import 'package:mind_list/app_colors.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          color: AppColors.whiteColor, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 62,
              width: 4,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(35)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "title",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  Text(
                    "description",
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: Icon(
                Icons.check,
                color: AppColors.whiteColor,
                size: 40,
              ),
              style: ButtonStyle(
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  backgroundColor:
                  WidgetStatePropertyAll(AppColors.primaryColor)),
            )
          ],
        ),
      ),

    );
  }
}
