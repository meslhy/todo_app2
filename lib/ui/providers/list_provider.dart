import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_mon_c9/model/app_user_dm.dart';
import 'package:todo_mon_c9/model/todo_dm.dart';


class ListProvider extends ChangeNotifier{

  List<TodoDM>todos = [];
  DateTime selectedDay =DateTime.now();

  refreshTodosList()async{
    CollectionReference<TodoDM> collection =
    AppUser.collection().doc(AppUser.currentUser!.id).collection(TodoDM.collectionName)
        .withConverter<TodoDM>(
      fromFirestore:(snapshot, _) {
        Map json = snapshot.data() as Map ;
        TodoDM todo = TodoDM.fromJSON(json);
        return todo;
      },
      toFirestore: (todoDm, _){
        return todoDm.toJson();
      }  ,
    );

    QuerySnapshot<TodoDM> todosSnapShot =await collection.orderBy("date",descending: true).get();


    List<QueryDocumentSnapshot<TodoDM>> docs = todosSnapShot.docs;

    // for(int i = 0;i<docs.length;i++)
    // {
    //   todos.add(docs[i].data());
    // }


    //this is better than for loop

    todos = docs.map((docsSnapshot){
      return docsSnapshot.data();
    }).toList();

    // for(int i = 0;i<todos.length;i++)
    //   {
    //     if(
    //         todos[i].date.day != selectedDay.day ||
    //         todos[i].date.month != selectedDay.month ||
    //         todos[i].date.year != selectedDay.year
    //     )
    //       {
    //         todos.removeAt(i);
    //       }
    //   }

    ///better Solution

    todos = todos.where(
            (todo){
      if(todo.date.day != selectedDay.day ||
          todo.date.month != selectedDay.month ||
          todo.date.year != selectedDay.year){
        return false;
      }
      else{
        return true;
      }
    }).toList();

    notifyListeners();
  }

}