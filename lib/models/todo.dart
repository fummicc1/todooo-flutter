import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

enum Deadline { today, tomorrow, deatail }

class ToDo {
  String? uid;
  String content;
  String memo;
  DateTime deadlineDate;
  final String owner;
  bool isDone;
  int? notificationDateTimeFromEpoch;
  int? notificationId;

  static const CollectionName = "todos";

  ToDo(
      {String? this.uid,
      required this.content,
      this.memo = "",
      required this.deadlineDate,
      required this.isDone,
      required this.owner,
      required this.notificationDateTimeFromEpoch,
      required this.notificationId});

  bool get isOver {
    final current = DateTime.now();
    return current.millisecondsSinceEpoch > deadlineDate.millisecondsSinceEpoch;
  }

  factory ToDo.fromData(Map<String, dynamic> data) {
    final uid = data["uid"] ?? "";
    final content = data["content"];
    final memo = data["memo"];
    final deadlineDate = (data["deadline_date"] as Timestamp).toDate();
    final isDone = data["is_done"];
    final owner = data["owner"];
    final notificationDateTimeFromEpoch =
        data["notification_date_time_from_epoch"];
    final notificationId = data["notification_id"];

    return ToDo(
        uid: uid,
        content: content,
        memo: memo,
        deadlineDate: deadlineDate,
        isDone: isDone,
        owner: owner,
        notificationDateTimeFromEpoch: notificationDateTimeFromEpoch,
        notificationId: notificationId);
  }

  Map<String, dynamic> get data => {
        "uid": uid,
        "content": content,
        "memo": memo,
        "deadline_date": deadlineDate,
        "is_done": isDone,
        "owner": owner,
        "notification_date_time_from_epoch": notificationDateTimeFromEpoch,
        "notification_id": notificationId ?? -1
      };

  String get deadlineText {
    final year = deadlineDate.year;
    final currentYear = DateTime.now().year;

    final DateFormat dateFormat;

    if (year == currentYear) {
      dateFormat = DateFormat.MMMd().add_Hm();
    } else {
      dateFormat = DateFormat.yMd().add_Hm();
    }
    return dateFormat.format(deadlineDate);
  }
}
