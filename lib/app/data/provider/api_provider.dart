import 'package:dio/dio.dart';
import 'package:initial_app/app/data/models/token.dart';
import 'package:initial_app/app/utils/constants.dart';

class ApiProvider {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrlLink,
      connectTimeout: const Duration(seconds: 7500),
      receiveTimeout: const Duration(seconds: 7500),
      responseType: ResponseType.json,
      contentType: 'application/json',
    ),
  );

  Future<Token> login(Map<String, dynamic> map) async {
    try {
      final response = await _dio.post('/login', data: map);

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
}
