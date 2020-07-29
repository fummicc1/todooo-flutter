import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  String uid;
  String name;
  DateTime signedInAt;
  DateTime signedUpAt;

  static const CollectionName = "users";

  @override
  Map<String, dynamic> get data => {
        "uid": uid,
        "name": name,
        "signed_in_at": signedInAt,
        "signed_up_at": signedUpAt,
      };

  User.fromFirebase(FirebaseUser firebaseUser) {
    uid = firebaseUser.uid;
    signedUpAt = firebaseUser.metadata.creationTime;
    signedInAt = firebaseUser.metadata.lastSignInTime;
  }

  User.fromMap(Map<String, dynamic> data) {
    uid = data["uid"];
    name = data["name"] ?? "";
    signedUpAt = (data["signed_up_at"] as Timestamp).toDate();
    signedInAt = (data["signed_in_at"] as Timestamp).toDate();
  }

  updateSignedInAt(DateTime dateTime) {
    signedInAt = dateTime;
  }
}