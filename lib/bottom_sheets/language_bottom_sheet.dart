import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mind_list/app_colors.dart';
import 'package:mind_list/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              context.setLocale(Locale("ar"));
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "عربي",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: context.locale == Locale("ar")
                          ? AppColors.primaryColor
                          : themeProvider.mode == ThemeMode.light
                              ? AppColors.blackColor
                              : AppColors.whiteColor),
                ),
                context.locale == Locale("ar")
                    ? Icon(
                        Icons.done,
                        color: AppColors.primaryColor,
                      )
                    : SizedBox()
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              context.setLocale(Locale(
                "en",
              ));
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "English",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: context.locale == Locale("en")
                          ? AppColors.primaryColor
                          : themeProvider.mode == ThemeMode.light
                              ? AppColors.blackColor
                              : AppColors.whiteColor),
                ),
                context.locale == Locale("en")
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
