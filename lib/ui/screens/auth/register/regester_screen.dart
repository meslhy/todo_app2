import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mon_c9/model/app_user_dm.dart';
import 'package:todo_mon_c9/ui/providers/settings_provider.dart';
import 'package:todo_mon_c9/ui/screens/auth/login/widgets/all_widgets.dart';
import 'package:todo_mon_c9/ui/screens/home/home_screen.dart';
import 'package:todo_mon_c9/ui/utils/app_colors.dart';
import 'package:todo_mon_c9/ui/utils/dialog_utils.dart';
import 'package:vibration/vibration.dart';

class RegisterScreen extends StatefulWidget {

  static const String routeName = "registerRoute";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController =TextEditingController();
  TextEditingController passController =TextEditingController();
  TextEditingController userNameController =TextEditingController();
  bool isPassShown = false;
  IconData icon = Icons.remove_red_eye_outlined;
  late SettingsProvider settingsProvider;

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
            "Register",
          style: TextStyle(
            color: settingsProvider.isDarkEnabled()? AppColors.black:AppColors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold

          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Center(
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
              children: [
                Text(
                  "Create your account",
                  style: TextStyle(
                      fontSize: 24,
                      color: settingsProvider.isDarkEnabled()? AppColors.white:AppColors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                textFF(controller: userNameController, labelText: "user name" ),
                const SizedBox(
                  height: 20,
                ),
                textFF(controller: emailController, labelText: "email" ),
                const SizedBox(
                  height: 20,
                ),
                textFF(
                  controller: passController,
                  labelText: "Password" ,
                  icon : IconButton(onPressed: (){
                    icon = isPassShown ?
                    Icons.remove_red_eye_outlined :
                    Icons.remove_outlined ;
                    isPassShown =!isPassShown;
                    setState(() {});
          }, icon: Icon(icon),),
                  isPass: true,
                  isShown: isPassShown
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async{
                      registerAccount();
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      child: Row(
                        children: [
                          Text(
                            "Create account",
                            style: TextStyle(fontSize: 18),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void registerAccount() async{

    try {

      showLoading(context);
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );

      AppUser newUser = AppUser(
          id: userCredential.user!.uid,
          email: emailController.text,
          userName: userNameController.text
      );
      AppUser.currentUser = newUser;
      await registerUserInFireStore(newUser);
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


  Future registerUserInFireStore(AppUser user)async {


    CollectionReference<AppUser> userCollection =
    AppUser.collection();

    await userCollection.doc(user.id).set(user);
    
  }
}




