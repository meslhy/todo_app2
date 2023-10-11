import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mon_c9/shared_locale/helper.dart';
import 'package:todo_mon_c9/ui/providers/settings_provider.dart';
import 'package:todo_mon_c9/ui/utils/app_colors.dart';
import 'package:todo_mon_c9/ui/utils/app_theme.dart';

class SettingsScreen extends StatefulWidget {

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
 late bool isDark;
 late bool isAr;
  late SettingsProvider settingsProvider;

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of(context);
    isDark = settingsProvider.isDarkEnabled();
    isAr = settingsProvider.isArabicLocale();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColors.primary,
          height: MediaQuery.of(context).size.height *.1,
        ),

        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
              "Language",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.black
              ),
            ),
              const SizedBox(height: 15,),
              DropdownButtonFormField(
                key: Key("locale"),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary,width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary,width: 2)
                    ),
                    filled: true,
                    fillColor: AppColors.white
                ),
                dropdownColor:AppColors.white,
                borderRadius: BorderRadius.circular(20),
                value: isAr ? "ar":"en",
                items:<String>[
                  "en",
                  "ar"
                ].map<DropdownMenuItem<String>>((value){
                  return DropdownMenuItem(
                    value: value,
                    child:Text(
                      value,
                      style: TextStyle(fontSize: 20,color: AppColors.primary),
                    ) ,
                  );
                } ).toList(),
                onChanged: (value){
                  isAr = value=="ar"?true:false;
                  if(isAr)
                  {
                    settingsProvider.setCurrentLocale("ar");
                    SharedPrefernce.putDataBool(key: "isAR", value: true);
                  }else{
                    settingsProvider.setCurrentLocale("en");
                    SharedPrefernce.putDataBool(key: "isAR", value: false);
                  }
                },
              ),
              const SizedBox(height: 15,),
              const Text(
                "Mode",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black
                ),
              ),
              const SizedBox(height: 15,),
              DropdownButtonFormField(
                key: Key("mode"),
                value: isDark? "Dark":"Light",
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary,width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary,width: 2)
                    ),
                    filled: true,
                    fillColor: AppColors.white
                ),
                dropdownColor:AppColors.white,
                borderRadius: BorderRadius.circular(20),
                items:<String>[
                  "Dark",
                  "Light"
                ].map<DropdownMenuItem<String>>((value){
                  return DropdownMenuItem(
                    value: value,
                    child:Text(
                      value,
                      style: TextStyle(fontSize: 20,color: AppColors.primary),
                    ) ,
                  );
                } ).toList(),
                onChanged: (value){
                  isDark = value =="Dark"?true:false;
                  if(isDark)
                  {
                    settingsProvider.setCurrentMode(ThemeMode.dark);
                    SharedPrefernce.putDataBool(key: "isDark", value: isDark);
                  }else{
                    settingsProvider.setCurrentMode(ThemeMode.light);
                    SharedPrefernce.putDataBool(key: "isDark", value: isDark);
                  }
                  print(settingsProvider.currentLocale);
                  print(settingsProvider.isDarkEnabled());
                },
              ),
            ],
          ),
        ),

      ],
    );
  }
}
