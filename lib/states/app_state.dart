import 'package:flutter/material.dart';
import 'package:todooo/models/user.dart';
import 'package:todooo/repositories/todo_repository.dart';
import 'package:todooo/repositories/user_repository.dart';

enum NetworkHandleState {
  idel,
  processing,
  success,
  fail
}

class AppState extends ChangeNotifier {
  User user;

  AppState() {
    UserRepository.fetchUser(cache: false).then((user) {
      this.user = user;
      ToDoRepository.userID = user.uid;
      notifyListeners();
    });
  }
}
