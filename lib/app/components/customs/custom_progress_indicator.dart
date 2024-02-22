import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:initial_app/app/utils/constants.dart';

class FullScreenDialogLoader {
  static void showDialog() {
    Get.dialog(
      PopScope(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
        onPopInvoked: (didPop) => Future.value(false),
        // onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      barrierColor: Constants.backgroundColor,
      useSafeArea: true,
    );
  }

  static void cancelDialog() {
    if (Get.isDialogOpen!) Get.back();
  }
}
