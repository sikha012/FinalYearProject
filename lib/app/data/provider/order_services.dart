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
}
