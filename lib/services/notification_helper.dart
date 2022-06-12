import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  String token = '';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  initialNotification() async {
    getToken();
    if (firebaseMessaging.getInitialMessage() != null) {
      RemoteMessage message = await firebaseMessaging.getInitialMessage();
      if (message != null) {
        navigateToPage(jsonEncode(message.data));
      }
    }
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );

    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
     
      if (message.data != null) {
     

        navigateToPage(jsonEncode(message.data));

      
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
 

      if (message.data != null) {
        // showNotification(message.data['title'], message.data['body'],
        //     '${message.data['id']}/${message.data['page']}');
      
        showNotification(
          message.notification.title,
          message.notification.body,
          jsonEncode(message.data),
        );
      }
    });
  }

  Future onSelectNotification(String payload) async {
    navigateToPage(payload);
  }

  navigateToPage(String data2) {
  }

  void showNotification(String title, String body, String payload) async {
    await _demoNotification(
      title,
      body,
      payload,
    );
  }

  Future<void> _demoNotification(
      String title, String body, String payload) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_ID',
      'channel name',
      // 'channel description',
      importance: Importance.max,
      playSound: true,
      showProgress: true,
      priority: Priority.high,
      ticker: 'test ticker',
    );

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
  }

  getToken() async {
    firebaseMessaging.subscribeToTopic('all');
    token = await firebaseMessaging.getToken();
    return token;
  }
}
