import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todooo/api/firebase/auth.dart';
import 'package:todooo/api/firebase/firestore.dart';

import '../models/user.dart';

class UserRepository {
  late AuthClient _authClient = AuthClient();

  User? _user;

  UserRepository(Function(User?) onUpdateUser) {
    _authClient.signInAnonymously();
    _authClient.onAuthStateChanged().listen((user) {
      _user = user;
      onUpdateUser(user);
    });
  }

  Future<User?> fetchUser({bool cache = true}) async {
    if (cache) {
      return Future.value(_user);
    }
    try {
      return _authClient.getCurrentUser();
    } catch (error) {
      return Future.error(error);
    }
  }

  Future updateDisplayName(User user) {
    return _authClient.updateUser(displayName: user.displayName);
  }

  Future deleteUser() {
    return _authClient.signOut();
  }
}
