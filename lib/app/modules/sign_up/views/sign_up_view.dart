import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:initial_app/app/components/customs/custom_button.dart';
import 'package:initial_app/app/components/customs/custom_textfield.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                      controller: TextEditingController(),
                      label: "Username",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextfield(
                      controller: TextEditingController(),
                      label: "Email",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextfield(
                      controller: TextEditingController(),
                      label: "Contact number",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextfield(
                      controller: TextEditingController(),
                      label: "Address",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextfield(
                      controller: TextEditingController(),
                      label: "Password",
                      isPassword: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextfield(
                      controller: TextEditingController(),
                      label: "Re-type Password",
                      isPassword: true,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                      label: "Sign Up",
                      onPressed: () {},
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
                            Get.back();
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
