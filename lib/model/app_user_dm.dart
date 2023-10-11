import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_mon_c9/shared_locale/helper.dart';

class AppUser{

  static const collectionName = "users" ;
  static AppUser? currentUser =AppUser.fromJSON(jsonDecode(SharedPrefernce.getData(key: "currentUser")));
  late String id ;
  late String email;
  late String userName;

  AppUser({
    required this.id,
    required this.email,
    required this.userName,
  });

  AppUser.fromJSON(Map json){
    id = json["id"];
    email = json["email"];
    userName = json["userName"];
  }

    Map<String , Object?> toJSON(){
    return
    {
      "id": id,
      "email": email,
      "userName": userName,
  };
  }

  static CollectionReference<AppUser> collection(){
    return FirebaseFirestore.instance.collection(AppUser.collectionName).withConverter(
        fromFirestore:(snapshot, _){
          return AppUser.fromJSON(snapshot.data()!);
        } ,
        toFirestore: (user, _){
          return user.toJSON();
        }
    );
  }


}