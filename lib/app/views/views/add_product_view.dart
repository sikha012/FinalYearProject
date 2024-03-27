import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happytails/app/components/customs/custom_button.dart';
import 'package:happytails/app/components/customs/custom_textfield.dart';
import 'package:happytails/app/data/models/pet_category.dart';
import 'package:happytails/app/data/models/product_category.dart';
import 'package:happytails/app/modules/seller_products/controllers/seller_products_controller.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class AddProductView extends GetView<SellerProductsController> {
  const AddProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<SellerProductsController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new product'),
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: SingleChildScrollView(
          child: Form(
            key: controller.productUploadKey,
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                CustomTextfield(
                  controller: controller.productNameController,
                  label: 'Product Name',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextfield(
                  controller: controller.priceController,
                  label: 'Price',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextfield(
                  controller: controller.stockQuantityController,
                  label: 'Stock Quantity',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextfield(
                  controller: controller.descriptionController,
                  label: 'Description',
                ),
                const SizedBox(
                  height: 15,
                ),
                Obx(
                  () => controller.selectedImageBytes.value != null
                      ? Image.memory(
                          controller.selectedImageBytes.value!,
                          width: 100,
                          height: 100,
                        )
                      : const Text(
                          "Select and Image",
                          textAlign: TextAlign.center,
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  label: 'Pick Image',
                  width: 100,
                  labelStyle: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  disableBorder: true,
                  onPressed: () async {
                    final XFile? image = await controller.picker
                        .pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      controller.selectedImagePath.value = image.name;
                      final Uint8List imageBytes = await image.readAsBytes();
                      controller.selectedImageBytes.value = imageBytes;
                    }
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text("Pet Category"),
                Obx(
                  () => DropdownButton<PetCategory>(
                    value: controller.selectedPetCategory.value,
                    onChanged: (PetCategory? newValue) {
                      controller.selectedPetCategory.value = newValue!;
                      controller.update();
                    },
                    items: controller.petCategories
                        .map<DropdownMenuItem<PetCategory>>(
                            (PetCategory value) {
                      return DropdownMenuItem<PetCategory>(
                        value: value,
                        child: Text(value.petcategoryName ?? ""),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Product Category"),
                Obx(
                  () => DropdownButton<ProductCategory>(
                    value: controller.selectedProductCategory.value,
                    onChanged: (ProductCategory? newValue) {
                      controller.selectedProductCategory.value = newValue!;
                      controller.update();
                    },
                    items: controller.productCategories
                        .map<DropdownMenuItem<ProductCategory>>(
                            (ProductCategory value) {
                      return DropdownMenuItem<ProductCategory>(
                        value: value,
                        child: Text(value.productcategoryName ?? ""),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      width: 150,
                      disableBorder: true,
                      label: "Cancel",
                      labelStyle: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      onPressed: () {
                        Get.back();
                        controller.disposeControllers();
                        Get.back();
                      },
                    ),
                    SizedBox(
                      width: Get.width * 0.1,
                    ),
                    CustomButton(
                      label: "Add",
                      width: 150,
                      disableBorder: true,
                      labelStyle: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      onPressed: () {
                        controller.uploadProduct();
                        Get.back();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
