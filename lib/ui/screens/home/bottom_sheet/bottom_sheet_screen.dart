import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_mon_c9/ui/utils/app_colors.dart';

class AddBottomSeet extends StatefulWidget {


  @override
  State<AddBottomSeet> createState() => _AddBottomSeetState();
}

class _AddBottomSeetState extends State<AddBottomSeet> {

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
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
          const TextField(
            decoration: InputDecoration(
              labelText: "Enter Your Task Title",
            ),

          ),
          const SizedBox(height: 12,),
          const TextField(
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
          const Spacer(),
          ElevatedButton(
              onPressed: (){},
              child:Text("Add"),
          ),
        ],
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
}


