import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class NotificationsHelper {

  static void scheduleNotification({String title, String message, 
    Time time}) async {

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'app_icon',
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        title,
        message,
        time,
        platformChannelSpecifics);
  }

  static void cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}