import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/data/models/pet_category.dart';
import 'package:happytails/app/data/models/product.dart';
import 'package:happytails/app/data/provider/api_provider.dart';
import 'package:happytails/app/data/provider/pet_services.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  ApiProvider apiProvider = ApiProvider();
  PetServices petServices = PetServices();

  final RxList<Product> products = RxList<Product>();
  List<PetCategory> petCategories = [];

  var searchResults = RxList<Product>();

  var selectedPetCategory = Rx<PetCategory?>(null);
  var selectedCategory = ''.obs;
  var isSelected = false.obs;
  var selectedCategoryId = 0.obs;

  final RxInt notificationCount = 0.obs;
  PetCategory cat = PetCategory();

  @override
  void onInit() {
    super.onInit();
    petCategories.insert(
      0,
      new PetCategory.fromJson({
        'petcategory_id': 0,
        'petcategory_name': 'All',
      }),
    );
    selectedPetCategory.value = petCategories.first;

    getProducts();
    getAllPetCategories();
  }

  void searchProduct(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }
    isLoading.value = true;

    // Assuming ApiProvider has a method for searching products by name
    var results = await apiProvider.getFilteredProducts(productName: query);
    searchResults.assignAll(results);

    isLoading.value = false;
  }

  void selectCategory(int categoryId) {
    selectedCategoryId.value = categoryId;
    if (categoryId == 0) {
      getProducts(); // Fetch all products if 'All' category is selected
    } else {
      getFilteredProducts(petCategoryId: categoryId);
    }
  }

  void resetNotificationCount() {
    notificationCount.value = 0;
  }

  void getAllPetCategories() async {
    isLoading.value = true;
    try {
      var categories = await petServices.getAllPetCategories();
      for (PetCategory cat in categories) {
        petCategories.add(cat);
      }
      if (petCategories.isNotEmpty) {
        selectedPetCategory.value = petCategories.first;
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  void getProducts() async {
    try {
      var url = '$baseUrlLink/product';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);

      var result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        debugPrint(result.toString());
        products.assignAll(result
            .map<Product>((product) => Product.fromJson(product))
            .toList());
        debugPrint("All products fetched successfully");

        // Get.snackbar(
        //   'Success',
        //   'All Products fetched successfully',
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );
      } else if (response.statusCode == 404) {
        Get.snackbar(
          'Error',
          result['message'],
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      } else if (response.statusCode == 500) {
        Get.snackbar(
          'Error',
          result['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      debugPrint(e.toString());
    }
  }

  void getFilteredProducts({
    int? productCategoryId,
    int? petCategoryId,
    double? minPrice,
    double? maxPrice,
    String? productName,
  }) async {
    isLoading.value = true;
    try {
      if (petCategoryId == null || petCategoryId == 0) {
        getProducts();
        return;
      }
      var filteredProducts = await apiProvider.getFilteredProducts(
        productCategoryId: productCategoryId,
        petCategoryId: petCategoryId,
        minPrice: minPrice,
        maxPrice: maxPrice,
        productName: productName,
      );
      if (filteredProducts.isNotEmpty) {
        products.assignAll(filteredProducts);
        debugPrint("FIltered Products fetched successfully");
        // Get.snackbar(
        //   'Success',
        //   'Filtered Products fetched successfully',
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );
      } else {
        debugPrint("No products with matching category");
        // Get.snackbar(
        //   'Info',
        //   'No products found with the selected filters',
        //   backgroundColor: Colors.blue,
        //   colorText: Colors.white,
        // );
        products.clear();
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong while fetching filtered products',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      debugPrint(e.toString());
    }
    isLoading.value = false;
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
