import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todooo/api/firebase/firestore.dart';

import '../models/todo.dart';

class ToDoRepository {
  final FirestoreClient firestoreClient;

  ToDoRepository({required this.firestoreClient});

  List<ToDo> _todos = [];
  String? userID;

  Stream<List<ToDo>> listenTodoList({@required bool cache = true}) {
    if (cache) {
      return Stream.value(_todos);
    }
    try {
      final snapshot = firestoreClient.listenCollectionWithQuery(
          collectionName: ToDo.CollectionName,
          fieldName: "owner",
          fieldValue: userID);
      return snapshot.map((query) {
        return query.docs
            .map((document) {
              final data = document.data() as Map<String, dynamic>;
              return ToDo.fromData(data);
            })
            .toList()
            .cast<ToDo>();
      });
    } catch (error) {
      return Stream.error(error);
    }
  }

  Future<List<ToDo>> fetchToDos({@required bool cache = true}) async {
    if (cache) {
      return Future.value(_todos);
    }
    try {
      final snapshot = await firestoreClient.getCollectionWithQuery(
          collectionName: ToDo.CollectionName,
          fieldName: "owner",
          fieldValue: userID);
      _todos = snapshot.docs
          .map((document) =>
              ToDo.fromData(document.data() as Map<String, dynamic>))
          .toList();
      return Future.value(_todos);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future deleteToDo(ToDo toDo) {
    return firestoreClient.deleteDocument(
        collectionName: ToDo.CollectionName, documentName: toDo.uid!);
  }

  Future createToDo(ToDo toDo) async {
    try {
      await firestoreClient.createDocument(
          collectionName: ToDo.CollectionName, data: toDo.data);
      return Future.value(null);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future fetchToDo({required String uid}) async {
    try {
      final response = await firestoreClient.getDocument(
          collectionName: ToDo.CollectionName, documentName: uid);
      return Future.value(
          ToDo.fromData(response.data() as Map<String, dynamic>));
    } catch (error) {
      return Future.error(error);
    }
  }

  Future updateToDo(ToDo toDo) async {
    try {
      await firestoreClient.setDocument(
          collectionName: ToDo.CollectionName,
          documentName: toDo.uid!,
          data: toDo.data);
      return Future.value(null);
    } catch (error) {
      return Future.error(error);
    }
  }
}
