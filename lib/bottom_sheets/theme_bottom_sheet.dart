import 'package:flutter/material.dart';
import 'package:mind_list/app_colors.dart';
import 'package:mind_list/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.light);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Light",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: themeProvider.mode == ThemeMode.light
                          ? AppColors.primaryColor
                          : AppColors.whiteColor),
                ),
                themeProvider.mode == ThemeMode.light
                    ? Icon(
                        Icons.done,
                        color: AppColors.primaryColor,
                      )
                    : SizedBox()
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.dark);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: themeProvider.mode == ThemeMode.light
                          ? AppColors.blackColor
                          : AppColors.primaryColor),
                ),
                themeProvider.mode == ThemeMode.dark
                    ? Icon(
                        Icons.done,
                        color: AppColors.primaryColor,
                      )
                    : SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
