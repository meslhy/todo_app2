import 'package:flutter/material.dart';
import 'package:todo_mon_c9/ui/utils/app_colors.dart';


abstract class AppTheme{
  static const TextStyle appBarTextStyle = TextStyle(fontWeight: FontWeight.bold,
   fontSize: 22, color:AppColors.white);
  static const TextStyle taskTitleTextStyleNotDone = TextStyle(fontWeight: FontWeight.bold,
      fontSize: 20, color: AppColors.primary);
  static const TextStyle taskTitleTextStyleDone = TextStyle(fontWeight: FontWeight.bold,
      fontSize: 20, color: AppColors.green);
  static const TextStyle taskDescriptionTextStyle = TextStyle(fontWeight: FontWeight.normal,
      fontSize: 12, color: AppColors.lightBlack);
  static const TextStyle bottomSheetTitleTextStyle = TextStyle(fontWeight: FontWeight.normal,
      fontSize: 20, color: AppColors.black);

  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0.00,
      titleTextStyle: appBarTextStyle,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(size: 32),
        unselectedIconTheme: IconThemeData(size: 32),
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey
    ),
    scaffoldBackgroundColor: AppColors.accent,
    textTheme:const TextTheme(
      //todo: to use for style of titleBottomSheet
      bodySmall: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
        fontSize: 30
      ),
      //todo: to use for style of lable in bottomSeet
      bodyMedium: TextStyle(
          color: Color(0xff383838),
          fontWeight: FontWeight.normal,
          fontSize: 20
      ),
    ),
  );



  static ThemeData darkTheme =  ThemeData();
}