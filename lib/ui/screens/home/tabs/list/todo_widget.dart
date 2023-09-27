import 'package:flutter/material.dart';
import 'package:todo_mon_c9/model/todo_dm.dart';
import 'package:todo_mon_c9/ui/utils/app_colors.dart';
import 'package:todo_mon_c9/ui/utils/app_theme.dart';

class ToDo extends StatelessWidget {

  TodoDM todo;

  ToDo(this.todo);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.white,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 22,
      ),
      padding: EdgeInsets.symmetric(
        vertical:25 ,
        horizontal: 18,
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 4,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "${todo.title}",
                  style:AppTheme.taskTitleTextStyle,
                ),
                Text(
                  "${todo.title}",
                  style:AppTheme.taskDescriptionTextStyle,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: (){

              },
              child: Icon(
                Icons.done,

              ),
          ),
        ],
      ),
    );
  }
}
