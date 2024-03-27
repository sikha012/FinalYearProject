import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happytails/app/components/customs/custom_button.dart';
import 'package:happytails/app/components/customs/custom_textfield.dart';
import 'package:happytails/app/modules/sign_up/views/sign_up_view.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:lottie/lottie.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: Constants.primaryColor,
              ),
            )
          : Scaffold(
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
                          key: controller.signInKey,
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
                                child: Lottie.asset(
                                    "assets/lotties/LazyDogs.json"),
                              ),
                              CustomTextfield(
                                controller: controller.emailController,
                                label: "Email",
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email';
                                  } else if (!GetUtils.isEmail(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextfield(
                                controller: controller.passwordController,
                                label: "Password",
                                isPassword: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  // Add more password validation if needed
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: const Text("Forgot Password?"),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              CustomButton(
                                label: "Sign In",
                                onPressed: () {
                                  controller.onSignIn();
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => const SignUpView());
                                    },
                                    child: const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        color: Color(0xFFFFA500),
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
                          color: const Color(0xFF54C7EC),
                          borderRadius: BorderRadius.circular(250),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
