import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todooo/api/firebase/firestore.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/models/user.dart';
import 'package:todooo/repositories/todo_repository.dart';
import 'package:todooo/repositories/user_repository.dart';
import 'package:todooo/services/local_notification_service.dart';

enum NetworkHandleState { idel, processing, success, fail }

class AppState extends ChangeNotifier {
  AppUser? user;

  late UserRepository userRepository;
  late ToDoRepository toDoRepository;
  late LocalNotificationService localNotificationService;

  AppState() {
    toDoRepository = ToDoRepository(firestoreClient: FirestoreClient());
    userRepository = UserRepository((user) {
      this.user = user;
      toDoRepository.userID = user?.uid;
      if (hasListeners) {
        notifyListeners();
      }
    });

    localNotificationService = LocalNotificationService();
  }

  Future<ToDo> fetchToDo({required id}) async {
    return await toDoRepository.fetchToDo(uid: id);
  }

  Future updateCompleteWalkThroughStatus({required bool isCompleted}) async {
    final user = this.user;
    if (user == null) {
      return Future.error("No user found");
    }
    user.isCompleteWalkThrough = isCompleted;
    return userRepository.updateUser(newUser: user);
  }
}
