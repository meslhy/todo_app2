import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_mon_c9/model/app_user_dm.dart';
import 'package:todo_mon_c9/model/todo_dm.dart';
import 'package:todo_mon_c9/ui/providers/list_provider.dart';
import 'package:todo_mon_c9/ui/screens/edit_todo/edit_screen.dart';
import 'package:todo_mon_c9/ui/utils/app_colors.dart';
import 'package:todo_mon_c9/ui/utils/app_theme.dart';

class ToDo extends StatelessWidget {

  TodoDM model;

  ToDo({required this.model});

  late ListProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * .12,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Slidable(
        key: Key("0"),
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: 1,
          children: [
            // A SlidAbleAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (_) {
               AppUser.collection().doc(AppUser.currentUser!.id)
                    .collection(TodoDM.collectionName)
                    .doc(model.id)
                    .delete()
                    .then((_){
                   provider.refreshTodosList();
                });
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(20),
            ),
          ],
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: InkWell(
            onTap: (){
              TodoDM.currentTodoDM = model;
              Navigator.pushNamed(context,EditScreen.routeName);
            },
            child: Row(
              children: [
                const VerticalDivider(
                  thickness: 5,
                  color: AppColors.primary,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        model.title,
                        style:model.isDone?
                        AppTheme.taskTitleTextStyleDone :
                        AppTheme.taskTitleTextStyleNotDone,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        model.description,
                        style: AppTheme.taskDescriptionTextStyle,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: ()async{
                    await setDoneOption();
                  },
                  child: model.isDone?
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Text(
                        "Done!",
                      style: TextStyle(
                        color: AppColors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 27,
                      ),
                    ),
                  ) :
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.primary),
                    child: const Icon(
                      Icons.check,
                      color: AppColors.white,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future setDoneOption() async{
    AppUser.collection().doc(AppUser.currentUser!.id).collection(TodoDM.collectionName).doc("${model.id}").update({
      "isDone": !model.isDone
    }).then((value) =>provider.refreshTodosList());


  }
}
