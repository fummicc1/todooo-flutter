import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreClient {
  final Firestore _firestore = Firestore.instance;

  Future<DocumentSnapshot> getDocumentOfSubCollection(
  {@required String collectionName, @required String documentID, @required String subCollectionName, @required String subDocumentID}) {
    return _firestore.collection(collectionName).document(documentID).collection(subCollectionName).document(subDocumentID).get();
  }

  Future<DocumentSnapshot> getDocument(
      {@required String collectionName, @required String documentName}) {
    return _firestore.collection(collectionName).document(documentName).get();
  }

  Future<QuerySnapshot> getCollection({@required String collectionName}) {
    return _firestore.collection(collectionName).getDocuments();
  }

  Future<QuerySnapshot> getCollectionWithQuery({@required String collectionName, @required String fieldName, @required dynamic fieldValue}) {
    return _firestore.collection(collectionName).where(fieldName, isEqualTo: fieldValue).getDocuments();
  }

  Future<QuerySnapshot> getSubCollection({@required String collectionName, @required String documentID, @required String subCollectionName}) {
    return _firestore.collection(collectionName).document(documentID).collection(subCollectionName).getDocuments();
  }

  Stream<QuerySnapshot> listenCollection({@required String collectionName}) {
    return _firestore.collection(collectionName).snapshots();
  }

  Stream<QuerySnapshot> listenCollectionWithQuery({@required String collectionName, @required String fieldName, @required dynamic fieldValue}) {
    return _firestore.collection(collectionName).where(fieldName, isEqualTo: fieldValue).snapshots();
  }

  Stream<QuerySnapshot> listenSubCollection({@required String collectionName, @required String documentID, @required String subCollectionName}) {
    return _firestore.collection(collectionName).document(documentID).collection(subCollectionName).snapshots();
  }

  Stream<DocumentSnapshot> listenDocument({ @required String collectionName, @required String documentName}) {
    return _firestore.collection(collectionName).document(documentName).snapshots();
  }

  Future setDocument({@required String collectionName, @required String documentName, @required Map<String, dynamic> data, bool merge = true}) {
    return _firestore.collection(collectionName).document(documentName).setData(data, merge: merge);
  }

  Future<String> createDocument({@required String collectionName, @required Map<String, dynamic> data}) async {
    final document = _firestore.collection(collectionName).document();
    data["uid"] = document.documentID;
    try {
      await document.setData(data);
      return Future.value(document.documentID);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future setDocumentWithinSubCollection({@required String collectionName, @required String documentName, @required String subCollectionName, @required String subCollectionDocumentName, Map<String, dynamic> data, bool merge = true}) {
    return _firestore.collection(collectionName).document(documentName).collection(subCollectionName).document(subCollectionDocumentName).setData(data, merge: true);
  }

  Future deleteDocument({@required String collectionName, @required String documentName}) {
    return _firestore.collection(collectionName).document(documentName).delete();
  }
}
