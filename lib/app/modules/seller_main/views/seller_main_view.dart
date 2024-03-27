import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/seller_main_controller.dart';

class SellerMainView extends GetView<SellerMainController> {
  const SellerMainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SellerMainController());
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
            selectedLabelStyle: const TextStyle(color: Colors.white),
            unselectedLabelStyle: const TextStyle(color: Colors.white),
            iconSize: 30,
            selectedFontSize: 14,
            currentIndex: controller.currentPageIndex.value,
            onTap: (index) {
              controller.onPageSelected(index);
            },
            items: controller.navbarItems,
          ),
        ),
      ),
    );
  }
}
