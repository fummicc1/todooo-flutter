import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/models/user.dart';

mixin FirestoreEntity {
  Map<String, dynamic> get mapData;
  DocumentReference ref;
}

class FirestoreClient {
  Future<void> _persist(Map<String, dynamic> data, DocumentReference ref) {
    if (data["createdAt"] == null) {
      data["createdAt"] = FieldValue.serverTimestamp();
    }
    data["updatedAt"] = FieldValue.serverTimestamp();
    return ref.setData(data, merge: true).catchError((error) {
      debugPrint(error);
    });
  }

  Future<void> persistUser(User user) {
    DocumentReference ref =
        Firestore.instance.collection("users").document(user.uid);
    user.ref = ref;
    return _persist(user.mapData, ref);
  }

  Stream<DocumentSnapshot> _listenDocument(
          DocumentReference documentReference) =>
      documentReference.snapshots();

  Stream<QuerySnapshot> _searchEqualTo(
          {CollectionReference collectionReference,
          String field,
          String value}) =>
      collectionReference.where(field, isEqualTo: value).snapshots();

  Future<DocumentSnapshot> _getDocument(
          {DocumentReference documentReference}) =>
      documentReference.get();

  Stream<User> listenUser({@required FirebaseUser firebaseUser}) =>
      _listenDocument(
              Firestore.instance.collection("users").document(firebaseUser.uid))
          .map((snapshot) {
        var data = snapshot.data;
        data["signedInAt"] =
            Timestamp.fromDate(firebaseUser.metadata.lastSignInTime);
        return User.fromMap(data);
      });

  Stream<User> getUser({@required String uid}) => _getDocument(
          documentReference:
              Firestore.instance.collection("users").document(uid))
      .asStream()
      .map((snapshot) => User.fromMap(snapshot.data));

  Stream<User> searchUserWithUID({@required String uid}) => _searchEqualTo(
              collectionReference: Firestore.instance.collection("users"),
              field: "uid",
              value: uid)
          .map((snapshot) {
        return User.fromMap(snapshot.documents.first.data);
      });

  Stream<List<ToDo>> listenToDoList({String ownerUID}) {
    return Firestore.instance
        .collection("users")
        .document(ownerUID)
        .collection("todos")
        .snapshots()
        .map((snapshot) =>
            snapshot.documents.map((document) => ToDo.fromJSON(document.data)));
  }

  Future<void> persistToDo(ToDo todo) {
    final ref = Firestore.instance.collection("users").document(todo.owner).collection("todos").document();
    return _persist(todo.json, ref);
  }
}
