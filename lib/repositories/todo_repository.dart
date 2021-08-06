import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todooo/api/firebase/auth.dart';
import 'package:todooo/api/firebase/firestore.dart';
import 'package:todooo/models/user.dart';

import '../models/todo.dart';

class ToDoRepository {
  final FirestoreClient firestoreClient;
  final AuthClient authClient;

  ToDoRepository({required this.firestoreClient, required this.authClient});

  Map<String, Todo> _caches = {};

  DocumentReference generateDocumentRef(
      {required String collectionName,
      String? documentId,
      String? subCollectionName}) {
    if (documentId != null && subCollectionName != null) {
      return FirebaseFirestore.instance
          .collection(collectionName)
          .doc(documentId)
          .collection(subCollectionName)
          .doc();
    }
    return FirebaseFirestore.instance.collection(collectionName).doc();
  }

  Stream<List<Todo>> listenTodoList({bool cache = true}) {
    if (cache) {
      return Stream.value(_caches.values.toList());
    }
    final userID = authClient.getUID();
    if (userID == null) {
      return Stream.error("No Current User");
    }
    try {
      final snapshot = firestoreClient.listenSubCollection(
        collectionName: UserCollectionName,
        documentID: userID,
        subCollectionName: Todo.CollectionName,
      );
      final listStream = snapshot.map((query) {
        final list = query.docs
            .map((document) {
              final data = document.data() as Map<String, dynamic>;
              return Todo.fromData(data);
            })
            .toList()
            .cast<Todo>();
        _caches = list.asMap().map((key, value) => MapEntry(value.uid!, value));
        return list;
      });
      return listStream;
    } catch (error) {
      return Stream.error(error);
    }
  }

  Future<List<Todo>> fetchToDos({bool cache = true}) async {
    if (cache) {
      return Future.value(_caches.values.toList());
    }
    final userID = authClient.getUID();
    if (userID == null) {
      return Future.error("No Current User");
    }
    try {
      final snapshot = await firestoreClient.getSubCollection(
        collectionName: UserCollectionName,
        documentID: userID,
        subCollectionName: Todo.CollectionName,
      );
      _caches = snapshot.docs
          .map((document) =>
              Todo.fromData(document.data() as Map<String, dynamic>))
          .toList()
          .asMap()
          .map((key, value) => MapEntry(value.uid!, value));
      return Future.value(_caches.values.toList());
    } catch (error) {
      return Future.error(error);
    }
  }

  Future deleteToDo(Todo toDo) async {
    final userID = authClient.getUID();
    if (userID == null) {
      return Future.error("No Current User");
    }
    await firestoreClient.deleteDocumentOfSubCollection(
        collectionName: UserCollectionName,
        documentName: userID,
        subCollectionName: Todo.CollectionName,
        subCollectionDocumentName: toDo.uid!);
    _caches.remove(toDo.uid);
  }

  Future<String> createToDo({required Todo todo}) async {
    final userID = authClient.getUID();
    if (userID == null) {
      return Future.error("No Current User");
    }
    try {
      String docId = await firestoreClient.createDocumentOfSubCollection(
          collectionName: UserCollectionName,
          documentName: userID,
          subCollectionName: Todo.CollectionName,
          data: todo.data);
      final _todo = Todo.updateId(todo, uid: docId);
      _caches.addAll({ docId: _todo });
      return Future.value(docId);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<Todo> fetchToDo({required String uid, required bool preferCache}) async {

    if (preferCache) {
      final todo = _caches[uid];
      if (todo != null) {
        return Future.value(todo);
      }
    }
    final userID = authClient.getUID();
    if (userID == null) {
      return Future.error("No Current User");
    }

    try {
      final response = await firestoreClient.getDocumentOfSubCollection(
          collectionName: UserCollectionName,
          documentID: userID,
          subCollectionName: Todo.CollectionName,
          subDocumentID: uid);
      return Future.value(
          Todo.fromData(response.data() as Map<String, dynamic>));
    } catch (error) {
      return Future.error(error);
    }
  }

  Future updateToDo(Todo toDo) async {
    try {
      final userID = authClient.getUID();
      if (userID == null) {
        return Stream.error("No Current User");
      }
      await firestoreClient.setDocumentWithinSubCollection(
          collectionName: UserCollectionName,
          documentName: userID,
          subCollectionName: Todo.CollectionName,
          subCollectionDocumentName: toDo.uid!,
          data: toDo.data);
      return Future.value(null);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future createTodoWithId(Todo toDo) async {
    try {
      final userID = authClient.getUID();
      if (userID == null) {
        return Stream.error("No Current User");
      }
      await firestoreClient.setDocumentWithinSubCollection(
          collectionName: UserCollectionName,
          documentName: userID,
          subCollectionName: Todo.CollectionName,
          subCollectionDocumentName: toDo.uid!,
          data: toDo.data);
      return Future.value(null);
    } catch (error) {
      return Future.error(error);
    }
  }
}
