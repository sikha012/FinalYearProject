// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happytails/app/components/customs/custom_button.dart';
import 'package:happytails/app/components/customs/custom_textfield.dart';
import 'package:happytails/app/routes/app_pages.dart';
import 'package:happytails/app/utils/constants.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              padding: const EdgeInsets.fromLTRB(22, 90, 22, 0),
              decoration: const BoxDecoration(
                color: Color(0xFFEEEEEE),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.signUpFormKey,
                  child: Column(
                    children: [
                      Text(
                        "Create an Account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 50,
                          fontFamily: GoogleFonts.ole().fontFamily,
                        ),
                      ),
                      CustomTextfield(
                          controller: controller.userNameController,
                          label: "Username",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextfield(
                        controller: controller.emailController,
                        label: "Email",
                        validator: (value) {
                          if (!GetUtils.isEmail(value!)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextfield(
                        controller: controller.contactController,
                        label: "Contact number",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your contact number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextfield(
                        controller: controller.addressController,
                        label: "Address",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextfield(
                        controller: controller.passwordController,
                        label: "Password",
                        isPassword: true,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextfield(
                        controller: controller.confirmPasswordController,
                        label: "Re-type Password",
                        isPassword: true,
                        validator: (value) {
                          if (value != controller.passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              side: BorderSide(
                                style: BorderStyle.solid,
                                width: 2.5,
                                color: Constants.primaryColor,
                              ),
                              value: controller.isSeller.value,
                              onChanged: (bool? value) {
                                controller.updateIsSeller(value);
                              },
                            ),
                            Text(
                              'I am a seller',
                              style: TextStyle(
                                fontSize: 18,
                                color: Constants.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        label: "Sign Up",
                        onPressed: () {
                          if (controller.signUpFormKey.currentState!
                              .validate()) {
                            // If all validations pass, proceed with signup.
                            controller.onSignUp();
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.offAllNamed(Routes.SIGN_IN);
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                color: const Color(0xFFFFA500),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: -380,
              top: -320,
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  color: Color(0xFF54C7EC),
                  borderRadius: BorderRadius.circular(250),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
