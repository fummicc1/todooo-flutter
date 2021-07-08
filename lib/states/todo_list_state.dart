import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/repositories/todo_repository.dart';

class ToDoListState with ChangeNotifier {

  User? user;
  List<ToDo> todoList = [];
  String pageTitle;

  ToDoListState({required this.pageTitle, required this.user}) {
    ToDoRepository.fetchToDos(cache: false).then((todos) {
      this.todoList = todos;
      notifyListeners();
    });
  }

  Future updateToDos() async {
    try {
      final todos = await ToDoRepository.fetchToDos(cache: false);
      this.todoList = todos;
      notifyListeners();
      return Future.value(todos);
    } catch (error) {
      return Future.error(error);
    }
  }
}