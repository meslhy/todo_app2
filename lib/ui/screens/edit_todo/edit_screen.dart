import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mon_c9/model/app_user_dm.dart';
import 'package:todo_mon_c9/model/todo_dm.dart';
import 'package:todo_mon_c9/ui/providers/list_provider.dart';
import 'package:todo_mon_c9/ui/utils/app_colors.dart';
import 'package:todo_mon_c9/ui/utils/app_theme.dart';

class EditScreen extends StatefulWidget {

  static const routeName ="editRoute";

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {


  late ListProvider provider;
  late DateTime selectedDate ;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text =TodoDM.currentTodoDM!.title;
    descriptionController.text =TodoDM.currentTodoDM!.description;
    selectedDate = TodoDM.currentTodoDM!.date;
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Scaffold(
      backgroundColor: AppColors.accent,
      appBar: AppBar(
        elevation: 0.00,
        backgroundColor: AppColors.primary,
        title: Text(
          "To Do List",
          style:AppTheme.appBarTextStyle,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height ,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 15,
                  child: Container(
                    color: AppColors.primary,
                  ),
                ),
                Expanded(
                  flex: 85,
                  child: Container(
                  ),
                ),
              ],
            ),

            Center(
              child: Container(
                margin: EdgeInsets.all(24),
                height: MediaQuery.of(context).size.height * .75,
                width: MediaQuery.of(context).size.width *.8,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color:AppColors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [
                    Text(
                      "Edit Task",
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16,),
                    TextField(
                      controller:titleController ,
                      decoration: InputDecoration(
                        labelText: "Enter Your Task Title",
                      ),
                    ),
                    const SizedBox(height: 12,),
                    TextField(
                      controller:descriptionController,
                      decoration: InputDecoration(
                        labelText: "Enter Description",
                      ),
                    ),
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
                    SizedBox(height: 100,),
                    InkWell(
                      onTap: ()async{
                        await changeData();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.primary),
                        child: Center(
                          child: const Text(
                            "Save Changes",
                            style: TextStyle(
                             color: AppColors.white,
                              fontSize: 25,

                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),


              ),
            )
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

  changeData() {
    TodoDM model = TodoDM.currentTodoDM!;
    AppUser.collection().doc(AppUser.currentUser!.id).collection(TodoDM.collectionName).doc("${model.id}").update({
      "title":titleController.text,
      "description":descriptionController.text,
      "date":selectedDate.microsecondsSinceEpoch,
    }).then((value){
      provider.refreshTodosList();
      Navigator.pop(context);
    });

  }
}
