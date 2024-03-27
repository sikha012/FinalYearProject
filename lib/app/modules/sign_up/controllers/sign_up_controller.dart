import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/components/customs/custom_snackbar.dart';
import 'package:happytails/app/data/provider/auth_services.dart';
import 'package:happytails/app/routes/app_pages.dart';

class SignUpController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  var isSeller = false.obs;
  AuthService auth = AuthService();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  void updateIsSeller(bool? value) {
    if (value != null) {
      isSeller.value = value;
      update();
    }
  }

  Future<void> onSignUp() async {
    if (signUpFormKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        CustomSnackbar.errorSnackbar(
          context: Get.context,
          title: 'Error',
          message: "Passwords don't match",
        );
      } else {
        if (userNameController.text.split(' ').length >= 3) {
          CustomSnackbar.errorSnackbar(
            context: Get.context,
            title: 'Error',
            message: "Invalid user name!",
          );
        } else {
          try {
            isLoading.value = true;
            Map<String, dynamic> userData = {
              "username": userNameController.text,
              "email": emailController.text,
              "password": passwordController.text,
              "location": addressController.text,
              "contact": contactController.text,
              "userType": isSeller.value ? "seller" : "user",
            };
            await auth.signUp(userData).then((value) {
              CustomSnackbar.successSnackbar(
                context: Get.context,
                title: 'Success',
                message: value.toString(),
              );
              isLoading.value = true;
              Get.offAllNamed(Routes.SIGN_IN);
            }).onError((error, stackTrace) {
              CustomSnackbar.errorSnackbar(
                context: Get.context,
                title: 'Error',
                message: error.toString(),
              );
              isLoading.value = false;
            });
          } catch (e) {
            CustomSnackbar.errorSnackbar(
              context: Get.context,
              title: 'Error',
              message: 'Something went wrong...',
            );
            isLoading.value = false;
          }
        }
      }
    } else {
      CustomSnackbar.errorSnackbar(
        context: Get.context,
        title: 'Error',
        message: 'Please fill all the fields',
      );
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
