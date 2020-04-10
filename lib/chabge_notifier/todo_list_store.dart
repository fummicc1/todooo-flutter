import 'package:flutter/material.dart';
import 'package:todooo/api/firestore_client.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/models/user.dart';

class ToDoListStore with ChangeNotifier {

  FirestoreClient _firestoreClient = FirestoreClient();

  final User user;
  List<ToDo> todoList = [];
  String pageTitle;

  ToDoListStore({@required this.pageTitle, @required this.user}) {
    _startFetchingToDoList();
  }

  void _startFetchingToDoList() {
    _firestoreClient.listenToDoList(ownerUID: user.uid).listen((todos) {
      this.todoList = todos;
      notifyListeners();
    });
  }

  Future<void> deleteToDo(ToDo todo) {
    return _firestoreClient.deleteToDo(todo);
  }
}