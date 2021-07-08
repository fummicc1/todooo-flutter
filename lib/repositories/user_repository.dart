import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todooo/api/firebase/auth.dart';
import 'package:todooo/api/firebase/firestore.dart';

import '../models/user.dart';

class UserRepository {

  static final FirestoreClient _firestoreClient = FirestoreClient();
  static final AuthClient _authClient = AuthClient();

  static User? _user;

  static initialize() {
    _authClient.getCurrentUser().then((response) {
      _user = response;
    });
  }
  
  static Future<User?> fetchUser({bool cache = true}) async {
    if (cache) {
      return Future.value(_user);
    }
    try {
      return _authClient.getCurrentUser();
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future updateDisplayName(User user) {
    return _authClient.updateUser(displayName: user.displayName);
  }

  static Future deleteUser() {
    return _authClient.signOut();
  }
}