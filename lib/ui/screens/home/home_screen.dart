import 'package:flutter/material.dart';
import 'package:todo_mon_c9/ui/screens/home/bottom_sheet/bottom_sheet_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To Do List",
          style: AppTheme.appBarTextStyle,
        ),
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
      builder: (context) =>AddBottomSeet() ,
  );
}
