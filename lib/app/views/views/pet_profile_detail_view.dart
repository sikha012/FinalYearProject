import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happytails/app/components/customs/custom_button.dart';
import 'package:happytails/app/data/models/pet_profile.dart';
import 'package:happytails/app/modules/pet_profiles/controllers/pet_profiles_controller.dart';
import 'package:happytails/app/utils/asset_files.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:intl/intl.dart';

class PetProfileDetailView extends GetView<PetProfilesController> {
  const PetProfileDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PetProfile petProfile = Get.arguments['petProfile'];

    debugPrint(petProfile.petName);
    debugPrint(petProfile.ownerId.toString());
    debugPrint(petProfile.petAge.toString());
    var controller = Get.find<PetProfilesController>();
    controller.getPetHistory(petProfile.petId ?? 0);
    //var history = controller.getPetHistory(petProfile.petId ?? 0);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            petProfile.petName ?? '',
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
          centerTitle: true,
          backgroundColor: Constants.primaryColor,
          foregroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              controller.petHistory.clear();
              controller.update();
              Get.back();
            },
            child: const Icon(
              CupertinoIcons.back,
              size: 30,
            ),
          ),
        ),
        body: GetBuilder<PetProfilesController>(
          builder: (controller) => Container(
            color: Constants.backgroundColor,
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Hero(
                              tag: 'petProfile+${petProfile.petId}',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: petProfile.petImage == null
                                    ? Image.asset(AssetFile.cartProductImage)
                                    : Image.network(
                                        getImage(
                                          petProfile.petImage,
                                        ),
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.showEditPetDialog(petProfile);
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.edit_note,
                                        size: 35,
                                        color: Constants.primaryColor,
                                      ),
                                      Text(
                                        "Edit",
                                        style: TextStyle(
                                          color: Constants.primaryColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Name: ',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      petProfile.petName ?? '',
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Age: ',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      petProfile.petAge.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Type: ',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      petProfile.petcategoryName.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.history,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Records",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            CustomButton(
                              label: 'Add Record',
                              labelStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              width: 150,
                              height: 40,
                              disableBorder: true,
                              onPressed: () {
                                controller.showAddPetHistoryDialog(
                                    petProfile.petId ?? 0);
                                controller.getPetHistory(petProfile.petId ?? 0);
                                controller.update();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // FutureBuilder(
                        //   future: controller.getPetHistory(petProfile.petId ?? 0),
                        //   builder: (context, AsyncSnapshot snapshot) {
                        //     if (snapshot.connectionState ==
                        //         ConnectionState.waiting) {
                        //       // Show a loading indicator while the history is being fetched
                        //       return const CircularProgressIndicator();
                        //     } else if (snapshot.hasError) {
                        //       // If we have an error, display it
                        //       return Text('Error: ${snapshot.error}');
                        //     } else {
                        //       return Obx(
                        //         () {
                        //           if (controller.petHistory.isEmpty) {
                        //             return const Padding(
                        //               padding: EdgeInsets.only(top: 30),
                        //               child: Text(
                        //                 "No history recorded yet...",
                        //                 style: TextStyle(
                        //                     fontSize: 20, color: Colors.grey),
                        //               ),
                        //             );
                        //           } else {
                        //             return ListView.builder(
                        //               scrollDirection: Axis.vertical,
                        //               physics: const BouncingScrollPhysics(),
                        //               shrinkWrap: true,
                        //               itemCount: controller.petHistory.length,
                        //               itemBuilder: (context, index) => Container(
                        //                 margin: const EdgeInsets.only(bottom: 5),
                        //                 padding: const EdgeInsets.all(10),
                        //                 decoration: BoxDecoration(
                        //                   color: Colors.white,
                        //                   borderRadius: BorderRadius.circular(10),
                        //                 ),
                        //                 child: Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.start,
                        //                   children: [
                        //                     Text(
                        //                       "${controller.petHistory[index].eventName}",
                        //                       style: const TextStyle(
                        //                         fontSize: 17,
                        //                       ),
                        //                     ),
                        //                     Text(
                        //                       "${controller.petHistory[index].eventDescription}",
                        //                       style: const TextStyle(
                        //                         fontSize: 14,
                        //                       ),
                        //                     ),
                        //                     Text(
                        //                       "Date: ${DateFormat('yyyy-MM-dd').format(controller.petHistory[index].eventDate!)}",
                        //                       style: const TextStyle(
                        //                         fontSize: 15,
                        //                         fontStyle: FontStyle.italic,
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             );
                        //           }
                        //         },
                        //       );
                        //     }
                        //   },
                        // ),
                        controller.petHistory.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Text(
                                  "No history recorded yet...",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : Obx(
                                () => ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.petHistory.length,
                                  itemBuilder: (context, index) => Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${controller.petHistory[index].eventName}",
                                              style: TextStyle(
                                                fontSize: 17,
                                              ),
                                            ),
                                            Text(
                                              "${controller.petHistory[index].eventDescription}",
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              "Date: ${DateFormat('yyyy-MM-dd').format(controller.petHistory[index].eventDate!)}",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                          right: 5,
                                          top: 20,
                                          child: GestureDetector(
                                            onTap: () {
                                              controller
                                                  .showDeleteHistoryDialog(
                                                      controller
                                                              .petHistory[index]
                                                              .historyId ??
                                                          0,
                                                      petProfile.petId ?? 0);
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

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {
                  //         if (controller.productQuantity > 1) {
                  //           controller.productQuantity--;
                  //         }
                  //       },
                  //       icon: Icon(
                  //         Icons.remove,
                  //         size: 20,
                  //       ),
                  //     ),
                  //     Obx(
                  //       () => Text(
                  //         controller.productQuantity.toString(),
                  //         style: TextStyle(fontSize: 20),
                  //       ),
                  //     ),
                  //     IconButton(
                  //       onPressed: () {
                  //         controller.productQuantity++;
                  //       },
                  //       icon: const Icon(
                  //         Icons.add,
                  //         size: 20,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     CustomButton(
                  //       width: Get.width * 0.4,
                  //       label: 'Add to Cart',
                  //       onPressed: () {
                  //         userCartController.addToCart(
                  //           petProfile: petProfile,
                  //           productQuantity: controller.productQuantity.value,
                  //         );
                  //       },
                  //     ),
                  //     const SizedBox(
                  //       width: 20,
                  //     ),
                  //     CustomButton(
                  //       width: Get.width * 0.4,
                  //       label: 'Buy Now',
                  //       onPressed: () {},
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}
