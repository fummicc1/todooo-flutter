import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  String uid;
  String name;
  DateTime signedInAt;
  DateTime signedUpAt;
  DocumentReference ref;

  static const CollectionName = "users";

  @override
  Map<String, dynamic> get data => {
        "uid": uid,
        "name": name,
        "signedInAt": signedInAt,
        "signedUpAt": signedUpAt,
        "ref": ref
      };

  User.fromFirebase(FirebaseUser firebaseUser) {
    uid = firebaseUser.uid;
    signedUpAt = firebaseUser.metadata.creationTime;
    signedInAt = firebaseUser.metadata.lastSignInTime;
  }

  User.fromMap(Map<String, dynamic> data) {
    uid = data["uid"];
    name = data["name"] ?? "";
    signedUpAt = (data["signedUpAt"] as Timestamp).toDate();
    signedInAt = (data["signedInAt"] as Timestamp).toDate();
    ref = data["ref"];
  }

  updateSignedInAt(DateTime dateTime) {
    signedInAt = dateTime;
  }
}