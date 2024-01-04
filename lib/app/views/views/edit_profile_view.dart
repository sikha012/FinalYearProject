import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:initial_app/app/components/customs/custom_button.dart';
import 'package:initial_app/app/components/edit_profile_form.dart';
import 'package:initial_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:initial_app/app/utils/asset_files.dart';
import 'package:initial_app/app/utils/constants.dart';

class EditProfileView extends GetView {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Constants.backgroundColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 14),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.back,
                color: Constants.tertiaryColor,
                size: 30,
              ),
              // Text(
              //   "Back",
              //   style: TextStyle(
              //     color: Constants.tertiaryColor,
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Align(
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
                    margin: EdgeInsets.only(top: 150),
                    padding: EdgeInsets.fromLTRB(15, 35, 15, 15),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        EditProfileForm(
                          controller: TextEditingController(),
                          label: "First Name",
                        ),
                        EditProfileForm(
                          controller: TextEditingController(),
                          label: "Last Name",
                        ),
                        EditProfileForm(
                          controller: TextEditingController(),
                          label: "Email",
                        ),
                        EditProfileForm(
                          controller: TextEditingController(),
                          label: "Contact",
                        ),
                        EditProfileForm(
                          controller: TextEditingController(),
                          label: "Location",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 75),
                          child: GestureDetector(
                            onTap: () {},
                            child: Row(
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
                  Positioned(
                    left: 80,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Constants.tertiaryColor,
                          child: Image.asset(
                            AssetFile.userImage,
                            fit: BoxFit.cover,
                          ),
                          radius: 100,
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Constants.primaryColor,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
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
              SizedBox(
                height: 20,
              ),
              CustomButton(
                label: "Save",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
