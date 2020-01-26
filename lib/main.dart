import 'package:flutter/material.dart';
import 'package:todooo/todo_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todooo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoListPage(),
    );
  }
}

class ToDo {
  String content;
  String deadline;
  ToDo(this.content, this.deadline);

  ToDo.fromJSON(Map<String, dynamic> json) {
    content = json["content"];
    deadline = json["deadline"];
  }

  Map<String, String> get json => {
    "content": content,
    "deadline": deadline
  };

  String get displayDeadline {
    if (deadline == "everyday") {
      return "毎日";
    } else if (deadline == "tomorrow") {
      return "明日まで";
    } else if (deadline == "today") {
      return "今日中";
    }
    return "";
  }
}