import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:initial_app/app/components/customs/custom_button.dart';
import 'package:initial_app/app/utils/asset_files.dart';
import 'package:initial_app/app/views/views/edit_profile_view.dart';

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
                  left: 115,
                  child: Column(
                    children: [
                      Container(
                        width: Get.width * 0.4,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: Image.asset(AssetFile.userImage),
                      ),
                      Text(
                        controller.userName,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(controller.userEmail),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
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
                      children: [
                        Icon(
                          Icons.shopping_bag,
                          color: Color(0xFF8C8C8C),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "My Orders",
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
                      children: [
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
                      children: [
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
                      children: [
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
                Text(
                  "LOG OUT",
                  style: TextStyle(
                    color: Color(0xFFFFA500),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
