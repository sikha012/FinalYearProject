import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/components/customs/custom_snackbar.dart';
import 'package:happytails/app/data/models/user_model.dart';
import 'package:happytails/app/data/provider/user_services.dart';
import 'package:happytails/app/modules/home/controllers/home_controller.dart';
import 'package:happytails/app/modules/home/views/home_view.dart';
import 'package:happytails/app/modules/offers/views/offers_view.dart';
import 'package:happytails/app/modules/profile/views/profile_view.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:happytails/app/utils/memory_management.dart';
import 'package:happytails/app/views/views/notifications_view.dart';

class MainController extends GetxController {
  final count = 0.obs;
  var currentPageIndex = 0.obs;
  var isSeller = false.obs;
  UserServices userServices = UserServices();
  Rx<UserModel> userDetail = UserModel().obs;

  final pages = const [
    HomeView(),
    OffersView(),
    NotificationsView(),
    ProfileView(),
  ];

  List<BottomNavigationBarItem> navbarItems = [
    BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(5),
        color: Constants.primaryColor,
        child: const Icon(Icons.home),
      ),
      activeIcon: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: const Icon(
          Icons.home,
          color: Constants.primaryColor,
        ),
      ),
      label: "Home",
      backgroundColor: Constants.primaryColor,
    ),
    BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(5),
        color: Constants.primaryColor,
        child: const Icon(Icons.discount),
      ),
      activeIcon: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: const Icon(
          Icons.discount,
          color: Constants.primaryColor,
        ),
      ),
      label: "Offers",
      backgroundColor: Constants.primaryColor,
    ),
    BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(5),
        color: Constants.primaryColor,
        child: Stack(
          children: [
            const Icon(CupertinoIcons.bell_fill),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 17,
                height: 17,
                decoration: BoxDecoration(
                  color: Constants.tertiaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Obx(
                  () => Center(
                    child: Text(
                      Get.put(HomeController())
                          .notificationCount
                          .value
                          .toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      activeIcon: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: const Icon(
          CupertinoIcons.bell_fill,
          color: Constants.primaryColor,
        ),
      ),
      label: "Notifications",
      backgroundColor: Constants.primaryColor,
    ),
    BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(5),
        color: Constants.primaryColor,
        child: const Icon(Icons.person_2_rounded),
      ),
      activeIcon: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: const Icon(
          Icons.person_2_rounded,
          color: Constants.primaryColor,
        ),
      ),
      label: "Profile",
      backgroundColor: Constants.primaryColor,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  void getUser() async {
    try {
      await userServices.getUser().then((value) {
        userDetail.value = value;
        debugPrint(value.userId.toString());
        debugPrint(value.userName.toString());
        debugPrint(value.userEmail.toString());
        debugPrint(value.userContact.toString());
        debugPrint(value.userLocation.toString());
        debugPrint(value.userType.toString());
        MemoryManagement.setUserId(value.userId ?? 0);
        if (value.userType == 'seller') {
          isSeller.value = true;
          update();
        } else {}
      }).onError((error, stackTrace) {
        CustomSnackbar.errorSnackbar(
          duration: const Duration(seconds: 100),
          context: Get.context,
          title: 'Error',
          message: error.toString(),
        );
      });
    } catch (e) {
      CustomSnackbar.errorSnackbar(
        context: Get.context,
        title: 'Error',
        message: 'Something went wrong...',
      );
    }
  }

  void onPageSelected(int index) {
    currentPageIndex.value = index;
    update();
  }

  void increment() => count.value++;
}
