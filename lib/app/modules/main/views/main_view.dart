import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happytails/app/modules/home/controllers/home_controller.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => controller.pages[controller.currentPageIndex.value],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            elevation: 0,
            showUnselectedLabels: true,
            fixedColor: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.primary,
            unselectedFontSize: 14,
            selectedLabelStyle: TextStyle(color: Colors.white),
            unselectedLabelStyle: TextStyle(color: Colors.white),
            iconSize: 30,
            selectedFontSize: 14,
            currentIndex: controller.currentPageIndex.value,
            onTap: (index) {
              if (controller.currentPageIndex.value == 2) {
                Get.find<HomeController>().resetNotificationCount();
              }
              controller.onPageSelected(index);
            },
            items: controller.navbarItems,
          ),
        ),
      ),
    );
  }
}
