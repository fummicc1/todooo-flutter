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
    return uid.isNotEmpty && (content?.isNotEmpty ?? false);
  }

  bool isProcessing = false;

  // ToDo Data
  final String uid;
  String content;
  String _deadline;
  final String pageTitle;

  AddToDoState({@required this.uid, @required this.pageTitle})
      : this._deadline = "today";

  Future<bool> createToDo({DateTime createDate}) async {
    if (isProcessing) {
      return Future.error("processing");
    }
    isProcessing = true;
    final todo = ToDo(
        content: content,
        createDate: createDate,
        deadline: _deadline,
        isDone: false,
        owner: uid);
    return ToDoRepository.createToDo(todo);
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
}
