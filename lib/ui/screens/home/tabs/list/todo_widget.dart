import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_mon_c9/model/todo_dm.dart';
import 'package:todo_mon_c9/ui/utils/app_colors.dart';
import 'package:todo_mon_c9/ui/utils/app_theme.dart';

class ToDo extends StatelessWidget {

  TodoDM model;

  ToDo({required this.model});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key("0"),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: .3,
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (_) {
              FirebaseFirestore.instance
                  .collection(TodoDM.collectionName)
                  .doc(model.id)
                  .delete()
                  .timeout(Duration(milliseconds: 200), onTimeout: () {
                //provider.getTodosFromFirestore();
              });
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * .12,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                    style: AppTheme.taskTitleTextStyle,
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
          ],
        ),
      ),
    );
  }
}
