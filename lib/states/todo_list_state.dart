import 'package:flutter/material.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/models/user.dart';
import 'package:todooo/repositories/todo_repository.dart';

class ToDoListState with ChangeNotifier {

  final User user;
  List<ToDo> todoList = [];
  String pageTitle;

  ToDoListState({@required this.pageTitle, @required this.user}) {
    ToDoRepository.fetchToDos(cache: false).then((todos) {
      this.todoList = todos;
      notifyListeners();
    });
  }
}