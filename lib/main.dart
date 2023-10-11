import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mon_c9/model/app_user_dm.dart';
import 'package:todo_mon_c9/shared_locale/helper.dart';
import 'package:todo_mon_c9/ui/providers/list_provider.dart';
import 'package:todo_mon_c9/ui/providers/settings_provider.dart';
import 'package:todo_mon_c9/ui/screens/auth/login/login_screen.dart';
import 'package:todo_mon_c9/ui/screens/auth/register/regester_screen.dart';
import 'package:todo_mon_c9/ui/screens/edit_todo/edit_screen.dart';
import 'package:todo_mon_c9/ui/screens/splash/splash_screen.dart';
import 'package:todo_mon_c9/ui/utils/app_theme.dart';

import 'ui/screens/home/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Future.wait(
  //     [
  //       ,
  //
  //     ]
  // );

  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  //await FirebaseFirestore.instance.disableNetwork();


  await SharedPrefernce.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListProvider(),),
        ChangeNotifierProvider(create: (context) => SettingsProvider(),),
      ],
        child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        EditScreen.routeName: (_) => EditScreen(),
      },
      initialRoute:SharedPrefernce.getData(key: "currentUser").isEmpty? SplashScreen.routeName : HomeScreen.routeName,
    );
  }

}