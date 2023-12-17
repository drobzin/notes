import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static Future<NotificationDetails> _notificationDetails() async =>
      NotificationDetails(
          android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        icon: '@mipmap/ic_launcher',
      ));
  static Future<void> setNotification(int id, String title, String body,
      payload, DateTime scheduledDate) async {
    var notificationRequest = await AndroidFlutterLocalNotificationsPlugin()
        .requestNotificationsPermission();
    var exactNotificationRequest =
        await AndroidFlutterLocalNotificationsPlugin()
            .requestExactAlarmsPermission();
    if (notificationRequest! && exactNotificationRequest!) {
      tz.initializeTimeZones();
      _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        await _notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}
