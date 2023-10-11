
import 'package:flutter/material.dart';
import 'package:todo_mon_c9/shared_locale/helper.dart';

class SettingsProvider extends ChangeNotifier{
  String currentLocale = SharedPrefernce.getDataBool(key: "isAR")? "ar":"en";
  ThemeMode mode =SharedPrefernce.getDataBool(key: "isDark") ? ThemeMode.dark: ThemeMode.light;

  void setCurrentMode(ThemeMode newMode){
    mode = newMode;
    notifyListeners();
  }
  bool isDarkEnabled() => mode == ThemeMode.dark;


  void setCurrentLocale(String newLocale){
    currentLocale = newLocale;
    notifyListeners();
  }
  bool isArabicLocale() => currentLocale == "ar" ;
}