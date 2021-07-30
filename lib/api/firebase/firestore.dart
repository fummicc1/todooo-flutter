import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreClient {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getDocumentOfSubCollection(
      {required String collectionName,
      required String documentID,
      required String subCollectionName,
      required String subDocumentID}) {
    return _firestore
        .collection(collectionName)
        .doc(documentID)
        .collection(subCollectionName)
        .doc(subDocumentID)
        .get();
  }

  Future<DocumentSnapshot> getDocument(
      {required String collectionName, required String documentName}) {
    return _firestore.collection(collectionName).doc(documentName).get();
  }

  Future<QuerySnapshot> getCollection({required String collectionName}) {
    return _firestore.collection(collectionName).get();
  }

  Future<QuerySnapshot> getCollectionWithQuery(
      {required String collectionName,
      required String fieldName,
      required dynamic fieldValue}) {
    return _firestore
        .collection(collectionName)
        .where(fieldName, isEqualTo: fieldValue)
        .get();
  }

  Future<QuerySnapshot> getSubCollection(
      {required String collectionName,
      required String documentID,
      required String subCollectionName}) {
    return _firestore
        .collection(collectionName)
        .doc(documentID)
        .collection(subCollectionName)
        .get();
  }

  Stream<QuerySnapshot> listenCollection({required String collectionName}) {
    return _firestore.collection(collectionName).snapshots();
  }

  Stream<QuerySnapshot> listenCollectionWithQuery(
      {required String collectionName,
      required String fieldName,
      required dynamic fieldValue}) {
    return _firestore
        .collection(collectionName)
        .where(fieldName, isEqualTo: fieldValue)
        .snapshots();
  }

  Stream<QuerySnapshot> listenSubCollection(
      {required String collectionName,
      required String documentID,
      required String subCollectionName}) {
    return _firestore
        .collection(collectionName)
        .doc(documentID)
        .collection(subCollectionName)
        .snapshots();
  }

  Stream<DocumentSnapshot> listenDocument(
      {required String collectionName, required String documentName}) {
    return _firestore.collection(collectionName).doc(documentName).snapshots();
  }

  Future setDocument(
      {required String collectionName,
      required String documentName,
      required Map<String, dynamic> data,
      bool merge = true}) {
    return _firestore
        .collection(collectionName)
        .doc(documentName)
        .set(data, SetOptions(merge: true));
  }

  Future<String> createDocument(
      {required String collectionName,
      required Map<String, dynamic> data, String? uid}) async {
    final document;
    if (uid != null) {
      document = _firestore.collection(collectionName).doc(uid);;
    } else {
      document = _firestore.collection(collectionName).doc();
    }
    data["uid"] = document.id;
    try {
      await document.set(data);
      return Future.value(document.id);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future setDocumentWithinSubCollection(
      {required String collectionName,
      required String documentName,
      required String subCollectionName,
      required String subCollectionDocumentName,
      required Map<String, dynamic> data,
      bool merge = true}) {
    return _firestore
        .collection(collectionName)
        .doc(documentName)
        .collection(subCollectionName)
        .doc(subCollectionDocumentName)
        .set(data, SetOptions(merge: true));
  }

  Future deleteDocument(
      {required String collectionName, required String documentName}) {
    return _firestore.collection(collectionName).doc(documentName).delete();
  }
}
