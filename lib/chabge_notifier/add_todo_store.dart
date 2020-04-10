import 'package:flutter/material.dart';
import 'package:todooo/api/firestore_client.dart';
import 'package:todooo/chabge_notifier/app_store.dart';
import 'package:todooo/models/todo.dart';

class AddToDoStore extends ChangeNotifier {
  FirestoreClient _firestoreClient = FirestoreClient();

  final deadlineList =
      Deadline.values.map((value) => value.toString().split('.')[1]).toList();
  NetworkHandleState networkHandleState = NetworkHandleState.idel;
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

  // ToDo Data
  final String uid;
  String _content;
  String _deadline;
  final String pageTitle;

  AddToDoStore({@required this.uid, @required this.pageTitle})
      : this._deadline = "today";

  createToDo({DateTime createDate}) {
    networkHandleState = NetworkHandleState.processing;
    notifyListeners();
    final todo = ToDo(
        content: _content,
        createDate: createDate,
        deadline: _deadline,
        isDone: false,
        owner: uid);
    _firestoreClient.persistToDo(todo).catchError((error) {
      networkHandleState = NetworkHandleState.fail;
      notifyListeners();
    }).then((v) {
      networkHandleState = NetworkHandleState.success;
      notifyListeners();
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
