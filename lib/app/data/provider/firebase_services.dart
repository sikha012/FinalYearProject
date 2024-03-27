import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_core/src/get_main.dart';

class FirebaseServices {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    // navigatorKey.currentState
    //     ?.pushNamed(Routes.ORDERS_DELIVERY, arguments: message);
    // Get.toNamed(Routes.ORDERS_DELIVERY, arguments: message);
    // if (message.data['messageType'] == 'deliveryStatus') {
    //   Get.find<OrdersPageController>()
    //       .getOrderedProductsForUser(LocalStorage.getUserId() ?? 0);
    //   Get.find<OrdersPageController>().update();
    //   Get.toNamed(Routes.ORDERS_PAGE);
    // } else {
    //   Get.toNamed(Routes.MAIN);
    // }
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    //FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) {
        return;
      } else {
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
    });
  }

//   Future initLocalNotifications(int userId) async {
  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@drawable/applogo');
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (notificationResponse) {
        final payload = notificationResponse.payload;
        final message = RemoteMessage.fromMap(jsonDecode(payload!));
        handleMessage(message);
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
    // Get.find<OrdersPageController>().getOrderedProductsForUser(userId);
    // Get.find<OrdersPageController>().update();
  }

//   Future<void> initNotifications(int currentUserId) async {
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    debugPrint("Token $fcmToken");
    //LocalStorage.setFcmToken(fcmToken ?? 'No Token');
    initPushNotifications();
    initLocalNotifications();
    //Get.put(OrdersPageController()).getOrderedProductsForUser(currentUserId);
  }
}
