import 'package:dio/dio.dart';
import 'package:happytails/app/data/models/order.dart';
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
  }) async {
    try {
      String endPoint = '/create-payment';
      Response response = await dioJson.post(
        endPoint,
        data: {
          "userId": userId,
          "orderId": orderId,
          "grandTotal": grandTotal,
          "token": token
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
}
