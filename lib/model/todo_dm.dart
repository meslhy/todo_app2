import 'package:flutter/cupertino.dart';

class TodoDM{
  static const String collectionName ="todos";
  static TodoDM? currentTodoDM;
  late String id ;
  late String title ;
  late String description ;
  late bool isDone ;
  late DateTime date ;

  TodoDM({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.date,
});

  TodoDM.fromJSON(Map json){
    id = json["id"];
    title = json["title"];
    description = json["description"];
    date =DateTime.fromMicrosecondsSinceEpoch(json["date"]) ;
    isDone = json["isDone"];
  }

  Map<String , Object?> toJson(){
    return{
      "id":id,
      "title":title,
      "description":description,
      "date":date,
      "isDone":isDone,
    };
  }
}