import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:todooo/api/firebase/auth.dart';
import 'package:todooo/api/firebase/firestore.dart';

import '../models/user.dart';
import '../models/user.dart';
import '../models/user.dart';
import '../models/user.dart';
import '../models/user.dart';

class UserRepository {

  static final FirestoreClient _firestoreClient = FirestoreClient();
  static final AuthClient _authClient = AuthClient();

  static User _user;

  static initialize() {
    _authClient.getUID().then((userID) {
      _firestoreClient.listenDocument(collectionName: User.CollectionName, documentName: userID).listen((snapshot) {
        _user = User.fromMap(snapshot.data);
      });
    });
  }
  
  static Future<User> fetchUser({bool cache = true}) async {
    if (cache) {
      return Future.value(_user);
    }
    try {
      String userID = await _authClient.getUID();
      if (userID == null) {
        final firebaseUser = await _authClient.signInAnonymously();
        userID = firebaseUser.uid;
      }
      final snapshot = await _firestoreClient.getDocument(collectionName: User.CollectionName, documentName: userID);
      return Future.value(User.fromMap(snapshot.data));
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future updateUser(User user) {
    return _firestoreClient.setDocument(collectionName: User.CollectionName, documentName: user.uid, data: user.data);
  }

  static Future deleteUser() {
    return _authClient.signOut();
  }
}