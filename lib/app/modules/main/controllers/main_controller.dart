import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/components/customs/custom_snackbar.dart';
import 'package:happytails/app/data/models/user_model.dart';
import 'package:happytails/app/data/provider/user_services.dart';
import 'package:happytails/app/modules/categories/views/categories_view.dart';
import 'package:happytails/app/modules/home/views/home_view.dart';
import 'package:happytails/app/modules/offers/views/offers_view.dart';
import 'package:happytails/app/modules/profile/views/profile_view.dart';
import 'package:happytails/app/utils/memory_management.dart';

class MainController extends GetxController {
  final count = 0.obs;
  var currentPageIndex = 0.obs;
  UserServices userServices = UserServices();
  Rx<UserModel> userDetail = UserModel().obs;

  final pages = const [
    HomeView(),
    OffersView(),
    CategoriesView(),
    ProfileView(),
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
        MemoryManagement.setUserId(value.userId ?? 0);
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
