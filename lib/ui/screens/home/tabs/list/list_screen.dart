import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_mon_c9/ui/providers/list_provider.dart';
import 'package:todo_mon_c9/ui/screens/home/tabs/list/todo_widget.dart';
import 'package:todo_mon_c9/ui/utils/app_colors.dart';

class ListScreen extends StatefulWidget {

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

 late ListProvider provider ;

 @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.refreshTodosList();
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);

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
              initialDate: provider.selectedDay,
              firstDate: DateTime(2022, 1, 1),
              lastDate: DateTime(2025, 12, 29),
              onDateSelected: (date){
                provider.selectedDay = date;
                provider.refreshTodosList();
              },
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
                model: provider.todos[index],
              ),
            itemCount: provider.todos.length,
          ),
        ),
      ],
    );
  }


}
