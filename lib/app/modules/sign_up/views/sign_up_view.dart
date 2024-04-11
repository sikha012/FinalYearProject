// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happytails/app/components/customs/custom_button.dart';
import 'package:happytails/app/components/customs/custom_snackbar.dart';
import 'package:happytails/app/components/customs/custom_textfield.dart';
import 'package:happytails/app/routes/app_pages.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:happytails/app/views/views/verify_email_view.dart';

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
              padding: const EdgeInsets.fromLTRB(22, 70, 22, 0),
              decoration: const BoxDecoration(
                color: Color(0xFFEEEEEE),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.signUpFormKey,
                  child: SizedBox(
                    height: Get.height,
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
                          // validator: (value) {
                          //   Pattern pattern =
                          //       r'^(([^<>()[]\.,;:\s@"]+(.[^<>()[]\.,;:\s@"]+)*)|(".+"))@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}])|(([a-zA-Z-0-9]+.)+[a-zA-Z]{2,}))$';
                          //   RegExp regex = RegExp(pattern as String);
                          //   if (!regex.hasMatch(value ?? '')) {
                          //     return 'Please enter a valid email';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextfield(
                          controller: controller.contactController,
                          label: "Contact number",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a contact number";
                            }
                            if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                              return "Please enter a valid contact number";
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
                            if (value == null || value.isEmpty) {
                              return "Please enter a password";
                            }
                            if (value.length < 8) {
                              return "The password must be at least 8 characters long";
                            }
                            if (!RegExp(r'[a-z]').hasMatch(value)) {
                              return "The password must contain at least one lowercase letter";
                            }
                            if (!RegExp(r'[A-Z]').hasMatch(value)) {
                              return "The password must contain at least one uppercase letter";
                            }

                            if (!RegExp(r'\d').hasMatch(value)) {
                              return "The password must contain at least one number";
                            }
                            if (!RegExp(r'[^A-Za-z0-9]').hasMatch(value)) {
                              return "The password must contain at least one special character";
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
                            if (value != controller.passwordController.text ||
                                value!.isEmpty) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
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
                          height: 10,
                        ),
                        CustomButton(
                          label: "Sign Up",
                          onPressed: () {
                            if (controller.signUpFormKey.currentState!
                                .validate()) {
                              if (controller.userNameController.text
                                          .split(' ')
                                          .length >=
                                      3 ||
                                  controller.userNameController.text
                                          .split(' ')
                                          .length <=
                                      1) {
                                CustomSnackbar.errorSnackbar(
                                  context: Get.context,
                                  title: 'Invalid user name!',
                                  message: "Your name must be only two words",
                                );
                                return;
                              }
                              controller.onSignUp().then((_) {
                                Get.to(() => VerifyEmailView(), arguments: {
                                  'email': controller.emailController.text,
                                  'userName':
                                      controller.userNameController.text,
                                });
                              }).onError((error, stackTrace) {});
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
