import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mind_list/app_colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundLightColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
      scrolledUnderElevation: 0
      ),
      textTheme: TextTheme(
        titleLarge:
            GoogleFonts.oxanium(color: AppColors.whiteColor,fontWeight: FontWeight.w700 , fontSize: 25),
        titleMedium:
            GoogleFonts.oxanium(color: AppColors.whiteColor,fontWeight: FontWeight.w700, fontSize: 20),
        titleSmall:
            GoogleFonts.oxanium(color: AppColors.whiteColor,fontWeight: FontWeight.w700, fontSize: 15),
        labelLarge:GoogleFonts.poppins(color: AppColors.blackColor,fontWeight: FontWeight.w400, fontSize: 25),
        labelMedium: GoogleFonts.poppins(color: AppColors.blackColor,fontWeight: FontWeight.w400, fontSize: 20),
        labelSmall: GoogleFonts.poppins(color: AppColors.blackColor,fontWeight: FontWeight.w400, fontSize: 15),

        headlineLarge: GoogleFonts.lato(color: AppColors.blackColor,fontWeight: FontWeight.w400, fontSize: 25),
        headlineMedium: GoogleFonts.lato(color: AppColors.blackColor,fontWeight: FontWeight.w400, fontSize: 20),
        headlineSmall: GoogleFonts.lato(color: AppColors.blackColor,fontWeight: FontWeight.w400, fontSize: 15),

        bodyLarge: GoogleFonts.inter(color: AppColors.blackColor,fontWeight: FontWeight.w400, fontSize: 25),
        bodyMedium: GoogleFonts.inter(color: AppColors.blackColor,fontWeight: FontWeight.w400, fontSize: 20),
        bodySmall: GoogleFonts.inter(color: AppColors.blackColor,fontWeight: FontWeight.w400, fontSize: 15),

      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.whiteColor,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.only(topRight: Radius.circular(21), topLeft: Radius.circular(21)),
        )
      ),
      bottomAppBarTheme: BottomAppBarTheme(color: AppColors.whiteColor, shape: CircularNotchedRectangle(),
        padding: EdgeInsets.all(0),
        height: 65,),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(35),
              side: BorderSide(color: AppColors.whiteColor, width: 4))),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.greyColor,
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ));
}
