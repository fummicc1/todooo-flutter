import 'package:flutter/material.dart';
import 'package:todooo/api/firestore_client.dart';
import 'package:todooo/chabge_notifier/app_store.dart';
import 'package:todooo/models/todo.dart';

class AddToDoStore extends ChangeNotifier {
  FirestoreClient _firestoreClient = FirestoreClient();

  final deadlineList =
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
    return uid.isNotEmpty && (_content?.isNotEmpty ?? false);
  }

  bool isProcessing = false;

  // ToDo Data
  final String uid;
  String _content;
  String _deadline;
  final String pageTitle;

  AddToDoStore({@required this.uid, @required this.pageTitle})
      : this._deadline = "today";

  Future<bool> createToDo({DateTime createDate}) {
    if (isProcessing) {
      return null;
    }
    isProcessing = true;
    final todo = ToDo(
        content: _content,
        createDate: createDate,
        deadline: _deadline,
        isDone: false,
        owner: uid);
    return _firestoreClient.persistToDo(todo).catchError((error) {
      isProcessing = false;
      return false;
    }).then((v) {
      isProcessing = false;
      return true;
    });
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
    this._content = content;
    notifyListeners();
  }
}
