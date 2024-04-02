import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:happytails/app/data/models/product.dart';
import 'package:happytails/app/data/models/product_category.dart';
import 'package:happytails/app/data/provider/api_provider.dart';

class SellerServices extends ApiProvider {
  SellerServices() : super();

  Future<List<Product>> getAllProductsForSeller(int seller) async {
    try {
      final response = await dioJson.get('/product/seller/$seller');
      debugPrint("Response: ${response.toString()}");
      debugPrint("Data: ${response.data.toString()}");
      if (response.data is List) {
        List<Product> sellerProducts = (response.data as List)
            .map((product) => Product.fromJson(product))
            .toList();
        return sellerProducts;
      } else {
        throw Exception('Invalid data format');
      }
    } on DioException catch (err) {
      debugPrint(
          "DioException: ${err.response?.data}, Status Code: ${err.response?.statusCode}");
      return Future.error('DioException: ${err.message}');
    } catch (e) {
      debugPrint("General Exception: $e");
      return Future.error('Exception: $e');
    }
  }

  Future<List<ProductCategory>> getAllProductCategories() async {
    try {
      final response = await dioJson.get('/productCategory');
      debugPrint("Response: ${response.toString()}");
      debugPrint("Data: ${response.data.toString()}");
      if (response.data is List) {
        return response.data
            .map<ProductCategory>(
                (productCategory) => ProductCategory.fromJson(productCategory))
            .toList();
      } else {
        throw Exception('Invalid data format for product categories');
      }
    } on DioException catch (err) {
      debugPrint(
          "DioException: ${err.response?.data}, Status Code: ${err.response?.statusCode}");
      return Future.error('DioException: ${err.message}');
    } catch (e) {
      debugPrint("General Exception: $e");
      return Future.error('Exception: $e');
    }
  }

  Future<String> updateOrderDeliveryStatus({
    required int orderDetailId,
    required String status,
    required String userFCM,
    required String productName,
  }) async {
    try {
      final response = await dioJson.put(
        '/orderdetails/update',
        data: jsonEncode({
          "orderDetailId": orderDetailId,
          "status": status,
          "userFCM": userFCM,
          "productName": productName,
        }),
      );
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        return response.data['message'];
      }
      return response.data['message'];
    } on DioException catch (err) {
      debugPrint("DioException caught: ${err.response?.data}");
      if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else if (err.response?.statusCode == 400) {
        return Future.error('Error code 400');
      } else {
        return Future.error('Error in the code: ${err.message}');
      }
    } catch (e) {
      debugPrint("Exception caught: $e");
      return Future.error(e.toString());
    }
  }
}
