import 'package:cloud_firestore/cloud_firestore.dart';

enum Deadline { today, tomorrow }

class ToDo {
  late String uid;
  late String content;
  late String memo;
  late String deadline;
  late DateTime createDate;
  late String owner;
  late bool isDone;

  static const CollectionName = "todos";

  ToDo(
      {required this.content,
      this.memo = "",
      required this.deadline,
      required this.createDate,
      required this.isDone,
      required this.owner});

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
    final createDate = (data["create_date"] as Timestamp)?.toDate();
    if (createDate != null) {
      this.createDate = createDate;
    }
    isDone = data["is_done"];
    owner = data["owner"];
  }

  Map<String, dynamic> get data => {
        "uid": uid,
        "content": content,
        "memo": memo,
        "deadline": deadline,
        "create_date": createDate,
        "is_done": isDone,
        "owner": owner,
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
