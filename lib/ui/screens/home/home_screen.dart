import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:todo_mon_c9/model/app_user_dm.dart';
import 'package:todo_mon_c9/shared_locale/helper.dart';
import 'package:todo_mon_c9/ui/bottom_sheet/bottom_sheet_screen.dart';
import 'package:todo_mon_c9/ui/providers/list_provider.dart';
import 'package:todo_mon_c9/ui/providers/settings_provider.dart';
import 'package:todo_mon_c9/ui/screens/auth/login/login_screen.dart';
import 'package:todo_mon_c9/ui/screens/home/tabs/list/list_screen.dart';
import 'package:todo_mon_c9/ui/screens/home/tabs/settings/settings_screen.dart';
import 'package:todo_mon_c9/ui/utils/app_colors.dart';
import 'package:todo_mon_c9/ui/utils/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = "home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  List<Widget> Screens =
  [
    ListScreen(),
    SettingsScreen(),
  ];

  late ListProvider listProvider;
  late SettingsProvider settingsProvider;
  late bool isDark;
  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    settingsProvider = Provider.of(context);
    isDark = settingsProvider.isDarkEnabled();
    return Scaffold(
      backgroundColor:settingsProvider.isDarkEnabled()? AppColors.backGroundDark: AppColors.accent,
      appBar: AppBar(
        elevation: 0.00,
        backgroundColor: AppColors.primary,
        title: Text(
          currentIndex == 1? AppLocalizations.of(context)!.settings : "${AppLocalizations.of(context)!.welcome} ${AppUser.currentUser!.userName}",
          style:settingsProvider.isDarkEnabled()? AppTheme.appBarTextStyle.copyWith(color: AppColors.black):AppTheme.appBarTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: (){
              logout();
            },
           icon:const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: Screens[currentIndex],
      floatingActionButton:currentIndex == 1? null : FloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }

  FloatingButton() => FloatingActionButton(
        onPressed: () {
          showBottomSheet();
          setState(() {});
        },
        child: Icon(
            Icons.add
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 3, color: AppColors.white),
            borderRadius: BorderRadius.circular(50)),

      );

  BottomBar() => BottomAppBar(
        child: Theme(
          data:Theme.of(context).copyWith(
            canvasColor: settingsProvider.isDarkEnabled()?
            AppColors.accentDark : AppColors.white,
          ),
          child: BottomNavigationBar(
            unselectedItemColor:settingsProvider.isDarkEnabled()?AppColors.white:AppColors.black,
            unselectedLabelStyle: TextStyle(color:settingsProvider.isDarkEnabled()?AppColors.white:AppColors.black),
            currentIndex: currentIndex,
            onTap: (index) {
              currentIndex = index;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list,), label: AppLocalizations.of(context)!.list),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: AppLocalizations.of(context)!.settings),
            ],
          ),
        ),
        clipBehavior: Clip.hardEdge,
        notchMargin: 5,
        shape: CircularNotchedRectangle(),
      );

  void showBottomSheet () =>showModalBottomSheet(
      context: context,
      builder: (context) => AddBottomSeet(),
  );


  Future<AppUser> getUserFromFireStore(String id) async{

    CollectionReference<AppUser> usersCollection = AppUser.collection();

    DocumentSnapshot<AppUser> documentSnapshot = await usersCollection.doc(id).get();

    return documentSnapshot.data()!;


  }

  void logout() {
    showDialog(
      builder:(_) {
        return  AlertDialog(
          content:Container(
            height: MediaQuery.of(context).size.height * .1,
            width: MediaQuery.of(context).size.width * .5,
            child: Column(
              children: [
                 Text(
                  "You want to Log out ?",
                  style: TextStyle(
                    color: isDark? AppColors.white:AppColors.black,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                         Navigator.pop(context);
                        },
                        child:const Text("Cancel")),
                    ElevatedButton(
                        onPressed: (){
                          AppUser.currentUser = null;
                          SharedPrefernce.putData(key: "currentUser" ,user: '');
                          listProvider.todos.clear();
                          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                        },
                        child:const Text("Logout"),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
          backgroundColor: isDark? AppColors.accentDark: AppColors.white,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color:isDark? AppColors.white: AppColors.black)
          ),
        );
      } ,
      context: context ,
      barrierDismissible: false,
    );
  }
}
