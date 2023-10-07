import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void showLoading(BuildContext context){

  showDialog(
    builder:(_) {
       return  AlertDialog(
        content:Row(
          children: [
            Text(
                "Loading...",
            ),
            Spacer(),
            LoadingAnimationWidget.inkDrop(
                color: Colors.blue,
                size: 20),
          ],
        ),
      );
    } ,
    context: context ,
    barrierDismissible: false,
  );
}


void hideLoading(BuildContext context){
  Navigator.pop(context);
}


void showErrorDialog(BuildContext context , String message){

  showDialog(
    builder:(_) {
      return  CupertinoAlertDialog(
        content:Text(message),
        title: const Text("Error!"),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("OK"),
          ),
        ],
      );
    } ,
    context: context ,
    barrierDismissible: false,
  );
}