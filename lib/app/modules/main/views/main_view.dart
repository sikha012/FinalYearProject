import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
              controller.onPageSelected(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(5),
                  color: Theme.of(context).colorScheme.primary,
                  child: Icon(Icons.home),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                label: "Home",
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(5),
                  color: Theme.of(context).colorScheme.primary,
                  child: Icon(Icons.discount),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.discount,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                label: "Offers",
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(5),
                  color: Theme.of(context).colorScheme.primary,
                  child: Icon(Icons.category),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.category,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                label: "Categories",
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(5),
                  color: Theme.of(context).colorScheme.primary,
                  child: Icon(Icons.person_2_rounded),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.person_2_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                label: "Profile",
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
