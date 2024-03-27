import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/modules/seller_main/controllers/seller_main_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:happytails/app/components/customs/custom_snackbar.dart';
import 'package:happytails/app/data/models/user_model.dart';
import 'package:happytails/app/data/provider/user_services.dart';
import 'package:happytails/app/modules/main/controllers/main_controller.dart';
import 'package:happytails/app/utils/memory_management.dart';

class ProfileController extends GetxController {
  final count = 0.obs;

  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();

  final String userName = "Madison Eve";
  final String userEmail = "madisoneve@gmail.com";
  final String userContact = "987654321";
  final String userLocation = "Lakeside, Pokhara";

  var userType = MemoryManagement.getUserType();

  UserServices userServices = UserServices();
  bool? isSeller;
  Rx<UserModel>? userDetail;

  void initializeUserDetail() {
    isSeller = userType == 'seller' ? true : false;
    userDetail = isSeller!
        ? Get.find<SellerMainController>().userDetail
        : Get.find<MainController>().userDetail;
  }

  ImagePicker picker = ImagePicker();
  XFile? userImage;
  var selectedPath = ''.obs;
  var selectedBytes = Rx<Uint8List?>(null);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  void onInit() {
    super.onInit(); // username = Sikha Kunwar
    initializeUserDetail();
    firstNameController.text = userDetail!.value.userName!.split(' ')[0];
    lastNameController.text = userDetail!.value.userName!.split(' ')[1];
    emailController.text = userDetail!.value.userEmail ?? '';
    contactController.text = userDetail!.value.userContact ?? '';
    locationController.text = userDetail!.value.userLocation ?? '';
    debugPrint(firstNameController.text);
    debugPrint(userDetail!.value.profileImage);
  }

  void onSave() async {
    try {
      await userServices
          .updateProfile(
        userId: MemoryManagement.getUserId() ?? 0,
        name: '${firstNameController.text} ${lastNameController.text}',
        email: emailController.text,
        contact: contactController.text,
        location: locationController.text,
        fileName: selectedPath.value,
        imageBytes: selectedBytes.value,
      )
          .then((value) {
        CustomSnackbar.successSnackbar(
          context: Get.context,
          title: 'Success',
          message: value,
          duration: const Duration(seconds: 3),
        );

        isSeller!
            ? Get.find<SellerMainController>().getUser()
            : Get.find<MainController>().getUser();
        isSeller!
            ? Get.find<SellerMainController>().getUser()
            : Get.find<MainController>().update();
        update();
      }).onError((error, stackTrace) {
        CustomSnackbar.errorSnackbar(
          context: Get.context,
          title: 'Error',
          message: error.toString(),
          duration: const Duration(seconds: 20),
        );
        debugPrint(error.toString());
        update();
      });
    } catch (e) {
      CustomSnackbar.errorSnackbar(
        context: Get.context,
        title: 'Error',
        message: e.toString(),
        duration: const Duration(seconds: 20),
      );
      update();
      debugPrint("Error in profile updation: $e");
      rethrow;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
