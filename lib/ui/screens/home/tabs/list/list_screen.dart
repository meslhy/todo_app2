import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_mon_c9/model/todo_dm.dart';
import 'package:todo_mon_c9/ui/screens/home/tabs/list/todo_widget.dart';
import 'package:todo_mon_c9/ui/utils/app_colors.dart';

class ListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height *.12,
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                      child: Container(
                        color: AppColors.primary,
                      ),
                  ),
                  Expanded(
                    flex: 6,
                      child: Container(
                      ),
                  ),
                ],
              ),
            ),
            CalendarTimeline(
              initialDate: DateTime.now(),
              firstDate: DateTime(2022, 1, 1),
              lastDate: DateTime(2025, 12, 29),
              onDateSelected: (date) => print(date),
              leftMargin: 20,
              monthColor: AppColors.white,
              dayColor: AppColors.primary,
              activeDayColor: AppColors.primary,
              activeBackgroundDayColor: AppColors.white,
              //selectableDayPredicate: (date) => date.weekday != 5,
              locale: 'en',
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
              itemBuilder: (context, index) => ToDo(
                  TodoDM(
                    title: "football" ,
                    description: "hi dkdk",
                    date: DateTime.now(),
                    isDone: true,
                  ),),
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
