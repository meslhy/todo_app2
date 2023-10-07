import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mon_c9/ui/providers/list_provider.dart';
import 'package:todo_mon_c9/ui/screens/auth/login/login_screen.dart';
import 'package:todo_mon_c9/ui/screens/auth/register/regester_screen.dart';
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


  runApp( ChangeNotifierProvider(
    create:(context){
      return ListProvider();
    } ,
      child: MyApp()
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}