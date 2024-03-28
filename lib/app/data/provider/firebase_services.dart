import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:happytails/app/modules/home/controllers/home_controller.dart';
import 'package:happytails/app/utils/memory_management.dart';

class FirebaseServices {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> _saveAndShowNotification(RemoteMessage message) async {
    // Save the notification to local storage
    MemoryManagement.saveNotification(message.data);

    increaseNotificationCount();

    // Show the notification using local_notifications plugin
    final notification = message.notification;
    if (notification != null) {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/applogo',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    }
  }

  void increaseNotificationCount() {
    final controller = Get.find<HomeController>();
    controller.notificationCount.value++;
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    debugPrint("FCM Token: $fcmToken");

    // Initialize local notifications
    await initLocalNotifications();

    // Handle notifications that are received while the app is in the foreground
    FirebaseMessaging.onMessage.listen(_saveAndShowNotification);

    // Handle notifications that are received while the app is in the background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen(_saveAndShowNotification);
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _saveAndShowNotification(message);
      }
    });

    // Optional: Set up a background message handler if you need to handle background messages
    // FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  Future initLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@drawable/applogo');
    const settings = InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (notificationResponse) {
        if (notificationResponse.payload != null) {
          final message =
              RemoteMessage.fromMap(jsonDecode(notificationResponse.payload!));
          _saveAndShowNotification(message);
        }
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }
}

// Uncomment and implement the background message handler if needed

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  MemoryManagement.saveNotification(message.data);
}
