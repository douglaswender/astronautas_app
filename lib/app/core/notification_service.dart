import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:astronautas_app/app/core/app_colors.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static Future<void> initialize() async {
    await messaging.requestPermission();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('drawable/ic_stat');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    listen();
  }

  static void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  static void displayNotification(
      {required String title, required String body}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'high_importance_channel',
      'high_importance_channel',
      channelDescription: 'high_importance_channel',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      color: AppColors.primary,
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: 'item x');
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    //print("Handling a background message: ${message.messageId}");
  }

  static void listen() async {
    FirebaseMessaging.onMessage.listen((message) {
      //print(message.data);
      if (message.notification != null) {
        displayNotification(
            title: message.notification?.title ?? '',
            body: message.notification?.body ?? '');
      }
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  static Future<void> sendUserNotification({
    required List tokens,
    String? title,
    required String body,
  }) async {
    final rc = FirebaseRemoteConfig.instance;
    await rc.fetchAndActivate();
    final messagingToken = rc.getString('messaging_token');
    for (String token in tokens) {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Authorization': 'key=$messagingToken',
          'Content-Type': 'application/json',
        },
        body:
            '''{
          "priority": "high",
          "data": {
            "click_action": "NOTIFICATION_CLICK",
            "status": "done",
            "body": "$body",
            "title": "${title ?? ''}"
          },
          "notification": {
            "body": "$body",
            "title": "${title ?? ''}",
            "android_channel_id": "high_importance_channel"
          },
          "to": "$token",
          "direct_boot_ok" : true
        }''',
      );
    }
  }
}
