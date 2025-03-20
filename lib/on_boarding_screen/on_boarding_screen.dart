import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mind_list/app_colors.dart';
import 'package:mind_list/bottom_sheets/language_bottom_sheet.dart';
import 'package:mind_list/login_screen/login_screen.dart';
import 'package:mind_list/signup_screen/signup_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  static const routeName = "OnBoardingScreen";
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/onboarding_image.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: height * 0.55, bottom: height * 0.03),
                  child: Image.asset(
                    "assets/images/app_logo.png",
                    height: height * 0.12,
                    width: width * 0.09,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    child: Text("login".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.black)))),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignupScreen.routeName);
                    },
                    child: Text(
                      "sign_up".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: AppColors.blackColor),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.whiteColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.black)))),
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: height*0.05),
                  child: InkWell(
                    onTap: () => showModalBottomSheet(context: context, builder: (context) => LanguageBottomSheet(),),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                         context.locale==Locale("ar")? "عربي": "English",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.blackColor),
                        ),
                        Icon(Icons.expand_more_sharp,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
