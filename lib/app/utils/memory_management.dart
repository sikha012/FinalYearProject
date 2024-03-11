import 'package:shared_preferences/shared_preferences.dart';

class MemoryManagement {
  static SharedPreferences? prefs;
  static Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return true;
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
  static String? getAccessRole() {
    return prefs != null ? prefs!.getString('role') : null;
  }

  static void setAccessRole(String token) {
    prefs!.setString('role', token);
  }

  static void removeAccessRole() {
    prefs!.remove('role');
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
