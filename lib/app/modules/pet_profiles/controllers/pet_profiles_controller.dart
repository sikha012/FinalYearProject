import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  RxList<PetProfile> petProfiles = RxList<PetProfile>();

  List<PetCategory> petCategories = [];

  var selectedPetCategory = Rx<PetCategory?>(null);

  final ImagePicker picker = ImagePicker();
  var selectedImagePath = ''.obs;
  var selectedImageBytes = Rx<Uint8List?>(null);

  TextEditingController petNameController = TextEditingController();
  TextEditingController petAgeController = TextEditingController();
  TextEditingController vaccinationDateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getAllPetCategories();
    getAllPetProfiles();
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

  void disposeControllers() {
    petNameController.clear();
    petAgeController.clear();
    vaccinationDateController.clear();

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
          vaccinationDate: vaccinationDateController.text,
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
                CustomTextfield(
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                  controller: vaccinationDateController,
                  label: 'Vaccination Date',
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
