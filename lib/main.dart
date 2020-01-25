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
        backgroundColor: Color(0xFF55b9f3),
        appBarTheme: AppBarTheme(
          color: Color(0xFF55b9f3),
        ),
        primarySwatch: Colors.blue,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF55b9f3)
        )
      ),
      home: ToDoListPage(),
    );
  }
}

class ToDo {
  String content;
  String deadline;
  bool isDone;
  ToDo(this.content, this.deadline, this.isDone);
  ToDo.fromJSON(Map<String, dynamic> json) {
    content = json["content"];
    deadline = json["deadline"];
    isDone = json["is_done"];
  }

  Map<String, dynamic> get json => {
    "content": content,
    "deadline": deadline,
    "is_done": isDone
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