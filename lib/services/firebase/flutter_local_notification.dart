import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class LocalNotification {
  // final BehaviorSubject<ReceivedNotification>
  //     didReceiveLocalNotificationSubject =
  //     BehaviorSubject<ReceivedNotification>();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

   static initilize(BuildContext context) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/launcher_icon"),
      iOS: IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        // onDidReceiveLocalNotification:
        //     (int id, String title, String body, String payload) async {
        //   didReceiveLocalNotificationSubject.add(ReceivedNotification(
        //       id: id, title: title, body: body, payload: payload
            //),
        //);
       // },
      ),
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String route) async {
      if (route != null) {
        Navigator.of(context).pushNamed(route);
      }
    });
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            "libmotapp", "libmotappchannel", "this is our channel",
            importance: Importance.max, priority: Priority.high),
        iOS: IOSNotificationDetails(
          presentSound: true,
          presentBadge: true,
          presentAlert: true,
          sound: "default",
        ),
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
