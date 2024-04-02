import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/components/customs/custom_button.dart';
import 'package:happytails/app/components/customs/custom_snackbar.dart';
import 'package:happytails/app/data/models/pet_category.dart';
import 'package:happytails/app/data/models/product.dart';
import 'package:happytails/app/data/models/product_category.dart';
import 'package:happytails/app/data/provider/api_provider.dart';
import 'package:happytails/app/data/provider/pet_services.dart';
import 'package:happytails/app/data/provider/seller_services.dart';
import 'package:happytails/app/modules/seller_main/controllers/seller_main_controller.dart';
import 'package:happytails/app/modules/seller_products/views/seller_products_view.dart';
import 'package:happytails/app/utils/memory_management.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class SellerProductsController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  SellerServices sellerServices = SellerServices();
  PetServices petServices = PetServices();
  ApiProvider apiProvider = ApiProvider();
  RxList<Product> products = RxList<Product>();

  GlobalKey<FormState> productUploadKey = GlobalKey<FormState>();

  List<PetCategory> petCategories = [];
  List<ProductCategory> productCategories = [];

  var selectedPetCategory = Rx<PetCategory?>(null);
  var selectedProductCategory = Rx<ProductCategory?>(null);

  final ImagePicker picker = ImagePicker();

  var selectedImagePath = ''.obs;
  var selectedImageBytes = Rx<Uint8List?>(null);

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockQuantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController petCategoryController = TextEditingController();
  final TextEditingController productCategoryController =
      TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getAllProducts();
    getAllPetCategories();
    getAllProductCategories();
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

  void getAllProductCategories() async {
    isLoading.value = true;
    try {
      productCategories = await sellerServices.getAllProductCategories();
      if (productCategories.isNotEmpty) {
        selectedProductCategory.value = productCategories.first;
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  void getAllProducts() async {
    isLoading.value = true;
    try {
      // FullScreenDialogLoader.showDialog();
      int userId = MemoryManagement.getUserId() ?? 0;
      debugPrint(userId.toString());
      await sellerServices.getAllProductsForSeller(userId).then((value) {
        products.value = value;
        update();
        //FullScreenDialogLoader.cancelDialog();
      }).onError((error, stackTrace) {
        //FullScreenDialogLoader.cancelDialog();
        CustomSnackbar.errorSnackbar(
          context: Get.context,
          title: 'Error',
          message: error.toString(),
          duration: Duration(seconds: 60),
        );
      });

      isLoading.value = false;
    } catch (e) {
      //FullScreenDialogLoader.cancelDialog();
      CustomSnackbar.errorSnackbar(
        context: Get.context,
        title: 'Error',
        message: e.toString(),
      );
      isLoading.value = false;
    }
    update();
  }

  void disposeControllers() {
    productNameController.clear();
    priceController.clear();
    stockQuantityController.clear();
    descriptionController.clear();

    selectedPetCategory.value = petCategories[0];
    selectedProductCategory.value = productCategories[0];

    selectedImagePath = ''.obs;
    selectedImageBytes.value = null;
  }

  Future<dynamic> uploadProduct() async {
    final String fileName = path.basename(selectedImagePath.value);
    isLoading.value = true;
    if (productUploadKey.currentState!.validate()) {
      try {
        int? price = int.tryParse(priceController.text);
        int? stockQuantity = int.tryParse(stockQuantityController.text);
        await apiProvider
            .uploadProduct(
          productName: productNameController.text,
          price: price ?? 0,
          stockQuantity: stockQuantity ?? 0,
          description: descriptionController.text,
          fileName: fileName,
          imageBytes: selectedImageBytes.value,
          petCategory: selectedPetCategory.value?.petcategoryId ?? 0,
          productCategory:
              selectedProductCategory.value?.productcategoryId ?? 0,
          seller: MemoryManagement.getUserId() ?? 0,
        )
            .then((value) {
          Get.snackbar(
            "Success",
            value,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
          getAllProducts();
          update();
          Get.back();
          Get.find<SellerMainController>().update();
          isLoading.value = false;
          disposeControllers();
        }).onError((error, stackTrace) {
          Get.snackbar(
            "Error",
            error.toString(),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 500),
            colorText: Colors.white,
          );
          isLoading.value = false;
          update();
        });
      } catch (e) {
        isLoading.value = false;
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

  Future<dynamic> updateProduct(Product product) async {
    try {
      String? fileName;
      Uint8List? imageBytes;

      // If a new image is selected, prepare file name and image bytes
      if (selectedImagePath.value != '') {
        fileName = path.basename(selectedImagePath.value);
        imageBytes = selectedImageBytes.value;
      }

      isLoading.value = true;
      final int? price = int.tryParse(priceController.text);
      final int? stockQuantity = int.tryParse(stockQuantityController.text);
      await apiProvider
          .updateProduct(
        productId: product.productId ?? 0,
        productName: productNameController.text,
        price: price ?? 0,
        stockQuantity: stockQuantity ?? 0,
        description: descriptionController.text,
        fileName: fileName ?? product.productImage?.split('-')[1],
        previousFile: product.productImage?.split('/')[1],
        imageBytes: imageBytes,
        petCategory: selectedPetCategory.value?.petcategoryId ?? 0,
        productCategory: selectedProductCategory.value?.productcategoryId ?? 0,
        seller: MemoryManagement.getUserId() ?? 0,
      )
          .then((value) {
        // Handle success
        Get.snackbar(
          "Success",
          value,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        getAllProducts();
        update();
        Get.back();
        Get.find<SellerMainController>().update();
        isLoading.value = false;
        disposeControllers();
      }).onError((error, stackTrace) {
        // Handle errors
        Get.snackbar(
          "Error",
          error.toString(),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 500),
          colorText: Colors.white,
        );
        isLoading.value = false;
        update();
      });
    } catch (e) {
      isLoading.value = false;
      update();
      debugPrint("Error in updateProduct: $e");
      rethrow;
    }
  }

  Future<dynamic> deleteProduct(Product product) async {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Delete Product'),
        content: SizedBox(
          height: 100,
          child: Column(
            children: [
              Text('Are you sure you want to delete this product?'),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    label: 'Cancel',
                    width: 100,
                    disableBorder: true,
                    labelStyle: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CustomButton(
                    label: 'Delete',
                    color: Colors.red,
                    width: 100,
                    disableBorder: true,
                    labelStyle: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    onPressed: () async {
                      await apiProvider
                          .deleteProductById(productId: product.productId ?? 0)
                          .then((value) {
                        CustomSnackbar.successSnackbar(
                          context: Get.context,
                          title: 'Success',
                          message: value,
                        );
                        getAllProducts();
                        Get.to(() => const SellerProductsView());
                        update();
                      }).onError((error, stackTrace) {
                        CustomSnackbar.errorSnackbar(
                          context: Get.context,
                          title: 'Error',
                          message: error.toString(),
                        );
                        update();
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
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
