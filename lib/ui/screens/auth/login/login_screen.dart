import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mon_c9/model/app_user_dm.dart';
import 'package:todo_mon_c9/shared_locale/helper.dart';
import 'package:todo_mon_c9/ui/providers/settings_provider.dart';
import 'package:todo_mon_c9/ui/screens/auth/login/widgets/all_widgets.dart';
import 'package:todo_mon_c9/ui/screens/auth/register/regester_screen.dart';
import 'package:todo_mon_c9/ui/screens/home/home_screen.dart';
import 'package:todo_mon_c9/ui/utils/app_colors.dart';
import 'package:todo_mon_c9/ui/utils/dialog_utils.dart';
import 'package:vibration/vibration.dart';

class LoginScreen extends StatefulWidget {

  static const String routeName = "loginRoute";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =TextEditingController();
  TextEditingController passController =TextEditingController();
  bool isPassShown = false;
  IconData icon = Icons.remove_red_eye_outlined;
  late SettingsProvider settingsProvider;

  @override
  Widget build(BuildContext context) {
    settingsProvider =Provider.of(context);
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title:Text(
            "Login",
          style: TextStyle(
            color: settingsProvider.isDarkEnabled()? AppColors.black:AppColors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),
        toolbarHeight: MediaQuery
            .of(context)
            .size
            .height * .1,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(24),
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width *.8,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color:settingsProvider.isDarkEnabled()? AppColors.accentDark:AppColors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Welcome back !",
                  style: TextStyle(
                      fontSize: 24,
                      color:settingsProvider.isDarkEnabled()? AppColors.white:AppColors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              textFF(labelText: "email" , controller: emailController ),
              const SizedBox(
                height: 20,
              ),
              textFF(
                  controller: passController,
                  labelText: "Password" ,
                  isPass: true,
                  isShown: isPassShown,
                  icon: IconButton(onPressed: (){
                    icon = isPassShown ? Icons.remove_red_eye_outlined : Icons.remove_outlined ;
                    setState(() {});
                    isPassShown =!isPassShown;
                  }, icon: Icon(icon)),
              ),
              const SizedBox(
                height: 26,
              ),
              ElevatedButton(
                  onPressed: () {
                    login();
                  },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: AppColors.primary)
                      ),
                  ),
                ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    child: Row(
                      children: [
                        Text("Login", style: TextStyle(fontSize: 18),),
                        Spacer(),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ),
              ),
              const SizedBox(height: 18,),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RegisterScreen.routeName);
                },
                child:  Text(
                  "Create account",
                  style: TextStyle(fontSize: 18, color: settingsProvider.isDarkEnabled()? AppColors.white:AppColors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  void login() async{

    try {

      showLoading(context);
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );

      AppUser currentUser = await getUserFromFireStore(userCredential.user!.uid);
      AppUser.currentUser =currentUser;
      SharedPrefernce.putData(key: "currentUser", user: jsonEncode(currentUser.toJSON()));
      hideLoading(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {

      hideLoading(context);
      showErrorDialog(
        context,
        e.message ?? "Something wrong. please try again!",
      );

    } catch (e) {
      hideLoading(context);
    }
  }

   Future<AppUser> getUserFromFireStore(String id) async{

    CollectionReference<AppUser> usersCollection = AppUser.collection();

     DocumentSnapshot<AppUser> documentSnapshot = await usersCollection.doc(id).get();

     return documentSnapshot.data()!;


  }


}

