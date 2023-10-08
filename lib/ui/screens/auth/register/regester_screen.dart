import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_mon_c9/model/app_user_dm.dart';
import 'package:todo_mon_c9/ui/screens/home/home_screen.dart';
import 'package:todo_mon_c9/ui/utils/dialog_utils.dart';

class RegisterScreen extends StatefulWidget {

  static const String routeName = "registerRoute";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = "";

  String password = "";

  String username = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .25,
              ),
              TextFormField(
                onChanged: (text) {
                  username = text;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "user name",
                  ),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  email = text;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Email",
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                onChanged: (text) {
                  password = text;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Password",
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .2,
              ),
              ElevatedButton(
                  onPressed: () {
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
    );
  }

  void registerAccount() async{

    try {

      showLoading(context);
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      AppUser newUser = AppUser(
          id: userCredential.user!.uid,
          email: email,
          userName: username
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




