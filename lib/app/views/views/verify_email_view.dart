import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/modules/sign_up/controllers/sign_up_controller.dart';

class VerifyEmailView extends GetView<SignUpController> {
  final SignUpController signUpController = Get.find<SignUpController>();
  VerifyEmailView({Key? key}) : super(key: key);
  final TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final String userEmail = Get.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the OTP sent to $userEmail',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'OTP',
                hintText: 'Enter your OTP',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed: signUpController.isLoading.isFalse
                      ? () => signUpController.verifyUserOTP(
                          userEmail, otpController.text)
                      : null,
                  child: signUpController.isLoading.isFalse
                      ? Text('Verify OTP')
                      : CircularProgressIndicator(),
                )),
          ],
        ),
      ),
    );
  }
}
