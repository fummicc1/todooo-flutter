import 'package:cloud_firestore/cloud_firestore.dart';

enum Deadline { today, tomorrow }

class ToDo {
  String? uid;
  String content;
  String memo;
  String deadline;
  final DateTime createDate;
  final String owner;
  bool isDone;
  int? notificationDateTimeFromEpoch;
  int? notificationId;

  static const CollectionName = "todos";

  ToDo(
      {String? this.uid,
      required this.content,
      this.memo = "",
      required this.deadline,
      required this.createDate,
      required this.isDone,
      required this.owner,
      required this.notificationDateTimeFromEpoch,
      required this.notificationId});

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

  factory ToDo.fromData(Map<String, dynamic> data) {
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

    return ToDo(
        uid: uid,
        content: content,
        memo: memo,
        deadline: deadline,
        createDate: createDate,
        isDone: isDone,
        owner: owner,
        notificationDateTimeFromEpoch: notificationDateTimeFromEpoch,
        notificationId: notificationId);
  }

  Map<String, dynamic> get data => {
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

  String get deadlineText {
    if (deadline == "everyday") {
      return "毎日続けて";
    } else if (deadline == "tomorrow") {
      return "明日までに";
    } else if (deadline == "today") {
      return "今日までに";
    }
    return "";
  }
}
