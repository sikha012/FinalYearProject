import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happytails/app/modules/onboarding_screen/controllers/onboarding_screen_controller.dart';

class FirstscreenView extends GetView {
  const FirstscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/onboarding_1.png"),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: (){
                var controller = Get.find<OnboardingScreenController>();
                controller.activePage.value = controller.screens.length;
                },
                child: const Row(
                  children: [
                    Text(
                      "Skip",
                      style: TextStyle(color: Color(0xFFFFA500),
                    ),
                    ),
                    Icon(
                      CupertinoIcons.forward,
                      size: 25,
                      color: Color(0xFFFFA500),
                      )
                  ],
                )
            ),
          ),
          Positioned(
            child: ElevatedButton(onPressed: (){}, child: Text("Next")),

          ),
        ],
      )

    );
  }
}
