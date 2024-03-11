import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:happytails/app/data/models/pet_category.dart';
import 'package:happytails/app/data/models/pet_profile.dart';
import 'package:happytails/app/data/provider/api_provider.dart';

class PetServices extends ApiProvider {
  PetServices() : super();

  Future<List<PetCategory>> getAllPetCategories() async {
    try {
      final response = await dioJson.get('/petCategory');
      debugPrint(response.toString());
      debugPrint(response.data.toString());
      return response.data
          .map<PetCategory>((petCategory) => PetCategory.fromJson(petCategory))
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

  Future<String> createProfile({
    required String petName,
    required int petAge,
    required String vaccinationDate,
    required String fileName,
    required Uint8List? imageBytes,
    required int petCategoryId,
    required int ownerId,
  }) async {
    FormData formData = FormData.fromMap({
      "petName": petName,
      "petAge": petAge,
      "vaccinationDate": vaccinationDate,
      "petImage": imageBytes != null
          ? MultipartFile.fromBytes(imageBytes, filename: fileName)
          : null,
      "petCategoryId": petCategoryId,
      "ownerId": ownerId
    });
    try {
      final response = await dioMultipart.post('/petProfile', data: formData);

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

  Future<List<PetProfile>> getPetProfilesByOwner(int ownerId) async {
    try {
      final response = await dioJson.get('/petProfile/owner/$ownerId');
      return response.data
          .map<PetProfile>((petProfile) => PetProfile.fromJson(petProfile))
          .toList();
    } on DioException catch (err) {
      if (err.response?.statusCode == 404) {
        return Future.error(err.response?.data['message']);
      } else if (err.response?.statusCode == 500) {
        return Future.error(err.response?.data['message']);
      } else {
        return Future.error('Error in the code');
      }
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
}
