import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import "package:timezone/timezone.dart" as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future initializeSetting(
      Future Function(String?) onSelectNotification) async {
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    final IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true);
    final InitializationSettings initializationSettings =
        InitializationSettings(
            iOS: iosInitializationSettings,
            android: androidInitializationSettings);
    return _flutterLocalNotificationPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future sendNotification(
      {required String title,
      required String body,
      required tz.TZDateTime scheduledDate,
      required NotificationDetails details,
      required String payload}) async {
    final pendingNotifications =
        await _flutterLocalNotificationPlugin.pendingNotificationRequests();
    int newId = 0;
    if (pendingNotifications.isNotEmpty) {
      newId = 1 + pendingNotifications.last.id;
    }
    return _flutterLocalNotificationPlugin.zonedSchedule(
        newId, title, body, scheduledDate, details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: payload);
  }
}
