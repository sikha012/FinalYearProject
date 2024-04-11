import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happytails/app/components/pet_profile_card.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:happytails/app/views/views/pet_profile_detail_view.dart';

import '../controllers/pet_profiles_controller.dart';

class PetProfilesView extends GetView<PetProfilesController> {
  const PetProfilesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: GetBuilder<PetProfilesController>(
        builder: (controller) => Container(
          padding: const EdgeInsets.fromLTRB(15, 60, 15, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
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
                          // Text(
                          //   'Back',
                          //   style: TextStyle(
                          //     fontSize: 20,
                          //     color: Constants.tertiaryColor,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 65,
                    ),
                    const Text(
                      'Your Pet Profiles',
                      style: TextStyle(
                        color: Constants.primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                controller.petProfiles.isEmpty
                    ? SizedBox(
                        height: Get.height,
                        child: Center(
                          child: Text(
                            "No Pet profiles added yet...",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.petProfiles.length,
                          itemBuilder: (context, index) => SizedBox(
                            height: 150,
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const PetProfileDetailView(),
                                        arguments: {
                                          'petProfile':
                                              controller.petProfiles[index],
                                        });
                                  },
                                  child: PetProfileCard(
                                    petProfile: controller.petProfiles[index],
                                  ),
                                ),
                                Positioned(
                                  right: 5,
                                  top: 50,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.showDeletePetProfileDialog(
                                        controller.petProfiles[index].petId ??
                                            0,
                                        controller.petProfiles[index].petName ??
                                            '',
                                      );
                                    },
                                    child: const Icon(
                                      Icons.delete_forever,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton.icon(
        style: const ButtonStyle(
          elevation: MaterialStatePropertyAll(5),
          backgroundColor: MaterialStatePropertyAll(
            Constants.tertiaryColor,
          ),
          foregroundColor: MaterialStatePropertyAll(
            Colors.white,
          ),
        ),
        onPressed: () {
          controller.showAddPetDialog();
        },
        icon: const Icon(CupertinoIcons.add),
        label: const Text('Add New Profile'),
      ),
    );
  }
}
