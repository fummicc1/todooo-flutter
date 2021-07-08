import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension DataFromUser on User {
  Map<String, dynamic> get data => {
    "uid": uid,
    "name": displayName,
    "signed_in_at": metadata.lastSignInTime,
    "signed_up_at": metadata.creationTime
  };
}

const UserCollectionName = "users";