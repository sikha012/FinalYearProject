import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:happytails/app/modules/home/controllers/home_controller.dart';
import 'package:happytails/app/modules/order_status/controllers/order_status_controller.dart';
import 'package:happytails/app/modules/seller_orders/controllers/seller_orders_controller.dart';
import 'package:happytails/app/routes/app_pages.dart';
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
    try {
      MemoryManagement.saveNotification(message.data);
      print("Notification saved successfully");
    } catch (e) {
      print("Error saving notification: $e");
    }

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
    if (Get.isRegistered<HomeController>()) {
      final HomeController controller = Get.find<HomeController>();
      controller.notificationCount.value++;
    } else {
      print("HomeController is not found, cannot increase notification count.");
    }
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    debugPrint("FCM Token: $fcmToken");
    MemoryManagement.setFCMToken(fcmToken ?? 'Null');

    // Initialize local notifications
    const androidSettings = AndroidInitializationSettings('@drawable/applogo');
    final settings = InitializationSettings(android: androidSettings);
    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: handleNotificationTap,
    );

    // Handle notifications that are received while the app is in the foreground
    FirebaseMessaging.onMessage.listen(_saveAndShowNotification);

    // Handle notifications that are received while the app is in the background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen(_saveAndShowNotification);
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _saveAndShowNotification(message);
      }
    });
  }

  // Define what should happen when a notification is tapped
  void handleNotificationTap(NotificationResponse notificationResponse) {
    final message =
        RemoteMessage.fromMap(jsonDecode(notificationResponse.payload!));

    if (message.data['type'] == 'orderPlaced' && Get.context != null) {
      if (Get.isRegistered<SellerOrdersController>()) {
        final SellerOrdersController controller =
            Get.find<SellerOrdersController>();
        controller.getSoldProductsForUser();
        controller.update();
        Get.toNamed(Routes.SELLER_ORDERS);
      } else {
        var controller = Get.put(SellerOrdersController());
        controller.update();
        Get.toNamed(Routes.SELLER_ORDERS);
      }
    } else if (message.data['type'] == 'statusChanged' && Get.context != null) {
      if (Get.isRegistered<OrderStatusController>()) {
        final OrderStatusController controller =
            Get.find<OrderStatusController>();
        controller.getUserOrders();
        controller.update();
        Get.toNamed(Routes.ORDER_STATUS);
      } else {
        var controller = Get.put(OrderStatusController());
        controller.update();
        Get.toNamed(Routes.ORDER_STATUS);
      }
    }
  }

  Future<void> initLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@drawable/applogo');
    const settings = InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: handleNotificationTap,
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }
}
