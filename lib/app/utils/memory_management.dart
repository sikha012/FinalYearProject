import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MemoryManagement {
  static SharedPreferences? prefs;
  static Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  static List<Map<String, dynamic>> getNotifications() {
    String? notificationsJson =
        prefs != null ? prefs!.getString('notifications') : null;
    if (notificationsJson != null) {
      List<dynamic> jsonList = jsonDecode(notificationsJson);
      return List<Map<String, dynamic>>.from(jsonList);
    } else {
      return [];
    }
  }

  static void saveNotification(Map<String, dynamic> notification) {
    List<Map<String, dynamic>> notifications = getNotifications();
    notifications.add(notification);
    prefs!.setString('notifications', jsonEncode(notifications));
  }

  static void removeNotifications() {
    prefs!.remove('notifications');
  }

  // For Access Token
  static String? getAccessToken() {
    return prefs != null ? prefs!.getString('accessToken') : null;
  }

  static void setAccessToken(String accessToken) {
    prefs!.setString('accessToken', accessToken);
  }

  static void removeAccessToken() {
    prefs!.remove('accessToken');
  }

  // For Refresh Token
  static String? getRefreshToken() {
    return prefs != null ? prefs!.getString('refreshToken') : null;
  }

  static void setRefreshToken(String refreshToken) {
    prefs!.setString('refreshToken', refreshToken);
  }

  static void removeRefreshToken() {
    prefs!.remove('refreshToken');
  }

  static int? getUserId() {
    return prefs != null ? prefs!.getInt('userId') : null;
  }

  static void setUserId(int userId) {
    prefs!.setInt('userId', userId);
  }

  // For User Role
  static String? getUserType() {
    return prefs != null ? prefs!.getString('userType') : null;
  }

  static void setUserType(String type) {
    prefs!.setString('userType', type);
  }

  static void removeUserType() {
    prefs!.remove('userType');
  }

  // For Cart
  static String? getMyCart() {
    return prefs != null ? prefs!.getString('cart') : null;
  }

  static void setMyCart(String cart) {
    prefs!.setString('cart', cart);
  }

  static void removeAll() async {
    await prefs!.clear();
  }
}
