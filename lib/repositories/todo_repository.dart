import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todooo/api/firebase/firestore.dart';

import '../models/todo.dart';

class ToDoRepository {
  static final FirestoreClient _firestoreClient = FirestoreClient();

  static List<ToDo> _todos = [];
  static String userID;

  static Future<List<ToDo>> fetchToDos({@required bool cache = true}) async {
    if (cache) {
      return Future.value(_todos);
    }
    try {
      final snapshot = await _firestoreClient.getCollectionWithQuery(collectionName: ToDo.CollectionName, fieldName: "owner", fieldValue: userID);
      _todos = snapshot.documents.map((document) => ToDo.fromData(document.data)).toList();
      return Future.value(_todos);
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future deleteToDo(ToDo toDo) {
    return _firestoreClient.deleteDocument(collectionName: ToDo.CollectionName, documentName: toDo.uid);
  }

  static Future createToDo(ToDo toDo) async {
    try {
      await _firestoreClient.createDocument(collectionName: ToDo.CollectionName, data: toDo.data);
      return Future.value(null);
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future fetchToDo({@required String uid}) async {
    try {
      final response = await _firestoreClient.getDocument(collectionName: ToDo.CollectionName, documentName: uid);
      return Future.value(ToDo.fromData(response.data));
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future updateToDo(ToDo toDo) async {
    try {
      await _firestoreClient.setDocument(collectionName: ToDo.CollectionName, documentName: toDo.uid, data: toDo.data);
      return Future.value(null);
    } catch (error) {
      return Future.error(error);
    }
  }
}