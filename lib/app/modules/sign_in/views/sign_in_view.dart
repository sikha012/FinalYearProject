import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:initial_app/app/components/customs/custom_button.dart';
import 'package:initial_app/app/components/customs/custom_textfield.dart';
import 'package:initial_app/app/modules/main/views/main_view.dart';
import 'package:initial_app/app/modules/sign_up/views/sign_up_view.dart';
import 'package:lottie/lottie.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SignInController());
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
                  key: controller.signInFormKey,
                  child: Column(
                    children: [
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 50,
                          fontFamily: GoogleFonts.ole().fontFamily,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: Lottie.asset("assets/lotties/LazyDogs.json"),
                      ),
                      CustomTextfield(
                        controller: controller.emailController,
                        label: "Email",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextfield(
                        controller: controller.passwordController,
                        label: "Password",
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text("Forgot Password?"),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      CustomButton(
                        label: "Sign In",
                        onPressed: () {
                          controller.onLogin();
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => SignUpView());
                            },
                            child: Text(
                              "Sign Up",
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
                    borderRadius: BorderRadius.circular(250)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
