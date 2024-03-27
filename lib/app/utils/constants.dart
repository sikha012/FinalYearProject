import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

class Constants {
  static const primaryColor = Color(0xFF54C7EC);
  static const backgroundColor = Color(0xFFEEEEEE);
  static const tertiaryColor = Color(0xFFFFA500);
}

Future<String?> getCurrentIp() async {
  return await NetworkInfo().getWifiIP();
}

// var currentIpAddress = '${getCurrentIp()}:8001';
var currentIpAddress = '192.168.1.71:8001';

var baseUrlLink = 'http://$currentIpAddress';

var getImage = (imageUrl) {
  return '$baseUrlLink/$imageUrl';
};
