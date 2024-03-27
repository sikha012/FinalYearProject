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
      debugPrint(response.toString());
      debugPrint(response.data.toString());
      List<Product> sellerProducts = (response.data as List)
          .map((product) => Product.fromJson(product))
          .toList();
      return sellerProducts;
      // return response.data
      //     .map<Product>((product) => Product.fromJson(product))
      //     .toList();
    } on DioException catch (err) {
      if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else {
        return Future.error('Error in the code');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<ProductCategory>> getAllProductCategories() async {
    try {
      final response = await dioJson.get('/productCategory');
      debugPrint(response.toString());
      debugPrint(response.data.toString());
      return response.data
          .map<ProductCategory>(
              (productCategory) => ProductCategory.fromJson(productCategory))
          .toList();
    } on DioException catch (err) {
      if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else {
        return Future.error('Error in the code');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
