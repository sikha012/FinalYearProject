import 'package:flutter/material.dart';

class Constants {
  static const primaryColor = Color(0xFF54C7EC);
  static const backgroundColor = Color(0xFFEEEEEE);
  static const tertiaryColor = Color(0xFFFFA500);
}

const currentIpAddress = '172.16.19.95:8001';
const baseUrlLink = 'http://$currentIpAddress';

var getProductImage = (imageUrl) {
  return '$baseUrlLink/$imageUrl';
};
