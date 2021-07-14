import 'package:cloud_firestore/cloud_firestore.dart';

enum Deadline { today, tomorrow }

class ToDo {
  String? uid;
  late String content;
  late String memo;
  late String deadline;
  late DateTime createDate;
  late String owner;
  late bool isDone;
  late bool shouldDeleteAutomatically;
  late bool shouldNotificate;

  static const CollectionName = "todos";

  ToDo(
      {required this.content,
      this.memo = "",
      required this.deadline,
      required this.createDate,
      required this.isDone,
      required this.owner,
      required this.shouldDeleteAutomatically,
      required this.shouldNotificate});

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

  ToDo.fromData(Map<String, dynamic> data) {
    uid = data["uid"] ?? "";
    content = data["content"];
    memo = data["memo"];
    deadline = data["deadline"];
    createDate = (data["create_date"] as Timestamp).toDate();
    isDone = data["is_done"];
    owner = data["owner"];
    shouldDeleteAutomatically = data["should_delete_automatically"];
    shouldNotificate = data["should_notificate"];
  }

  Map<String, dynamic> get data => {
        "uid": uid,
        "content": content,
        "memo": memo,
        "deadline": deadline,
        "create_date": createDate,
        "is_done": isDone,
        "owner": owner,
        "should_delete_automatically": shouldDeleteAutomatically,
        "should_notificate": shouldNotificate
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
