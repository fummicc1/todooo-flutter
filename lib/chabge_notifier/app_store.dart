import 'package:flutter/material.dart';
import 'package:todooo/api/auth_client.dart';
import 'package:todooo/api/firestore_client.dart';
import 'package:todooo/models/user.dart';

enum NetworkHandleState {
  idel,
  processing,
  success,
  fail
}

class AppStore extends ChangeNotifier {
  User user;
  final _authClient = AuthClient();
  final _fireStoreClient = FirestoreClient();

  AppStore() {
    _authClient.listenUser().listen((firUser) {
      if (firUser == null) {
        _authClient.signInAnonymously();
        return;
      }
      if (user == null) {
        user = User.fromFirebase(firUser);
      } else {
        user.signedUpAt = firUser.metadata.creationTime;
        user.signedInAt = firUser.metadata.lastSignInTime;
      }
      _fireStoreClient.persistUser(user);

      _fireStoreClient.listenUser(firebaseUser: firUser).listen((user) {
        this.user = user;
        notifyListeners();
      });
    });
  }
}
