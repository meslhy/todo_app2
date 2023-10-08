import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mon_c9/model/app_user_dm.dart';
import 'package:todo_mon_c9/ui/bottom_sheet/bottom_sheet_screen.dart';
import 'package:todo_mon_c9/ui/providers/list_provider.dart';
import 'package:todo_mon_c9/ui/screens/auth/login/login_screen.dart';
import 'package:todo_mon_c9/ui/screens/home/tabs/list/list_screen.dart';
import 'package:todo_mon_c9/ui/screens/home/tabs/settings/settings_screen.dart';
import 'package:todo_mon_c9/ui/utils/app_colors.dart';
import 'package:todo_mon_c9/ui/utils/app_theme.dart';

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

  late ListProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome ${AppUser.currentUser!.userName}",
          style: AppTheme.appBarTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: (){
              AppUser.currentUser = null;
              provider.todos.clear();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);

            },
           icon:Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: Screens[currentIndex],
      floatingActionButton: FloatingButton(),
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
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "list"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "settings"),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        notchMargin: 5,
        shape: CircularNotchedRectangle(),
      );

  void showBottomSheet () =>showModalBottomSheet(
      context: context,
      builder: (context) =>AddBottomSeet(),
  );
}
