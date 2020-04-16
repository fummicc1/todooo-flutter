import 'package:cloud_firestore/cloud_firestore.dart';

enum Deadline {
  today,
  tomorrow
}

class ToDo {
  String content;
  String memo;
  String deadline;
  DateTime createDate;
  String owner;
  bool isDone;
  DocumentReference ref;

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

  ToDo.fromJSON(Map<String, dynamic> json) {
    content = json["content"];
    memo = json["memo"];
    deadline = json["deadline"];
    createDate = DateTime.fromMillisecondsSinceEpoch(json["create_date"]);
    isDone = json["is_done"];
    owner = json["owner"];
    ref = json["ref"];
  }

  Map<String, dynamic> get json => {
    "content": content,
    "memo": memo,
    "deadline": deadline,
    "create_date": createDate.millisecondsSinceEpoch,
    "is_done": isDone,
    "owner": owner,
    "ref": ref,
  };

  String get displayDeadline {
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