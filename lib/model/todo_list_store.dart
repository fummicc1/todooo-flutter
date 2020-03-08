import 'package:flutter/material.dart';
import 'package:todooo/data/todo.dart';

class ToDoListStore with ChangeNotifier {

  List<ToDo> todoList = [];

  void addToDo(ToDo value) {
    todoList.add(value);
    notifyListeners();
  }
}