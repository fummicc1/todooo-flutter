import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todooo/api/firebase/firestore.dart';
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
  User? user;

  late UserRepository userRepository;
  late ToDoRepository toDoRepository;

  AppState() {
    toDoRepository = ToDoRepository(firestoreClient: FirestoreClient());
    userRepository = UserRepository((user) {
      this.user = user;
      toDoRepository.userID = user?.uid;
      notifyListeners();
    });
  }
}
