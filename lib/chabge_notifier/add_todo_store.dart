import 'package:flutter/material.dart';
import 'package:todooo/api/firestore_client.dart';
import 'package:todooo/chabge_notifier/app_store.dart';
import 'package:todooo/models/todo.dart';

class AddToDoStore extends ChangeNotifier {

  FirestoreClient _firestoreClient = FirestoreClient();

  final deadlineList = Deadline.values.map((value) =>
  value.toString().split('.')[1]).toList();
  NetworkHandleState networkHandleState = NetworkHandleState.idel;

  // ToDo Data
  final String uid;
  String content;
  DateTime createDate;
  String deadline;
  String pageTitle;

  AddToDoStore({@required this.uid, @required this.pageTitle});

  createToDo({String content, DateTime createDate, String deadline}) {
    networkHandleState = NetworkHandleState.processing;
    notifyListeners();
    final todo = ToDo(content: content,
        createDate: createDate,
        deadline: deadline,
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
}