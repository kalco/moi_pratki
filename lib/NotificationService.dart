// ignore_for_file: file_names

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('img');
  final IOSInitializationSettings initializationSettingsIOS = const IOSInitializationSettings();

   void initializeNotificatio() async
   {
     final InitializationSettings initializationSettings = InitializationSettings(
         android: initializationSettingsAndroid,
         iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
   }

  void showNotification(String title,String body) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        '1', 'channel name',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics,iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }
}