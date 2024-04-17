import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/components/customs/custom_snackbar.dart';
import 'package:happytails/app/data/provider/auth_services.dart';
import 'package:happytails/app/routes/app_pages.dart';
import 'package:happytails/app/utils/memory_management.dart';

class SignUpController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  var isSeller = false.obs;
  var verificationMessage = ''.obs;
  var hashValue = '';
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
        if (userNameController.text.split(' ').length >= 3 ||
            userNameController.text.split(' ').length <= 1) {
          CustomSnackbar.errorSnackbar(
            context: Get.context,
            title: 'Invalid user name!',
            message: "Your name must be only two words",
          );
          return;
        } else {
          try {
            isLoading.value = true;
            Map<String, dynamic> userData = {
              "username": userNameController.text,
              "email": emailController.text,
              // "token": MemoryManagement.getFCMToken() ?? "Null",
              "password": passwordController.text,
              "location": addressController.text,
              "contact": contactController.text,
              "userType": isSeller.value ? "seller" : "user",
            };
            await auth.signUp(userData).then((value) {
              CustomSnackbar.successSnackbar(
                context: Get.context,
                title: 'Success',
                message: value.message.toString(),
              );
              hashValue = value.data ?? 'Some hash value';
              isLoading.value = false;
              //Get.offAllNamed(Routes.SIGN_IN);
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

  Future<void> resendOTP(String email, String userName) async {
    try {
      isLoading(true);
      await auth.resendOTP(email, userName).then((responseMessage) {
        // OTP verified successfully
        verificationMessage(responseMessage); // Update the verification message
        CustomSnackbar.successSnackbar(
          context: Get.context,
          title: 'Resent',
          message: responseMessage,
        );
        // Navigate to the next screen or perform other actions after successful verification
        //Get.offAllNamed(Routes.SIGN_IN); // Assuming you have a home route
      }).onError((error, stackTrace) {
        // Error occurred during OTP verification
        CustomSnackbar.errorSnackbar(
          context: Get.context,
          title: 'Server Error',
          message: error.toString(),
          duration: Duration(seconds: 500),
        );
        //Get.offAllNamed(Routes.SIGN_UP);
      });
    } catch (e) {
      // Handle any other errors
      CustomSnackbar.errorSnackbar(
        context: Get.context,
        title: 'Error',
        message: 'An unexpected error occurred: $e',
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> verifyUserOTP(String email, String otp) async {
    try {
      isLoading(true);
      await auth.verifyOTP(email, otp, hashValue).then((responseMessage) {
        // OTP verified successfully
        verificationMessage(responseMessage); // Update the verification message
        CustomSnackbar.successSnackbar(
          context: Get.context,
          title: 'Success',
          message: responseMessage,
        );
        // Navigate to the next screen or perform other actions after successful verification
        Get.offAllNamed(Routes.SIGN_IN); // Assuming you have a home route
      }).onError((error, stackTrace) {
        // Error occurred during OTP verification
        CustomSnackbar.errorSnackbar(
          context: Get.context,
          title: 'Verification Error',
          message: error.toString(),
          duration: Duration(seconds: 500),
        );
        Get.offAllNamed(Routes.SIGN_UP);
      });
    } catch (e) {
      // Handle any other errors
      CustomSnackbar.errorSnackbar(
        context: Get.context,
        title: 'Error',
        message: 'An unexpected error occurred: $e',
      );
    } finally {
      isLoading(false);
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
