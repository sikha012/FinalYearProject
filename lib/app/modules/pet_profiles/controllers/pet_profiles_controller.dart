import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/data/models/pet_history.dart';
import 'package:happytails/app/modules/pet_profiles/views/pet_profiles_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:happytails/app/components/customs/custom_button.dart';
import 'package:happytails/app/components/customs/custom_snackbar.dart';
import 'package:happytails/app/components/customs/custom_textfield.dart';
import 'package:happytails/app/data/models/pet_category.dart';
import 'package:happytails/app/data/models/pet_profile.dart';
import 'package:happytails/app/data/provider/pet_services.dart';
import 'package:happytails/app/modules/main/controllers/main_controller.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:happytails/app/utils/memory_management.dart';
import 'package:path/path.dart' as path;

class PetProfilesController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  PetServices petServices = PetServices();
  GlobalKey<FormState> petAdditionKey = GlobalKey<FormState>();
  GlobalKey<FormState> petEditKey = GlobalKey<FormState>();
  GlobalKey<FormState> petHistoryAdditionKey = GlobalKey<FormState>();

  RxList<PetProfile> petProfiles = RxList<PetProfile>();

  RxList<PetHistory> petHistory = RxList<PetHistory>();

  List<PetCategory> petCategories = [];

  var selectedPetCategory = Rx<PetCategory?>(null);

  final ImagePicker picker = ImagePicker();
  var selectedImagePath = ''.obs;
  var selectedImageBytes = Rx<Uint8List?>(null);

  TextEditingController petNameController = TextEditingController();
  TextEditingController petAgeController = TextEditingController();

  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getAllPetCategories();
    getAllPetProfiles();
  }

  void deletePetProfileByPetId(int petId) async {
    try {
      await petServices.deleteByPetId(petId).then((value) {
        CustomSnackbar.successSnackbar(
          context: Get.context,
          title: 'Delete Successful',
          message: value,
        );
        getAllPetProfiles();
        update();
      }).onError((error, stackTrace) {
        CustomSnackbar.errorSnackbar(
          context: Get.context,
          title: 'Error',
          message: error.toString(),
        );
      });
    } catch (e) {
      CustomSnackbar.errorSnackbar(
        context: Get.context,
        title: 'Error',
        message: e.toString(),
      );
    }
  }

  void deleteHistoryById(int historyId, int petId) async {
    try {
      await petServices.deleteHistoryById(historyId).then((value) {
        CustomSnackbar.successSnackbar(
          context: Get.context,
          title: 'Delete Successful',
          message: value,
        );
        Get.snackbar(
          "Success",
          value,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        getPetHistory(petId);
        getAllPetProfiles();
        update();
        Get.back();
        Get.find<MainController>();
        disposeControllers();
      }).onError((error, stackTrace) {
        CustomSnackbar.errorSnackbar(
          context: Get.context,
          title: 'Error',
          message: error.toString(),
        );
      });
    } catch (e) {
      CustomSnackbar.errorSnackbar(
        context: Get.context,
        title: 'Error',
        message: e.toString(),
      );
    }
  }

  void showDeletePetProfileDialog(int petId, String petName) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Delete pet profile',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
        content: Container(
          width: Get.width * 0.5,
          height: Get.width * 0.4,
          child: Column(
            children: [
              Text(
                "Are you sure you want to delete the profile for $petName?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                "On doing so all the records of the pet will be deleted as well",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          CustomButton(
            width: 75,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.5,
            ),
            disableBorder: true,
            label: "Cancel",
            onPressed: () {
              Get.back();
            },
          ),
          CustomButton(
            width: 75,
            label: "Delete",
            disableBorder: true,
            color: Colors.red,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.5,
            ),
            onPressed: () {
              deletePetProfileByPetId(petId);
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  void showDeleteHistoryDialog(int historyId, int petId) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Delete pet history',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
        content: Container(
          width: Get.width * 0.5,
          height: Get.width * 0.2,
          child: Text(
            "Are you sure you want to delete this record?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          CustomButton(
            width: 75,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.5,
            ),
            disableBorder: true,
            label: "Cancel",
            onPressed: () {
              Get.back();
            },
          ),
          CustomButton(
            width: 75,
            label: "Delete",
            disableBorder: true,
            color: Colors.red,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.5,
            ),
            onPressed: () {
              deleteHistoryById(historyId, petId);
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  void getAllPetCategories() async {
    isLoading.value = true;
    try {
      petCategories = await petServices.getAllPetCategories();
      if (petCategories.isNotEmpty) {
        selectedPetCategory.value = petCategories.first;
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  void getAllPetProfiles() async {
    isLoading.value = true;
    try {
      int ownerId = MemoryManagement.getUserId()!;
      petProfiles.value = await petServices.getPetProfilesByOwner(ownerId);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  Future<void> getPetHistory(int petId) async {
    isLoading.value = true;
    try {
      List<PetHistory> historyList = await petServices.getHistoryByPetId(petId);
      petHistory.value = historyList;
      //petHistory.value = await petServices.getHistoryByPetId(petId);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  // Future<List<PetHistory>> getPetHistory(int petId) async {
  //   isLoading.value = true;
  //   List<PetHistory> history = [];
  //   try {
  //     history = await petServices.getHistoryByPetId(petId);
  //     isLoading.value = false;
  //     update();
  //     return history;
  //   } catch (e) {
  //     isLoading.value = false;
  //     debugPrint(e.toString());
  //     update();
  //     return history;
  //   }
  // }

  void disposeControllers() {
    petNameController.clear();
    petAgeController.clear();

    eventNameController.clear();
    eventDescriptionController.clear();
    eventDateController.clear();

    selectedPetCategory.value = petCategories[0];

    selectedImagePath = ''.obs;
    selectedImageBytes.value = null;
  }

  Future<dynamic> createPetProfile() async {
    final String fileName = path.basename(selectedImagePath.value);
    isLoading.value = true;
    if (petAdditionKey.currentState!.validate()) {
      try {
        int? petAge = int.tryParse(petAgeController.text);
        await petServices
            .createProfile(
          petName: petNameController.text,
          petAge: petAge ?? 0,
          fileName: fileName,
          imageBytes: selectedImageBytes.value,
          petCategoryId: selectedPetCategory.value?.petcategoryId ?? 0,
          ownerId: MemoryManagement.getUserId() ?? 0,
        )
            .then((value) {
          // CustomSnackbar.successSnackbar(
          //   context: Get.context,
          //   title: 'Success',
          //   message: value,
          // );
          Get.snackbar(
            "Success",
            value,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
          getAllPetProfiles();
          update();
          Get.back();
          Get.find<MainController>();
          disposeControllers();
        }).onError((error, stackTrace) {
          CustomSnackbar.errorSnackbar(
            context: Get.context,
            title: 'Error',
            message: error.toString(),
          );
          update();
        });
      } catch (e) {
        CustomSnackbar.errorSnackbar(
          context: Get.context,
          title: "Error",
          message: "Something went wrong...",
        );
      }
    } else {
      CustomSnackbar.errorSnackbar(
        context: Get.context,
        title: "Error",
        message: "Missing values in the formfield",
      );
    }
  }

  Future<dynamic> editPetProfile(int petId) async {
    final String fileName = path.basename(selectedImagePath.value);
    isLoading.value = true;
    try {
      int? petAge = int.tryParse(petAgeController.text);
      await petServices
          .editPetProfile(
        petAge: petAge ?? 0,
        fileName: fileName,
        imageBytes: selectedImageBytes.value,
        petId: petId,
      )
          .then((value) {
        CustomSnackbar.successSnackbar(
          context: Get.context,
          title: 'Success',
          message: value,
        );
        Get.snackbar(
          "Success",
          value,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        getPetHistory(petId);
        getAllPetProfiles();
        update();
        //Get.back();
        Get.find<MainController>();
        disposeControllers();
      }).onError((error, stackTrace) {
        CustomSnackbar.errorSnackbar(
          context: Get.context,
          title: 'Error',
          duration: Duration(seconds: 500),
          message: error.toString(),
        );
        update();
      });
    } catch (e) {
      CustomSnackbar.errorSnackbar(
        context: Get.context,
        title: "Error",
        message: "Something went wrong...",
      );
    }
  }

  void showAddPetDialog() {
    final ImagePicker picker = ImagePicker();
    Get.dialog(
      AlertDialog(
        backgroundColor: Constants.backgroundColor,
        title: const Text(
          'Add Pet',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Form(
            key: petAdditionKey,
            child: ListBody(
              children: <Widget>[
                CustomTextfield(
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                  controller: petNameController,
                  label: 'Pet Name',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                  controller: petAgeController,
                  label: 'Pet Age',
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => selectedImageBytes.value != null
                      ? Image.memory(
                          selectedImageBytes.value!,
                          width: 100,
                          height: 100,
                        )
                      : const Text(
                          "No image selected",
                          textAlign: TextAlign.center,
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  label: 'Pick Image',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  onPressed: () async {
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      selectedImagePath.value = image.name;
                      final Uint8List imageBytes = await image.readAsBytes();
                      selectedImageBytes.value = imageBytes;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Pet Category"),
                Obx(
                  () => DropdownButton<PetCategory>(
                    value: selectedPetCategory.value,
                    onChanged: (PetCategory? newValue) {
                      selectedPetCategory.value = newValue!;
                      update();
                    },
                    items: petCategories.map<DropdownMenuItem<PetCategory>>(
                        (PetCategory value) {
                      return DropdownMenuItem<PetCategory>(
                        value: value,
                        child: Text(value.petcategoryName ?? ""),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          CustomButton(
            width: 75,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            label: "Cancel",
            onPressed: () {
              Get.back();
            },
          ),
          CustomButton(
            width: 75,
            label: "Add",
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            onPressed: () {
              createPetProfile();
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  void showEditPetDialog(PetProfile petProfile) {
    final ImagePicker picker = ImagePicker();
    petAgeController.text = petProfile.petAge.toString();

    Get.dialog(
      AlertDialog(
        backgroundColor: Constants.backgroundColor,
        title: const Text(
          'Edit Pet Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Form(
            key: petEditKey,
            child: ListBody(
              children: <Widget>[
                CustomTextfield(
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                  controller: petAgeController,
                  label: 'Pet Age',
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => selectedImageBytes.value != null
                      ? Image.memory(
                          selectedImageBytes.value!,
                          width: 100,
                          height: 100,
                        )
                      : Image.network(
                          getImage(
                            petProfile.petImage,
                          ),
                          width: 100,
                          height: 100,
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  label: 'Pick another Image',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  onPressed: () async {
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      selectedImagePath.value = image.name;
                      final Uint8List imageBytes = await image.readAsBytes();
                      selectedImageBytes.value = imageBytes;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          CustomButton(
            width: 75,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            label: "Cancel",
            onPressed: () {
              Get.back();
            },
          ),
          CustomButton(
            width: 75,
            label: "Save",
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            onPressed: () {
              editPetProfile(petProfile.petId ?? 0);
              Get.to(() => const PetProfilesView());
            },
          ),
        ],
      ),
    );
  }

  void resetPetHistory() {
    petHistory.clear();
    update();
  }

  Future<dynamic> createPetHistory(int petId) async {
    isLoading.value = true;
    if (petHistoryAdditionKey.currentState!.validate()) {
      try {
        await petServices
            .createPetHistory(
          eventName: eventNameController.text,
          eventDescription: eventDescriptionController.text,
          eventDate: eventDateController.text,
          petId: petId,
        )
            .then((value) {
          CustomSnackbar.successSnackbar(
            context: Get.context,
            title: 'Success',
            message: value,
          );
          Get.snackbar(
            "Success",
            value,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
          getPetHistory(petId);
          getAllPetProfiles();
          update();
          Get.back();
          Get.find<MainController>();
          disposeControllers();
        }).onError((error, stackTrace) {
          CustomSnackbar.errorSnackbar(
            context: Get.context,
            title: 'Error',
            message: error.toString(),
          );
          update();
        });
      } catch (e) {
        CustomSnackbar.errorSnackbar(
          context: Get.context,
          title: "Error",
          message: "Something went wrong...",
        );
      }
    } else {
      CustomSnackbar.errorSnackbar(
        context: Get.context,
        title: "Error",
        message: "Missing values in the formfield",
      );
    }
  }

  void showAddPetHistoryDialog(int petId) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Constants.backgroundColor,
        title: const Text(
          'Add Pet History',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Form(
            key: petHistoryAdditionKey,
            child: ListBody(
              children: <Widget>[
                CustomTextfield(
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                  controller: eventNameController,
                  label: 'Event Name',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                  controller: eventDescriptionController,
                  label: 'Event Description',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                  isDate: true,
                  controller: eventDateController,
                  label: 'Event Date',
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          CustomButton(
            width: 75,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            label: "Cancel",
            onPressed: () {
              disposeControllers();
              Get.back();
            },
          ),
          CustomButton(
            width: 75,
            label: "Add",
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            onPressed: () {
              createPetHistory(petId);
              Get.back();
            },
          ),
        ],
      ),
    );
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
