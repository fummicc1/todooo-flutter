import 'package:flutter/material.dart';
import 'package:todooo/api/auth_client.dart';
import 'package:todooo/api/firestore_client.dart';
import 'package:todooo/models/user.dart';

class AppStore extends ChangeNotifier {
  User user;
  bool _isRegistered = false;
  final _authClient = AuthClient();
  final _fireStoreClient = FirestoreClient();

  AppStore() {
    _authClient.listenUser().listen((firUser) {
      if (!_isRegistered) {
        _isRegistered = true;
        return;
      }
      if (firUser == null) {
        _authClient.signInAnonymously();
        return;
      }
      _fireStoreClient.getUser(uid: firUser.uid).listen((user) {

      });
      _fireStoreClient.listenUser(firebaseUser: firUser).listen((user) {
        this.user = user;
        notifyListeners();
      });
    });
  }
}
