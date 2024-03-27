import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:happytails/app/components/customs/custom_button.dart';
import 'package:happytails/app/components/edit_profile_form.dart';
import 'package:happytails/app/modules/profile/controllers/profile_controller.dart';
import 'package:happytails/app/utils/asset_files.dart';
import 'package:happytails/app/utils/constants.dart';

class EditProfileView extends GetView<ProfileController> {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: GetBuilder<ProfileController>(
        builder: (controller) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 60, 15, 0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: Get.back,
                  child: const Row(
                    children: [
                      Icon(
                        CupertinoIcons.back,
                        color: Constants.tertiaryColor,
                        size: 25,
                      ),
                      Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 20,
                          color: Constants.tertiaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 150),
                      padding: const EdgeInsets.fromLTRB(15, 35, 15, 15),
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
                      child: Form(
                        key: controller.editFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            EditProfileForm(
                              controller: controller.firstNameController,
                              label: "First Name",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                            EditProfileForm(
                              controller: controller.lastNameController,
                              label: "Last Name",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                            EditProfileForm(
                              controller: controller.emailController,
                              label: "Email",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!GetUtils.isEmail(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            EditProfileForm(
                              controller: controller.contactController,
                              label: "Contact",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your contact number';
                                }

                                return null;
                              },
                            ),
                            EditProfileForm(
                              controller: controller.locationController,
                              label: "Location",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your location';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 75),
                              child: GestureDetector(
                                onTap: () {},
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.change_circle_outlined,
                                      color: Constants.tertiaryColor,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Change Password",
                                      style: TextStyle(
                                        color: Constants.tertiaryColor,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 80,
                      child: Stack(
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
                              () => controller.selectedBytes.value != null
                                  ? CircleAvatar(
                                      radius: 95,
                                      backgroundImage: MemoryImage(
                                        controller.selectedBytes.value!,
                                      ),
                                    )
                                  : controller.userDetail!.value.profileImage !=
                                          null
                                      ? CircleAvatar(
                                          radius: 95,
                                          backgroundImage: NetworkImage(
                                            getImage(
                                              controller.userDetail!.value
                                                  .profileImage,
                                            ),
                                          ),
                                        )
                                      : const CircleAvatar(
                                          backgroundImage: AssetImage(
                                            AssetFile.userImage,
                                          ),
                                          radius: 95,
                                        ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: () async {
                                controller.userImage = await controller.picker
                                    .pickImage(source: ImageSource.gallery);
                                if (controller.userImage != null) {
                                  controller.selectedPath.value =
                                      controller.userImage!.name;
                                  Uint8List imageBytes =
                                      await controller.userImage!.readAsBytes();
                                  controller.selectedBytes.value = imageBytes;
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Constants.primaryColor,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      // Container(
                      //   width: Get.width * 0.6,
                      //   decoration: const BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.white,
                      //         blurRadius: 1,
                      //       ),
                      //     ],
                      //   ),
                      //   child: Image.asset(AssetFile.userImage),
                      // ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  label: "Save",
                  onPressed: () {
                    if (controller.editFormKey.currentState!.validate()) {
                      controller.onSave();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
