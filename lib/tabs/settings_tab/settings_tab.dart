import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_list/app_colors.dart';
import 'package:mind_list/auth_screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:mind_list/bottom_sheets/language_bottom_sheet.dart';
import 'package:mind_list/bottom_sheets/theme_bottom_sheet.dart';
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "sign_out".tr(),
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
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "delete_account".tr(),
                        ),
                        InkWell(
                          onTap: () => signOutDialog(context),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/delete_account.png"))),
                          ),
                        )
                      ],
                    ),
                  )
                ],
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
              title: "confirm_sign_out".tr(),
              description: 'are_you_sure_you_want_to_sign_out'.tr(),
              leftButtonText: "cancle".tr(),
              leftButtonColor: Colors.blue[300]!,
              rightButtonTex: "sign_out".tr(),
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
  void signOutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => ConfirmationDialog(
          title: "confirm_delete_account".tr(),
          description: 'are_you_sure_you_want_to_delete_your_account'.tr(),
          leftButtonText: "cancle".tr(),
          leftButtonColor: Colors.blue[300]!,
          rightButtonTex: "delete".tr(),
          rightButtonColor: Colors.red[300]!,
          onConfirmed: () async {
            try {
              User? user = FirebaseAuth.instance.currentUser;

              if (user == null) {
                return; // No user is logged in
              }

              // Get the user's last sign-in method
              List<UserInfo> providerData = user.providerData;
              String? email = user.email;

              // If the user signed in with email & password, reauthenticate
              if (providerData.any((info) => info.providerId == "password") &&
                  email != null) {
                String? password = await showPasswordPrompt(context);

                if (password == null) return; // User canceled reauthentication

                AuthCredential credential =
                EmailAuthProvider.credential(email: email, password: password);
                await user.reauthenticateWithCredential(credential);
              }

              // Now delete the account
              await user.delete();

              // Navigate to OnBoardingScreen
              Navigator.pushNamedAndRemoveUntil(
                context,
                OnBoardingScreen.routeName,
                    (route) => false,
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error: ${e.toString()}")),
              );
            }
          },
        ));
  }

// Helper function to show password prompt for reauthentication
  Future<String?> showPasswordPrompt(BuildContext context) async {
    String? password;
    await showDialog(
        context: context,
        builder: (context) {
          TextEditingController controller = TextEditingController();
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            title: Text("reauthenticate".tr(), style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Colors.white)),
            content: TextField(
              controller: controller,
              obscureText: true,
              decoration: InputDecoration(labelText: "enter_your_password".tr()),
            ),
            actions: [

              Row(
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("cancle".tr(),style: TextStyle(fontSize: 20,color: Colors.blue[300]!))),
                  TextButton(
                      onPressed: () {
                        password = controller.text;
                        Navigator.pop(context);
                      },
                      child: Text("confirm".tr(),style: TextStyle(fontSize: 20,color: Colors.red[300]!),)),],
              ),

            ],
          );
        });
    return password;
  }}
