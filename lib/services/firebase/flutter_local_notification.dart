import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static void initilize(BuildContext context) {
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/launcher_icon"),
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification:(String route)async{
      if (route != null){
        Navigator.of(context).pushNamed(route);
      }
    });

  }
  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch  ~/ 1000;
      final NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            "libmotapp", "libmotappchannel", "this is our channel",
            importance: Importance.max, priority: Priority.high),
      );
      await flutterLocalNotificationsPlugin.show(
        id.toInt(),
        message.notification.title,
        message.notification.body,
        notificationDetails,
        payload: message.data["initial"],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
