import 'package:flutter/material.dart';
import 'package:todooo/models/todo.dart';

class ToDoListStore with ChangeNotifier {

  List<ToDo> todoList = [];

  void addToDo(ToDo value) {
    todoList.add(value);
    notifyListeners();
  }
}