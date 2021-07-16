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
      required NotificationDetails details}) async {
    final pendingNotifications =
        await _flutterLocalNotificationPlugin.pendingNotificationRequests();
    final lastId = pendingNotifications.last.id ?? 0;
    return _flutterLocalNotificationPlugin.zonedSchedule(
        lastId + 1, title, body, scheduledDate, details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}
