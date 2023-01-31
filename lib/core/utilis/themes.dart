import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants.dart';

class Themes {
  ThemeData lightTheme() {
    return ThemeData(
        primaryColorLight: AppConstants.primaryColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: AppConstants.primaryColor,
            unselectedItemColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            unselectedLabelStyle:
                TextStyle(fontSize: 11.sp, color: Colors.black),
            selectedLabelStyle: TextStyle(
                color: AppConstants.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 13.sp)),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                foregroundColor: MaterialStateProperty.all(Colors.black))),
        primaryColor: AppConstants.primaryColor,
        brightness: Brightness.light,
        fontFamily: 'Gordita',
        scaffoldBackgroundColor: AppConstants.backgroundColor,
        appBarTheme: const AppBarTheme(
            backgroundColor: AppConstants.backgroundColor,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            systemOverlayStyle: SystemUiOverlayStyle.dark),
        colorScheme: const ColorScheme.light(primary: AppConstants.primaryColor)
            .copyWith(background: AppConstants.backgroundColor));
  }
}
