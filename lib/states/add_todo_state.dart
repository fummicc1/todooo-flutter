import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/repositories/todo_repository.dart';

class AddToDoState extends ChangeNotifier {
  final List<String> deadlineList =
      Deadline.values.map((value) => value.toString().split('.')[1]).toList();

  Deadline get deadline {
    for (int i = 0; i < deadlineList.length; i++) {
      if (deadlineList[i] == _deadline) {
        return Deadline.values[i];
      }
    }
    return Deadline.today;
  }

  bool get isDataInputted {
    return userID.isNotEmpty && (content.isNotEmpty);
  }

  bool isProcessing = false;

  final ToDoRepository toDoRepository;

  // ToDo Data
  final String userID;
  String content;
  String _deadline;
  bool shouldDeleteAutomatically;
  bool shouldNotificate;
  final String pageTitle;

  AddToDoState(
      {required this.userID,
      this.content = "",
      this.shouldDeleteAutomatically = false,
      this.shouldNotificate = true,
      required this.pageTitle,
      required this.toDoRepository})
      : this._deadline = "today";

  Future<bool> createToDo({required DateTime createDate}) async {
    if (isProcessing) {
      return Future.error("processing");
    }
    isProcessing = true;
    final todo = ToDo(
        content: content,
        createDate: createDate,
        deadline: _deadline,
        isDone: false,
        owner: userID,
        shouldDeleteAutomatically: shouldDeleteAutomatically,
        shouldNotificate: shouldNotificate);
    try {
      await toDoRepository.createToDo(todo);
      return Future.value(true);
    } catch (error) {
      return Future.error(error);
    }
  }

  updateSelectingDeadline(Deadline deadline) {
    for (int i = 0; i < Deadline.values.length; i++) {
      if (deadline == Deadline.values[i]) {
        this._deadline = deadlineList[i];
        notifyListeners();
      }
    }
  }

  updateContent(String content) {
    this.content = content;
    notifyListeners();
  }

  updateShouldDeleteAutomatically(bool automatically) {
    this.shouldDeleteAutomatically = automatically;
    notifyListeners();
  }

  updateShouldNotificate(bool should) {
    this.shouldNotificate = should;
    notifyListeners();
  }
}
