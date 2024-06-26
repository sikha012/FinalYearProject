import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:happytails/app/data/models/order.dart';
import 'package:happytails/app/data/models/order_detail_model.dart';
import 'package:happytails/app/data/models/order_detail_model.dart';
import 'package:happytails/app/data/provider/api_provider.dart';

class OrderService extends ApiProvider {
  Future<Order> createOrder({
    required int userId,
    required int totalAmount,
    required List cartItems,
  }) async {
    try {
      String endPoint = '/createorder';

      var formData = {
        "userId": userId,
        "totalAmount": totalAmount,
        "cartItems": cartItems,
      };

      Response response = await dioJson.post(
        endPoint,
        data: formData,
      );
      if (response.statusCode == 201) {
        return Order.fromJson(response.data);
      } else {
        throw Exception(
            "Error: Server responded with status code ${response.statusCode}");
      }
    } on DioException catch (dioError) {
      throw Exception("DioException: ${dioError.message}");
    } catch (e) {
      throw Exception("Exception: $e");
    }
  }

  Future<String> createPayment({
    required int userId,
    required int orderId,
    required int grandTotal,
    required String token,
    required List<String> sellerFCMs,
  }) async {
    try {
      String endPoint = '/create-payment';
      Response response = await dioJson.post(
        endPoint,
        data: {
          "userId": userId,
          "orderId": orderId,
          "grandTotal": grandTotal,
          "token": token,
          "sellerFCMs": sellerFCMs,
        },
      );
      if (response.statusCode == 201) {
        var responseData = response.data;
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('message') &&
            responseData['message'] is String) {
          return responseData['message'];
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        return "Error: Server responded with status code ${response.statusCode}";
      }
    } on DioException catch (dioError) {
      return "DioException: ${dioError.message}";
    } catch (e) {
      return "Exception: $e";
    }
  }

  Future<List<OrderDetailModel>> getOrdersToDeliverByUserId(int userId) async {
    try {
      String endpoint = '/orderdetails/seller/$userId';
      final response = await dioJson.get(endpoint);
      debugPrint(response.data.toString());

      List<OrderDetailModel> orders = (response.data as List)
          .map((orderDetailModelJson) =>
              OrderDetailModel.fromJson(orderDetailModelJson))
          .toList();
      return orders;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            "Server error occurred: ${e.response!.statusCode} ${e.response!.data}");
        if (e.response?.statusCode == 404) {
          return Future.error(
              "Orders Details not found for Seller ID: $userId");
        } else if (e.response?.statusCode == 401) {
          return Future.error("Unauthorized access. Please login again.");
        } else {
          return Future.error(
              "Error fetching products: ${e.response!.statusCode}");
        }
      } else {
        debugPrint("Network error: ${e.message}");
        throw Exception(
            "Network error occurred while fetching products. Please check your connection and try again.");
      }
    } catch (e) {
      debugPrint("Unexpected error fetching products: $e");
      throw Exception("Exception: ${e.toString()}");
    }
  }

  Future<List<OrderDetailModel>> getOrdersToReceiveByUserId(int userId) async {
    try {
      String endpoint = '/orderdetails/user/$userId';
      final response = await dioJson.get(endpoint);

      if (response.statusCode == 200) {
        List<OrderDetailModel> orders = (response.data as List)
            .map((orderDetailModelJson) =>
                OrderDetailModel.fromJson(orderDetailModelJson))
            .toList();
        return orders;
      } else {
        debugPrint("Error fetching orders: ${response.statusCode}");
        throw Exception("Server error occurred: ${response.statusCode}");
      }
    } on DioException catch (dioError) {
      debugPrint("DioException occurred: ${dioError.message}");
      throw Exception("DioException: ${dioError.message}");
    } catch (e) {
      debugPrint("Unexpected error occurred: $e");
      throw Exception("Exception: $e");
    }
  }
}
