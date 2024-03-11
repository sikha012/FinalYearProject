import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/data/models/product.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final count = 0.obs;
  final RxList<Product> products = RxList<Product>();

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  void getProducts() async {
    try {
      var url = '$baseUrlLink/product';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);

      var result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        debugPrint(result.toString());
        // Parse and store the products
        products.assignAll(result
            .map<Product>((product) => Product.fromJson(product))
            .toList());

        Get.snackbar(
          'Success',
          'All Products fetched successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
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
