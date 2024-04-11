// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happytails/app/components/customs/custom_button.dart';
import 'package:happytails/app/modules/main/controllers/main_controller.dart';
import 'package:happytails/app/modules/order_status/views/order_status_view.dart';
import 'package:happytails/app/modules/seller_main/controllers/seller_main_controller.dart';
import 'package:happytails/app/routes/app_pages.dart';
import 'package:happytails/app/utils/asset_files.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:happytails/app/utils/memory_management.dart';
import 'package:happytails/app/views/views/edit_profile_view.dart';
import 'package:happytails/app/views/views/seller_orders_summary_view.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: Column(
        children: [
          Container(
            width: Get.width,
            height: Get.height * 0.35,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -250,
                  child: Container(
                    width: Get.width,
                    decoration: const BoxDecoration(
                      color: Color(0xFF54C7EC),
                    ),
                    child: Image.asset(
                      AssetFile.pawPrintsProfile,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 130,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Constants.tertiaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Obx(
                          () => controller.userDetail!.value.profileImage !=
                                  null
                              ? CircleAvatar(
                                  radius: 70,
                                  backgroundImage: NetworkImage(
                                    getImage(
                                      controller.userDetail!.value.profileImage,
                                    ),
                                  ),
                                )
                              : controller.selectedBytes.value != null
                                  ? CircleAvatar(
                                      radius: 70,
                                      backgroundImage: MemoryImage(
                                        controller.selectedBytes.value!,
                                      ),
                                    )
                                  : const CircleAvatar(
                                      backgroundImage: AssetImage(
                                        AssetFile.userImage,
                                      ),
                                      radius: 70,
                                    ),
                        ),
                      ),
                      Obx(
                        () => Text(
                          controller.userDetail!.value.userName ??
                              'No user name',
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Obx(
                        () => Text(
                          controller.userDetail!.value.userEmail ??
                              'No email found',
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomButton(
                        width: 150,
                        height: 35,
                        label: "Edit Profile",
                        labelStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Get.to(() => const EditProfileView());
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: Get.width,
            margin: EdgeInsets.fromLTRB(25, 35, 25, 0),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  offset: Offset.fromDirection(-5, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                controller.userType == 'seller'
                    ? SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.pets,
                                color: Color(0xFF8C8C8C),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "My Pets",
                                style: TextStyle(
                                  color: Color(0xFF8C8C8C),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFEEEEEE),
                              ),
                              child: Icon(
                                CupertinoIcons.forward,
                                color: Color(0xFF8C8C8C),
                              ),
                            ),
                            onTap: () {
                              Get.toNamed(Routes.PET_PROFILES);
                            },
                          )
                        ],
                      ),
                controller.userType == 'seller'
                    ? SizedBox.shrink()
                    : SizedBox(
                        height: 5,
                      ),
                controller.userType == 'seller'
                    ? SizedBox.shrink()
                    : Divider(
                        color: Color(0xFFEEEEEE),
                      ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.shopping_bag,
                          color: Color(0xFF8C8C8C),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          controller.userType == 'seller'
                              ? "Orders"
                              : "My Orders",
                          style: TextStyle(
                            color: Color(0xFF8C8C8C),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFFEEEEEE)),
                        child: Icon(
                          CupertinoIcons.forward,
                          color: Color(0xFF8C8C8C),
                        ),
                      ),
                      onTap: () {
                        controller.userType == 'seller'
                            ? Get.to(() => const SellerOrdersSummaryView())
                            : Get.to(() => const OrderStatusView());
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Color(0xFFEEEEEE),
                ),
                SizedBox(
                  height: 5,
                ),
                controller.userType == 'seller'
                    ? SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.shopping_cart,
                                color: Color(0xFF8C8C8C),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "My Cart",
                                style: TextStyle(
                                  color: Color(0xFF8C8C8C),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFEEEEEE)),
                              child: Icon(
                                CupertinoIcons.forward,
                                color: Color(0xFF8C8C8C),
                              ),
                            ),
                            onTap: () {},
                          )
                        ],
                      ),
                controller.userType == 'seller'
                    ? SizedBox.shrink()
                    : SizedBox(
                        height: 5,
                      ),
                controller.userType == 'seller'
                    ? SizedBox.shrink()
                    : Divider(
                        color: Color(0xFFEEEEEE),
                      ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.info,
                          color: Color(0xFF8C8C8C),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "About Us",
                          style: TextStyle(
                            color: Color(0xFF8C8C8C),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFFEEEEEE)),
                        child: Icon(
                          CupertinoIcons.forward,
                          color: Color(0xFF8C8C8C),
                        ),
                      ),
                      onTap: () {},
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Color(0xFFEEEEEE),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.privacy_tip,
                          color: Color(0xFF8C8C8C),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Privacy Policy",
                          style: TextStyle(
                            color: Color(0xFF8C8C8C),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFFEEEEEE)),
                        child: Icon(
                          CupertinoIcons.forward,
                          color: Color(0xFF8C8C8C),
                        ),
                      ),
                      onTap: () {},
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Color(0xFFEEEEEE),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    controller.onSignOut();
                  },
                  child: Text(
                    "LOG OUT",
                    style: TextStyle(
                      color: Color(0xFFFFA500),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
