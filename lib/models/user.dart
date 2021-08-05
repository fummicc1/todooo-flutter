import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

@immutable
class AppUser {
  final String uid;
  String? name;
  DateTime? signedInAt;
  final DateTime? signedUpAt;
  bool isCompleteWalkThrough;

  AppUser(
      {required this.uid,
      required this.name,
      required this.signedUpAt,
      required this.signedInAt,
      required this.isCompleteWalkThrough});

  factory AppUser.fromUser({required User user}) {
    return AppUser(
        uid: user.uid,
        name: user.displayName,
        signedUpAt: user.metadata.creationTime,
        signedInAt: user.metadata.lastSignInTime,
        isCompleteWalkThrough: false);
  }

  factory AppUser.fromMap({required Map<String, dynamic> map}) {
    final uid = map["uid"] as String;
    final name = map["name"] as String?;
    final signedUpAt = (map["signed_up_at"] as Timestamp?)?.toDate();
    final signedInAt = (map["signed_in_at"] as Timestamp?)?.toDate();
    final isCompleteWalkThrough =
        map["is_complete_walk_through"] as bool? ?? false;

    return AppUser(
        uid: uid,
        name: name,
        signedUpAt: signedUpAt,
        signedInAt: signedInAt,
        isCompleteWalkThrough: isCompleteWalkThrough);
  }
}

extension DataFromUser on AppUser {
  Map<String, dynamic> get data => {
        "uid": uid,
        "name": name,
        "signed_in_at": signedInAt,
        "signed_up_at": signedUpAt,
        "is_complete_walk_through": isCompleteWalkThrough
      };
}

const UserCollectionName = "users";
