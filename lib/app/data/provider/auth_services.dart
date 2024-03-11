import 'package:dio/dio.dart';
import 'package:happytails/app/data/models/token.dart';
import 'package:happytails/app/data/provider/api_provider.dart';

class AuthService extends ApiProvider {
  Future<Token> signIn(Map<String, dynamic> signInMap) async {
    try {
      final response = await dioJson.post('/login', data: signInMap);
      return tokenFromJson(response.toString());
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        return Future.error(err.response?.data['message']);
      } else if (err.response?.statusCode == 400) {
        return Future.error(err.response?.data['errors'][0]['msg']);
      } else if (err.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else {
        return Future.error('An error occurred: ${err.message}');
      }
    } catch (e) {
      return Future.error('An unexpected error occurred: $e');
    }
  }

  Future<String> signUp(Map<String, dynamic> userInfo) async {
    try {
      final response = await dioJson.post('/register', data: userInfo);

      return response.data['message'];
    } on DioException catch (err) {
      if (err.response?.statusCode == 400) {
        return Future.error(err.response?.data['errors'][0]['msg']);
      } else if (err.response?.statusCode == 409) {
        return Future.error(err.response?.data['message']);
      } else if (err.response?.statusCode == 500) {
        return Future.error(err.response?.data['message']);
      } else {
        return Future.error('An error occurred: ${err.message}');
      }
    } catch (e) {
      return Future.error('An unexpected error occurred: $e');
    }
  }
}
