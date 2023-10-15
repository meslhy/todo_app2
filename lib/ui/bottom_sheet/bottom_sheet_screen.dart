import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mon_c9/model/app_user_dm.dart';
import 'package:todo_mon_c9/model/todo_dm.dart';
import 'package:todo_mon_c9/ui/providers/list_provider.dart';
import 'package:todo_mon_c9/ui/providers/settings_provider.dart';
import 'package:todo_mon_c9/ui/screens/auth/login/widgets/all_widgets.dart';
import 'package:todo_mon_c9/ui/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AddBottomSeet extends StatefulWidget {






  @override
  State<AddBottomSeet> createState() => _AddBottomSeetState();
}

class _AddBottomSeetState extends State<AddBottomSeet> {

  late ListProvider provider;
  late SettingsProvider settingsProvider;
  DateTime selectedDate = DateTime.now();
  bool isTyping = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late bool isDark;
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    provider =Provider.of(context);
    settingsProvider =Provider.of(context);
    isDark = settingsProvider.isDarkEnabled() ;
    return Container(
      color: isDark?AppColors.backGroundDark:AppColors.accent,
      child: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color:isDark?AppColors.white:AppColors.black),
          color: isDark?AppColors.accentDark:AppColors.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.addNewTask,
              style:isDark?
              TextStyle(
                  color: AppColors.white,fontWeight: FontWeight.bold, fontSize: 30
              ):
              Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16,),
            textFF(controller: titleController, labelText: AppLocalizations.of(context)!.taskTitleLabel , isDark: isDark),
            const SizedBox(height: 12,),
            textFF(controller: descriptionController, labelText: AppLocalizations.of(context)!.taskDescriptionLabel , isMultiLine: true ,isDark: isDark ),
            const SizedBox(height: 22,),
            Text(
              AppLocalizations.of(context)!.selectTime,
              style:isDark?
              TextStyle(
                  color: AppColors.white,fontWeight: FontWeight.bold, fontSize: 20
              ):
              Theme.of(context).textTheme.bodyMedium,
            ),
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
                child:Text(AppLocalizations.of(context)!.add),
            ),
            const Spacer(),
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




