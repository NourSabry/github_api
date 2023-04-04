// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:github_api/helpers/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

initializeNotification() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings("ic_launcher");
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'New data!',
      'cahce is refreshed!',
      tz.TZDateTime.now(tz.local).add(const Duration(hours: 1)),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'id',
          'notification',
          'this channel for refreching cashing every 1 hour',
          channelAction: refreshValues(),
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
}
