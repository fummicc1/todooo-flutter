import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/models/user.dart';
import 'package:todooo/repositories/todo_repository.dart';

class ToDoListState with ChangeNotifier {
  ToDoRepository toDoRepository;
  List<ToDo> todoList = [];
  String pageTitle;

  ToDoListState(
      {required this.toDoRepository,
      required this.pageTitle}) {
    toDoRepository.listenTodoList(cache: false).listen((todos) {
      this.todoList = todos;
      notifyListeners();
    });
  }

  Future updateToDos() async {
    try {
      final todos = await toDoRepository.fetchToDos(cache: false);
      this.todoList = todos;

      if (hasListeners) {
        notifyListeners();
      }
      return Future.value(todos);
    } catch (error) {
      return Future.error(error);
    }
  }
}
