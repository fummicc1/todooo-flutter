import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum Deadline { today, tomorrow }

extension DeadlineText on Deadline {
  String get displayText => this == Deadline.today ? "今日中に" : "明日までに";
}

@immutable
class Todo {
  String? uid;
  String content;
  String memo;
  String deadline;
  final DateTime createDate;
  final String owner;
  bool isDone;
  int? notificationDateTimeFromEpoch;
  int? notificationId;

  bool get isOver {
    final current = DateTime.now();
    if (deadline != "today") {
      if (current.day > createDate.day) {
        return true;
      } else {
        return false;
      }
    } else if (deadline == "tomorrow") {
      if (current.day > createDate.day + 1) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }


  static const CollectionName = "todos";

  Todo({required this.uid,
    required this.content,
    required this.memo,
    required this.deadline,
    required this.createDate,
    required this.isDone,
    required this.owner,
    required this.notificationDateTimeFromEpoch,
    required this.notificationId});

  factory Todo.fromData(Map<String, dynamic> data) {
    final uid = data["uid"] ?? "";
    final content = data["content"];
    final memo = data["memo"];
    final deadline = data["deadline"];
    final createDate = (data["create_date"] as Timestamp).toDate();
    final isDone = data["is_done"];
    final owner = data["owner"];
    final notificationDateTimeFromEpoch =
    data["notification_date_time_from_epoch"];
    final notificationId = data["notification_id"];

    return Todo(uid: uid,
        content: content,
        memo: memo,
        deadline: deadline,
        createDate: createDate,
        isDone: isDone,
        owner: owner,
        notificationDateTimeFromEpoch: notificationDateTimeFromEpoch,
        notificationId: notificationId);
  }

  factory Todo.updateId(Todo todo, {required String uid}) {
    final content = todo.content;
    final memo = todo.memo;
    final deadline = todo.deadline;
    final createDate = todo.createDate;
    final isDone = todo.isDone;
    final owner = todo.owner;
    final notificationDateTimeFromEpoch = todo.notificationDateTimeFromEpoch;
    final notificationId = todo.notificationId;

    return Todo(uid: uid,
        content: content,
        memo: memo,
        deadline: deadline,
        createDate: createDate,
        isDone: isDone,
        owner: owner,
        notificationDateTimeFromEpoch: notificationDateTimeFromEpoch,
        notificationId: notificationId);
  }

  Map<String, dynamic> get data =>
      {
        "uid": uid,
        "content": content,
        "memo": memo,
        "deadline": deadline,
        "create_date": createDate,
        "is_done": isDone,
        "owner": owner,
        "notification_date_time_from_epoch": notificationDateTimeFromEpoch,
        "notification_id": notificationId ?? -1
      };
}
