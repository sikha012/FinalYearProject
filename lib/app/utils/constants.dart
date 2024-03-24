import 'package:flutter/material.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:network_info_plus/network_info_plus.dart';

class Constants {
  static const primaryColor = Color(0xFF54C7EC);
  static const backgroundColor = Color(0xFFEEEEEE);
  static const tertiaryColor = Color(0xFFFFA500);
}

Future<String?> getCurrentIp() async {
  var info = NetworkInfo();
  var wifiIp = await info.getWifiIP();
  return wifiIp ?? "No Ip";
}

// var currentIpAddress = '${getCurrentIp()}:8001';
Future<String> getBaseUrl() async {
  var url = await getCurrentIp();
  return "$url:8001";
}

var currentIpAddress = '172.25.5.55:8001';

var baseUrlLink = 'http://$currentIpAddress';

var getImage = (imageUrl) {
  return '$baseUrlLink/$imageUrl';
};
