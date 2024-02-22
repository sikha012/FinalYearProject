import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void errorSnackbar({
    required BuildContext? context,
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      titleText: Text(
        title,
        // style: Theme.of(
        //   Get.context().textTheme.titleLarge!.copyWith(
        //         fontSize: 16,
        //         fontWeight:
        //       ),
        // ),
      ),
      messageText: Text(
        message,
      ),
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
      icon: const Icon(
        Icons.error,
        size: 35,
        color: Colors.white,
      ),
      shouldIconPulse: true,
      duration: const Duration(seconds: 3),
    );
  }

  static void infoSnackbar({
    required BuildContext? context,
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      titleText: Text(
        title,
        // style: Theme.of(
        //   Get.context().textTheme.titleLarge!.copyWith(
        //         fontSize: 16,
        //         fontWeight:
        //       ),
        // ),
      ),
      messageText: Text(
        message,
      ),
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
      icon: const Icon(
        Icons.error,
        size: 35,
        color: Colors.white,
      ),
      shouldIconPulse: true,
      duration: const Duration(seconds: 3),
    );
  }

  static void successSnackbar({
    required BuildContext? context,
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      titleText: Text(
        title,
        // style: Theme.of(
        //   Get.context().textTheme.titleLarge!.copyWith(
        //         fontSize: 16,
        //         fontWeight:
        //       ),
        // ),
      ),
      messageText: Text(
        message,
      ),
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
      icon: const Icon(
        Icons.error,
        size: 35,
        color: Colors.white,
      ),
      shouldIconPulse: true,
      duration: const Duration(seconds: 3),
    );
  }
}
