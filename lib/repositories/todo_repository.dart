import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todooo/api/firebase/firestore.dart';
import 'package:todooo/models/user.dart';

import '../models/todo.dart';

class ToDoRepository {
  final FirestoreClient firestoreClient;

  ToDoRepository({required this.firestoreClient});

  List<ToDo> _todos = [];
  String? userID;

  Stream<List<ToDo>> listenTodoList({bool cache = true}) {
    if (cache) {
      return Stream.value(_todos);
    }
    try {
      final snapshot = firestoreClient.listenSubCollection(
        collectionName: UserCollectionName,
        documentID: userID!,
        subCollectionName: ToDo.CollectionName,
      );
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

  Future<List<ToDo>> fetchToDos({bool cache = true}) async {
    if (cache) {
      return Future.value(_todos);
    }
    try {
      final snapshot = await firestoreClient.getSubCollection(
        collectionName: UserCollectionName,
        documentID: userID!,
        subCollectionName: ToDo.CollectionName,
      );
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
    return firestoreClient.deleteDocumentOfSubCollection(
        collectionName: UserCollectionName,
        documentName: userID!,
        subCollectionName: ToDo.CollectionName,
        subCollectionDocumentName: toDo.uid!);
  }

  Future<String> createToDo(ToDo toDo) async {
    try {
      String docId = await firestoreClient.createDocumentOfSubCollection(
          collectionName: UserCollectionName,
          documentName: userID!,
          subCollectionName: ToDo.CollectionName,
          data: toDo.data);
      return Future.value(docId);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future fetchToDo({required String uid}) async {
    try {
      final response = await firestoreClient.getDocumentOfSubCollection(
          collectionName: UserCollectionName,
          documentID: userID!,
          subCollectionName: ToDo.CollectionName,
          subDocumentID: uid);
      return Future.value(
          ToDo.fromData(response.data() as Map<String, dynamic>));
    } catch (error) {
      return Future.error(error);
    }
  }

  Future updateToDo(ToDo toDo) async {
    try {
      await firestoreClient.setDocumentWithinSubCollection(
          collectionName: UserCollectionName,
          documentName: userID!,
          subCollectionName: ToDo.CollectionName,
          subCollectionDocumentName: toDo.uid!,
          data: toDo.data);
      return Future.value(null);
    } catch (error) {
      return Future.error(error);
    }
  }
}
