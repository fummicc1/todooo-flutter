import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todooo/api/firebase/auth.dart';
import 'package:todooo/api/firebase/firestore.dart';

import '../models/user.dart';

class UserRepository {
  final AuthClient _authClient = AuthClient();
  final FirestoreClient _firestoreClient = FirestoreClient();

  AppUser? _user;

  bool _hasUserListener = false;

  UserRepository(Function(AppUser?) onUpdateUser) {
    _authClient.onAuthStateChanged().listen((user) async {
      if (user == null) {
        _user = null;
        onUpdateUser(null);
      } else if (!_hasUserListener) {
        _hasUserListener = true;
        _firestoreClient
            .listenDocument(
                collectionName: UserCollectionName, documentName: user.uid)
            .listen((snapshot) {
          final data = snapshot.data() as Map<String, dynamic>?;
          if (data == null) return;
          data["uid"] = user.uid;
          final appUser = AppUser.fromMap(map: data);
          _user = appUser;
          onUpdateUser(_user);
        });
      }
    });
  }

  Future createUser({required User user}) async {
    final AppUser appUser = AppUser.fromUser(user: user);
    return _firestoreClient.createDocument(
        collectionName: UserCollectionName,
        data: appUser.data,
        uid: appUser.uid);
  }

  Future<AppUser?> fetchUser({bool cache = true}) async {
    if (cache) {
      return Future.value(_user);
    }
    try {
      final user = await _authClient.getCurrentUser();
      final uid = user?.uid;
      if (uid != null) {
        final snapshot = await _firestoreClient.getDocument(
            collectionName: UserCollectionName, documentName: uid);
        final response =
            snapshot.data() as Map<String, dynamic>? ?? {"uid": uid};
        final appUser = AppUser.fromMap(map: response);

        this._user = appUser;

        return appUser;
      } else {
        return null;
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  Future updateUser({required AppUser newUser}) async {
    return _firestoreClient.setDocument(
        collectionName: UserCollectionName,
        documentName: newUser.uid,
        data: newUser.data);
  }

  Future deleteUser() {
    return _authClient.signOut();
  }

  Future<User> signInAnonymously() => _authClient.signInAnonymously();

  Future<User> signInWithEmail(
      {required String email, required String password}) async {
    return _authClient.signIn(email: email, password: password);
  }

  Future<User> signUpWithEmail(
      {required String email, required String password}) async {
    final user = await _authClient.signUp(email: email, password: password);
    return user;
  }
}
