import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthClient {
  Stream<FirebaseUser> listenUser() => FirebaseAuth.instance.onAuthStateChanged;
  Future<void> signOut() => FirebaseAuth.instance.signOut();
  Future<AuthResult> signUp(
          {@required String email, @required String password}) =>
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
  Future<AuthResult> signIn(
          {@required String email, @required String password}) =>
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
  Future<AuthResult> signInAnonymously() =>
      FirebaseAuth.instance.signInAnonymously();
}
