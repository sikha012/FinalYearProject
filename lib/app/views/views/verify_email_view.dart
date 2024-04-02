import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/modules/sign_up/controllers/sign_up_controller.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

class VerifyEmailView extends GetView<SignUpController> {
  final SignUpController signUpController = Get.find<SignUpController>();
  VerifyEmailView({Key? key}) : super(key: key);
  final TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final String userEmail = Get.arguments['email'] as String;
    final String userName = Get.arguments['userName'] as String;
    OtpTimerButtonController timerController = OtpTimerButtonController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email'),
        centerTitle: true,
      ),
      body: GetBuilder<SignUpController>(
        builder: (controller) => Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello, ${userName.split(' ')[0]}. Please enter the OTP sent to your email.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    OTPTextField(
                      length: 4,
                      width: Get.width * 0.6,
                      fieldWidth: 50,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.box,
                      onCompleted: (value) {
                        signUpController.verifyUserOTP(userEmail, value);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    OtpTimerButton(
                      controller: timerController,
                      onPressed: () async {
                        await signUpController.resendOTP(userEmail, userName);
                        timerController.startTimer();
                      },
                      text: Text('Resend OTP'),
                      duration: 15,
                    ),
                  ],
                ),
              ),
              // TextField(
              //   controller: otpController,
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(
              //     labelText: 'OTP',
              //     hintText: 'Enter your OTP',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              SizedBox(height: 20),
              // Obx(
              //   () => ElevatedButton(
              //     onPressed: signUpController.isLoading.isFalse
              //         ? () => signUpController.verifyUserOTP(
              //             userEmail, otpController.text)
              //         : null,
              //     child: signUpController.isLoading.isFalse
              //         ? Text('Verify OTP')
              //         : CircularProgressIndicator(),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
