import 'package:dio/dio.dart';
import 'package:happytails/app/data/models/sign_in_response.dart';
import 'package:happytails/app/data/models/sign_up_response.dart';
import 'package:happytails/app/data/provider/api_provider.dart';

class AuthService extends ApiProvider {
  Future<SignInResponse> signIn(Map<String, dynamic> signInMap) async {
    try {
      final response = await dioJson.post('/login', data: signInMap);
      return signInResponseFromJson(response.toString());
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

  Future<SignUpResponse> signUp(Map<String, dynamic> userInfo) async {
    try {
      final response = await dioJson.post('/register', data: userInfo);

      return SignUpResponse.fromJson(response.data);
    } on DioException catch (err) {
      if (err.response?.statusCode == 400) {
        return Future.error(err.response?.data['errors'][0]['message']);
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

  Future<String> resendOTP(String email, String userName) async {
    try {
      final response = await dioJson.post(
        '/resend-otp',
        data: {'email': email, 'username': userName},
      );
      return response.data['message'];
    } on DioException catch (err) {
      if (err.response?.statusCode == 400) {
        return Future.error(err.response?.data['message'] ?? 'Invalid OTP');
      } else if (err.response?.statusCode == 401) {
        // OTP might have expired or is incorrect
        return Future.error(
            err.response?.data['message'] ?? 'OTP Expired or Incorrect');
      } else if (err.response?.statusCode == 500) {
        // Handle server errors
        return Future.error('Internal Server Error');
      } else {
        // Generic error handling
        return Future.error('An error occurred: ${err.message}');
      }
    } catch (e) {
      // Catch any other errors
      return Future.error('An unexpected error occurred: $e');
    }
  }

  Future<String> verifyOTP(String email, String otp, String hash) async {
    try {
      final response = await dioJson.post(
        '/verify-otp',
        data: {'email': email, 'otp': otp, 'hash': hash},
      );
      return response.data['message'];
    } on DioException catch (err) {
      if (err.response?.statusCode == 400) {
        return Future.error(err.response?.data['message'] ?? 'Invalid OTP');
      } else if (err.response?.statusCode == 401) {
        // OTP might have expired or is incorrect
        return Future.error(
            err.response?.data['message'] ?? 'OTP Expired or Incorrect');
      } else if (err.response?.statusCode == 500) {
        // Handle server errors
        return Future.error('Internal Server Error');
      } else {
        // Generic error handling
        return Future.error('An error occurred: ${err.message}');
      }
    } catch (e) {
      // Catch any other errors
      return Future.error('An unexpected error occurred: $e');
    }
  }
}
