import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/services/local_notification_service.dart';

final localNotificationServiceProvider = Provider<LocalNotificationService>((ref) => LocalNotificationService());
