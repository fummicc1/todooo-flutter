import 'package:flutter/material.dart';
import 'package:todooo/api/firestore_client.dart';
import 'package:todooo/models/todo.dart';

enum sessionStateInAddToDoPage {
  idel,
  processing,
  success,
  fail
}

class AddToDoStore extends ChangeNotifier {

  FirestoreClient _firestoreClient = FirestoreClient();

  final String uid;
  String content;
  DateTime createDate;
  String deadline;


  AddToDoStore({this.uid})

  void createToDo({String content, DateTime createDate, String deadline}) {
    final todo = ToDo(content: content, createDate: createDate, deadline: deadline, isDone: false, owner: uid);
    _firestoreClient.persistToDo(todo).then((v) {

    });
  }
}