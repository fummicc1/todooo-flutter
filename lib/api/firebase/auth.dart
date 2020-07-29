import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class AuthClient {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> signInAnonymously() async {
    try {
      final result = await _firebaseAuth.signInAnonymously();
      return Future.value(result.user);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<FirebaseUser> signUp({String email, String password}) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      final firebaseUser = response.user;
      return Future.value(firebaseUser);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<FirebaseUser> signIn({String email, String password}) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return Future.value(response.user);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future signOut() {
    return _firebaseAuth.signOut();
  }

  Future<FirebaseUser> getCurrentUser() async {
    return _firebaseAuth.currentUser();
  }

  Future<String> getUID() async {
    try {
      final currentUser = await _firebaseAuth.currentUser();
      return Future.value(currentUser?.uid);
    } catch (error) {
      return Future.error(error);
    }
  }
}