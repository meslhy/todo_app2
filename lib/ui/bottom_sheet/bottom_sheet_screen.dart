import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mon_c9/model/app_user_dm.dart';
import 'package:todo_mon_c9/model/todo_dm.dart';
import 'package:todo_mon_c9/ui/providers/list_provider.dart';
import 'package:todo_mon_c9/ui/screens/auth/login/widgets/all_widgets.dart';
import 'package:todo_mon_c9/ui/utils/app_colors.dart';

class AddBottomSeet extends StatefulWidget {





  @override
  State<AddBottomSeet> createState() => _AddBottomSeetState();
}

class _AddBottomSeetState extends State<AddBottomSeet> {

  late ListProvider provider;
  DateTime selectedDate = DateTime.now();
  bool isTyping = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    provider =Provider.of(context);
    return Container(
      color: AppColors.accent,
      child: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.black),
          color: AppColors.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add New Task",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16,),
            textFF(controller: titleController, labelText: "Enter Your Task Title"),
            const SizedBox(height: 12,),
            textFF(controller: descriptionController, labelText: "Enter Description" , isMultiLine: true),
            const SizedBox(height: 22,),
            Text(
              "Select time",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 22,),
            InkWell(
              onTap: (){
                showMyDatePicker();
              },
              child: Text(
                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: (){
                  addTodoToFireStore();
                },
                child:Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
   showMyDatePicker()async{
     selectedDate = await showDatePicker(
       context: context,
       initialDate:selectedDate,
       firstDate: DateTime.now(),
       lastDate: DateTime.now().add(Duration(days: 365)),
     )?? selectedDate;
     setState(() {});
   }

  void addTodoToFireStore() {


    CollectionReference todosCollectionRef =
    AppUser.collection().doc(AppUser.currentUser!.id)
        .collection(TodoDM.collectionName);
    FirebaseFirestore.instance.collection(TodoDM.collectionName);

    DocumentReference newEmptyDoc = todosCollectionRef.doc();

    newEmptyDoc.set({
      "id":newEmptyDoc.id,
      "title":titleController.text,
      "description":descriptionController.text,
      "date":selectedDate.microsecondsSinceEpoch,
      "isDone": false,
    }).then((value){
      provider.refreshTodosList();
      Navigator.pop(context);
    });


  }
}




