import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/repositories/todo_repository.dart';

class ToDoListState with ChangeNotifier {
  ToDoRepository toDoRepository;
  User? user;
  List<ToDo> todoList = [];
  String pageTitle;

  ToDoListState(
      {required this.toDoRepository,
      required this.pageTitle,
      required this.user}) {
    toDoRepository.listenTodoList(cache: false).listen((todos) {
      if (this.hasListeners) {
        this.todoList =
            todos.where((todo) => !todo.shouldDeleteAutomatically).toList();
        notifyListeners();
      }
    });
  }

  Future updateToDos() async {
    try {
      final todos = await toDoRepository.fetchToDos(cache: false);
      this.todoList = todos;
      notifyListeners();
      return Future.value(todos);
    } catch (error) {
      return Future.error(error);
    }
  }
}
