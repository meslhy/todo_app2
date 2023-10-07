import 'package:flutter/material.dart';
import 'package:todo_mon_c9/ui/screens/auth/register/regester_screen.dart';

class LoginScreen extends StatelessWidget {

  static const String routeName = "loginRoute";

  String email = "";

  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Login"),
        toolbarHeight: MediaQuery
            .of(context)
            .size
            .height * .1,
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .25,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Welcome back !",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
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
                const SizedBox(
                  height: 26,
                ),
                ElevatedButton(
                    onPressed: () {
                      login();
                    },
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
                    )),
                const SizedBox(height: 18,),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  },
                  child: const Text(
                    "Create account",
                    style: TextStyle(fontSize: 18, color: Colors.black45),
                  ),
                ),
              ],
            )
            ,
          )
      ),
    );
  }
}

void login() {

}
