import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mon_c9/shared_locale/helper.dart';
import 'package:todo_mon_c9/ui/providers/settings_provider.dart';
import 'package:todo_mon_c9/ui/screens/auth/login/login_screen.dart';
import 'package:todo_mon_c9/ui/screens/home/home_screen.dart';
import 'package:todo_mon_c9/ui/utils/app_assets.dart';
import 'package:todo_mon_c9/ui/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
  }
late SettingsProvider settingsProvider;
  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of(context);
    return Scaffold(
      body: Image.asset(
          settingsProvider.isDarkEnabled()?AppAssets.splashDark:AppAssets.splash,
        fit: BoxFit.fitHeight),
          backgroundColor:settingsProvider.isDarkEnabled()?AppColors.backGroundDark: AppColors.accent,
    );
  }
}
