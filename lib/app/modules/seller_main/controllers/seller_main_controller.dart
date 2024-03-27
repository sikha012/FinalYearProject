import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/components/customs/custom_snackbar.dart';
import 'package:happytails/app/data/models/user_model.dart';
import 'package:happytails/app/data/provider/user_services.dart';
import 'package:happytails/app/modules/profile/views/profile_view.dart';
import 'package:happytails/app/modules/seller_orders/views/seller_orders_view.dart';
import 'package:happytails/app/modules/seller_products/views/seller_products_view.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:happytails/app/utils/memory_management.dart';

class SellerMainController extends GetxController {
  final count = 0.obs;
  var currentPageIndex = 0.obs;
  var isSeller = false.obs;
  UserServices userServices = UserServices();
  Rx<UserModel> userDetail = UserModel().obs;

  final pages = const [
    SellerProductsView(),
    SellerOrdersView(),
    ProfileView(),
  ];

  List<BottomNavigationBarItem> navbarItems = [
    BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(5),
        color: Constants.primaryColor,
        child: const Icon(Icons.dashboard),
      ),
      activeIcon: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: const Icon(
          Icons.dashboard,
          color: Constants.primaryColor,
        ),
      ),
      label: "My Products",
      backgroundColor: Constants.primaryColor,
    ),
    BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(5),
        color: Constants.primaryColor,
        child: const Icon(Icons.list),
      ),
      activeIcon: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: const Icon(
          Icons.list,
          color: Constants.primaryColor,
        ),
      ),
      label: "To Deliver",
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
        }
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
