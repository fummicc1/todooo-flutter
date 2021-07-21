import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todooo/costants.dart';
import 'package:todooo/models/todo.dart';
import 'package:todooo/repositories/todo_repository.dart';
import 'package:todooo/services/local_notification_service.dart';
import "package:timezone/timezone.dart" as tz;

class AddToDoState extends ChangeNotifier {
  final List<String> deadlineList =
      Deadline.values.map((value) => value.toString().split('.')[1]).toList();

  Deadline get deadline {
    for (int i = 0; i < deadlineList.length; i++) {
      if (deadlineList[i] == _deadline) {
        return Deadline.values[i];
      }
    }
    return Deadline.today;
  }

  bool get isDataInputted {
    return userID.isNotEmpty && (content.isNotEmpty);
  }

  bool isProcessing = false;

  final ToDoRepository toDoRepository;
  final LocalNotificationService localNotificationService;

  // ToDo Data
  final String userID;
  String content;
  String _deadline;
  tz.TZDateTime? notificateDate;
  final String pageTitle;

  AddToDoState(
      {required this.userID,
      this.content = "",
      this.notificateDate,
      required this.pageTitle,
      required this.toDoRepository,
      required this.localNotificationService})
      : this._deadline = "today";

  Future<bool> createToDo({required DateTime createDate}) async {
    if (isProcessing) {
      isProcessing = false;
      return Future.error("processing");
    }
    isProcessing = true;
    final todo = ToDo(
        uid: null,
        content: content,
        createDate: createDate,
        deadline: _deadline,
        isDone: false,
        owner: userID,
        notificationDateTimeFromEpoch: notificateDate?.millisecondsSinceEpoch, notificationId: null
    );
    try {
      final String todoId = await toDoRepository.createToDo(todo);
      todo.uid = todoId;
      if (notificateDate != null) {
       final notificationId = await localNotificationService.sendNotification(
            title: "「${content}」を完了しましょう！",
            body: "",
            scheduledDate: notificateDate!,
            payload: "{ \"todo_id\": \"$todoId\" }",
            details: NotificationDetails(
                android: AndroidNotificationDetails("0", "TOD_NOTIFICATION", "",
                    importance: Importance.high)));
        todo.notificationId = notificationId;
        await toDoRepository.updateToDo(todo);
      }
      return Future.value(true);
    } catch (error) {
      return Future.error(error);
    }
  }

  updateSelectingDeadline(Deadline deadline) {
    for (int i = 0; i < Deadline.values.length; i++) {
      if (deadline == Deadline.values[i]) {
        this._deadline = deadlineList[i];
        notifyListeners();
      }
    }
  }

  updateContent(String content) {
    this.content = content;
    notifyListeners();
  }

  updateNotificationDate(DateTime? dateTime) async {
    if (dateTime == null) {
      this.notificateDate = null;
    } else {
      this.notificateDate =
          tz.TZDateTime.from(dateTime, tz.getLocation(TokyoLocation));
    }
    notifyListeners();
  }
}
