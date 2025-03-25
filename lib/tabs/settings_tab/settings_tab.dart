import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_list/app_colors.dart';
import 'package:mind_list/bottom_sheets/language_bottom_sheet.dart';
import 'package:mind_list/bottom_sheets/theme_bottom_sheet.dart';
import 'package:mind_list/on_boarding_screen/on_boarding_screen.dart';
import 'package:mind_list/providers/theme_provider.dart';
import 'package:mind_list/tabs/settings_tab/widgets/confirmation_dialog.dart';
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
                "language".tr(),
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
                        context.locale == Locale("en") ? "english" : "عربي",
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
                "mode".tr(),
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
                        themeProvider.mode == ThemeMode.light
                            ? "light".tr()
                            : "dark".tr(),
                        style: TextStyle(color: AppColors.primaryColor),
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
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  children: [
                    Text(
                      "sign out",
                    ),
                    InkWell(
                      onTap: () => confirmationDialog(context),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/logout_image.png"))),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  confirmationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => ConfirmationDialog(
              title: "confirm sign out",
              description: 'Are you sure you want to sign out?',
              leftButtonText: "cancle",
              leftButtonColor: Colors.blue[300]!,
              rightButtonTex: "sign out",
              rightButtonColor: Colors.red[300]!,
              onConfirmed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  OnBoardingScreen.routeName,
                  (route) => false,
                );
              },
            ));
  }
}
