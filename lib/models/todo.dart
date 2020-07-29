import 'package:cloud_firestore/cloud_firestore.dart';

enum Deadline {
  today,
  tomorrow
}

class ToDo {
  String uid;
  String content;
  String memo;
  String deadline;
  DateTime createDate;
  String owner;
  bool isDone;
  DocumentReference ref;

  static const CollectionName = "todos";

  ToDo({this.content, this.memo = "", this.deadline, this.createDate, this.isDone, this.owner});

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

    final ref = data["ref"];
    if (ref != null) {
      this.ref = ref;
    }
  }

  Map<String, dynamic> get data => {
    "uid": uid,
    "content": content,
    "memo": memo,
    "deadline": deadline,
    "create_date": createDate,
    "is_done": isDone,
    "owner": owner,
    "ref": ref
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