import 'package:flutter/material.dart';

class Constants {
  static const primaryColor = Color(0xFF54C7EC);
  static const backgroundColor = Color(0xFFEEEEEE);
  static const tertiaryColor = Color(0xFFFFA500);
}

const currentIpAddress = '192.168.1.71:8001';
const baseUrlLink = 'http://$currentIpAddress';

var getImage = (imageUrl) {
  return '$baseUrlLink/$imageUrl';
};
