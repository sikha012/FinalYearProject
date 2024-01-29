import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:initial_app/app/modules/main/views/main_view.dart';

class SignInController extends GetxController {
  final count = 0.obs;
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> onLogin() async {
    String url = 'http://192.168.1.71:8001/login';
    Uri uri = Uri.parse(url);
    final response = await http.post(uri, body: {
      "email": emailController.text,
      "password": passwordController.text,
    });

    Map<String, dynamic> login = json.decode(response.body);
    if (response.statusCode == 200) {
      debugPrint(login.toString());
      debugPrint(login['msg']);
      Get.showSnackbar(
        GetSnackBar(
          message: login['msg'],
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 1),
        ),
      );
      Get.offAll(() => const MainView());
    } else if (response.statusCode == 401) {
      Get.showSnackbar(
        GetSnackBar(
          message: login['msg'],
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 1),
        ),
      );
    } else {
      debugPrint("failed to load");
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
