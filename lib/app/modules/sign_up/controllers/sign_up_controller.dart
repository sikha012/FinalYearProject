import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpController extends GetxController {
  final count = 0.obs;
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  Future<void> onSignUp() async {
    String url = 'http://172.16.19.95:8001/register';
    Uri uri = Uri.parse(url);
    final response = await http.post(uri, body: {
      "username": userNameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "location": addressController.text,
      "contact": contactController.text,
    });

    Map<String, dynamic> register = json.decode(response.body);
    if (response.statusCode == 200) {
      debugPrint(register.toString());
      Get.showSnackbar(
        GetSnackBar(
          message: register['msg'],
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 1),
        ),
      );
      Get.back();
    } else if (response.statusCode == 400) {
      debugPrint(register.toString());
      Get.showSnackbar(
        GetSnackBar(
          message: register['msg'],
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 1),
        ),
      );
    } else if (response.statusCode == 409) {
      debugPrint(register.toString());
      Get.showSnackbar(
        GetSnackBar(
          message: register['msg'],
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
