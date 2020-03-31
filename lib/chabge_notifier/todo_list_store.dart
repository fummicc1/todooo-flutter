import 'package:flutter/material.dart';
import 'package:todooo/api/firestore_client.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/models/user.dart';

class ToDoListStore with ChangeNotifier {

  FirestoreClient _firestoreClient = FirestoreClient();

  final User user;
  List<ToDo> todoList = [];
  String pageTitle;

  ToDoListStore({this.pageTitle, this.user}) {
  }

  void addToDo(ToDo value) {
    todoList.add(value);
    notifyListeners();
  }
}