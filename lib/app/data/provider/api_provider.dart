import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:happytails/app/data/models/product.dart';
import 'package:happytails/app/data/models/seller.dart';
import 'package:happytails/app/data/models/token.dart';
import 'package:happytails/app/routes/app_pages.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:happytails/app/utils/memory_management.dart';
import 'package:get/get.dart' as getpackage;

class ApiProvider {
  final Dio dioJson = Dio(
    BaseOptions(
      baseUrl: baseUrlLink,
      connectTimeout: const Duration(seconds: 7500),
      receiveTimeout: const Duration(seconds: 7500),
      responseType: ResponseType.json,
      contentType: 'application/json',
    ),
  );
  final Dio dioMultipart = Dio(
    BaseOptions(
      baseUrl: baseUrlLink,
      connectTimeout: const Duration(seconds: 7500),
      receiveTimeout: const Duration(seconds: 7500),
      responseType: ResponseType.json,
      contentType: 'multipart/form-data',
    ),
  );

  ApiProvider() {
    dioJson.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers["Accept"] = 'application/json';
          String? accessToken = MemoryManagement.getAccessToken();
          options.headers["Authorization"] = 'Bearer $accessToken';
          return handler.next(options);
        },
        onError: ((error, handler) async {
          if (error.response?.statusCode == 403) {
            final newAccessToken = await refreshToken();
            if (newAccessToken != null) {
              dioJson.options.headers["Authorization"] =
                  'Bearer $newAccessToken';
              return handler.resolve(await dioJson.fetch(error.requestOptions));
            }
          }
          return handler.next(error);
        }),
      ),
    );
    dioMultipart.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers["Accept"] = 'mulipart/form-data';
          String? accessToken = MemoryManagement.getAccessToken();
          options.headers["Authorization"] = 'Bearer $accessToken';
          return handler.next(options);
        },
        onError: ((error, handler) async {
          if (error.response?.statusCode == 403) {
            final newAccessToken = await refreshToken();
            if (newAccessToken != null) {
              dioMultipart.options.headers["Authorization"] =
                  'Bearer $newAccessToken';
              return handler
                  .resolve(await dioMultipart.fetch(error.requestOptions));
            }
          }
          return handler.next(error);
        }),
      ),
    );
    dioJson.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  Future<String?> refreshToken() async {
    try {
      final refreshToken = MemoryManagement.getRefreshToken();
      final response = await dioJson.post(
        '/refresh-token',
        data: {
          'refreshToken': refreshToken,
        },
      );
      final newAccessToken = response.data['accessToken'];
      MemoryManagement.setAccessToken(newAccessToken);
      return newAccessToken;
    } catch (e) {
      MemoryManagement.removeAll();
      getpackage.Get.offAllNamed(Routes.SIGN_IN);
    }
    return null;
  }

  Future<Token> login(Map<String, dynamic> map) async {
    try {
      final response = await dioJson.post('/login', data: map);

      return tokenFromJson(response.toString());
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        return Future.error('Email not found!');
      } else if (err.response?.statusCode == 400) {
        return Future.error('Some error in the server');
      } else if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else {
        return Future.error('Error in the code');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await dioJson.get('/product');
      debugPrint(response.toString());
      debugPrint(response.data.toString());
      return response.data
          .map<Product>((product) => Product.fromJson(product))
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

  Future<List<Product>> getFilteredProducts({
    int? productCategoryId,
    int? petCategoryId,
    double? minPrice,
    double? maxPrice,
    String? productName,
  }) async {
    final Map<String, dynamic> queryParameters = {};

    if (productCategoryId != null) {
      queryParameters['productCategoryId'] = productCategoryId.toString();
    }
    if (petCategoryId != null) {
      queryParameters['petCategoryId'] = petCategoryId.toString();
    }
    if (minPrice != null) {
      queryParameters['minPrice'] = minPrice.toString();
    }
    if (maxPrice != null) {
      queryParameters['maxPrice'] = maxPrice.toString();
    }
    if (productName != null && productName.isNotEmpty) {
      queryParameters['productName'] = productName;
    }

    try {
      final response = await dioJson.post(
        '/product/filter',
        data: queryParameters,
      );
      List<Product> products = List<Product>.from(
          response.data.map((model) => Product.fromJson(model)));
      return products;
    } on DioException catch (err) {
      if (err.response?.statusCode == 500) {
        throw Exception('Internal Server Error');
      } else {
        throw Exception('Error in the code');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Seller>> getAllSellers() async {
    try {
      final response = await dioJson.get('/productSeller');
      debugPrint(response.toString());
      debugPrint(response.data.toString());
      return response.data
          .map<Seller>((seller) => Seller.fromJson(seller))
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

  Future<String> uploadProduct({
    required String productName,
    required int price,
    required int stockQuantity,
    required String description,
    required String fileName,
    required Uint8List? imageBytes,
    required int petCategory,
    required int productCategory,
    required int seller,
  }) async {
    FormData formData = FormData.fromMap({
      "name": productName,
      "price": price,
      "stockQuantity": stockQuantity,
      "description": description,
      "image": imageBytes != null
          ? MultipartFile.fromBytes(imageBytes, filename: fileName)
          : null,
      "petCategoryId": petCategory,
      "productCategoryId": productCategory,
      "productSellerId": seller,
    });

    try {
      final response = await dioMultipart.post('/product', data: formData);
      debugPrint(response.toString());
      if (response.statusCode == 201) {
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

  Future<String> updateProduct({
    required int productId,
    required String productName,
    required int price,
    required int stockQuantity,
    required String description,
    String? previousFile,
    String? fileName,
    Uint8List? imageBytes,
    required int petCategory,
    required int productCategory,
    required int seller,
  }) async {
    FormData formData = FormData.fromMap({
      "name": productName,
      "price": price,
      "stockQuantity": stockQuantity,
      "description": description,
      "petCategoryId": petCategory,
      "productCategoryId": productCategory,
      "productSellerId": seller,
      "previousFile": previousFile,
      "image": imageBytes != null
          ? MultipartFile.fromBytes(imageBytes, filename: fileName)
          : null,
    });

    try {
      final response = await dioMultipart.put(
        '/product/$productId',
        data: formData,
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

  Future<String> deleteProductById({
    required int productId,
  }) async {
    try {
      Response response = await dioJson.delete('/product/$productId');
      var responseData = response.data;
      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('message') &&
          responseData['message'] is String) {
        return responseData['message'];
      } else {
        return "Error: Server responded with status code ${response.statusCode}";
      }
    } on DioException catch (dioError) {
      if (dioError.response?.statusCode == 500) {
        return Future.error(dioError.response?.data['message']);
      } else if (dioError.response?.statusCode == 404) {
        return Future.error(dioError.response?.data['message']);
      } else {
        return Future.error("Dio Exception: ${dioError.toString()}");
      }
    } catch (e) {
      return "Exception: $e";
    }
  }
}
