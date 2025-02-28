import 'package:flutter/material.dart';
import 'package:mind_list/app_colors.dart';
import 'package:mind_list/bottom_sheets/language_bottom_sheet.dart';
import 'package:mind_list/bottom_sheets/theme_bottom_sheet.dart';
import 'package:mind_list/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "Language",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: themeProvider.mode == ThemeMode.light
                        ? AppColors.whiteColor
                        : AppColors.secondaryDarkColor,
                    border: Border.all(color: AppColors.primaryColor)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "english",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => LanguageBottomSheet(),
                            );
                          },
                          icon: Icon(Icons.keyboard_arrow_down))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "Mode",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: themeProvider.mode == ThemeMode.light
                        ? AppColors.whiteColor
                        : AppColors.secondaryDarkColor,
                    border: Border.all(color: AppColors.primaryColor)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(themeProvider.mode==ThemeMode.light?"Light":"Dark",style: TextStyle(color: AppColors.primaryColor),
                      ),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => ThemeBottomSheet());
                          },
                          icon: Icon(Icons.keyboard_arrow_down))
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
