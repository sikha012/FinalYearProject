import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:initial_app/app/views/onBoardingScreen/firstscreen_view.dart';
import 'package:initial_app/app/views/onBoardingScreen/secondscreen_view.dart';
import 'package:initial_app/app/views/onBoardingScreen/thirdscreen_view.dart';

class OnboardingScreenController extends GetxController {

  final count = 0.obs;

  final PageController screensController = PageController();
  var activePage = 0.obs;
  final screens = [
    FirstscreenView(),
    SecondscreenView(),
    ThirdscreenView(),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  void increment() => count.value++;
}
