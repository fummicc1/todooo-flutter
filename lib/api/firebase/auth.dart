import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthClient {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> onAuthStateChanged() => _firebaseAuth.authStateChanges();

  Future<User> signInAnonymously() async {
    try {
      final result = await _firebaseAuth.signInAnonymously();
      return Future.value(result.user);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<User> signUp({required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final firebaseUser = response.user;
      return Future.value(firebaseUser);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<User> signIn({required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return Future.value(response.user);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }

  Future delete() {
    return _firebaseAuth.currentUser!.delete();
  }

  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  String? getUID() {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser?.uid;
  }

  Future updateUser({String? displayName}) async {
    if (displayName != null) {
      return _firebaseAuth.currentUser?.updateDisplayName(displayName);
    }
    return null;
  }
}
