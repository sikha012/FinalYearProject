import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:happytails/app/data/models/user_model.dart';
import 'package:happytails/app/data/provider/api_provider.dart';

class UserServices extends ApiProvider {
  UserServices() : super();
  Future<UserModel> getUser() async {
    try {
      final response = await dioJson.get('/get-user');
      return userModelFromJson(response.data);
    } on DioException catch (err) {
      return Future.error(err.toString());
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> updateProfile({
    required int userId,
    required String name,
    required String email,
    required String contact,
    required String location,
    required String fileName,
    Uint8List? imageBytes,
  }) async {
    FormData formData = FormData.fromMap({
      "username": name,
      "email": email,
      "contact": contact,
      "location": location,
      "image": imageBytes != null
          ? MultipartFile.fromBytes(imageBytes, filename: fileName)
          : null,
    });

    try {
      String endpoint = '/update-profile/$userId';
      Response response = await dioMultipart.post(endpoint, data: formData);
      if (response.statusCode == 200) {
        var responseData = response.data;
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('message') &&
            responseData['message'] is String) {
          return responseData['message'];
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        // Handle non-200 responses
        return "Error: Server responded with status code ${response.statusCode}";
      }
    } on DioException catch (dioError) {
      if (dioError.response?.statusCode == 401) {
        return Future.error('401: ${dioError.response?.data['message']}');
      } else if (dioError.response?.statusCode == 400) {
        return Future.error('400: ${dioError.response?.data['message']}');
      } else if (dioError.response?.statusCode == 500) {
        return Future.error('Internal Server Error');
      } else {
        return Future.error('An error occurred: ${dioError.message}');
      }
    } catch (e) {
      // Handle any other types of errors
      return "Exception: $e";
    }
  }

  Future<void> updateFCMToken(int userId, String newToken) async {
    try {
      final response = await dioJson.post(
        '/updateFCMtoken/$userId',
        data: {'token': newToken},
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update FCM token');
      }
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        throw Exception(
            'Dio error: ${dioError.response?.data['message'] ?? 'Unknown error'}');
      } else {
        throw Exception('Dio error: ${dioError.message}');
      }
    } catch (e) {
      throw Exception('Error updating FCM token: $e');
    }
  }
}
