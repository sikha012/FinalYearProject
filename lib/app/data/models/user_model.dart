// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(Map<String, dynamic> json) =>
    UserModel.fromJson(json);

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int? userId;
  final String? userName;
  final String? userEmail;
  final String? token;
  final int? isVerified;
  final String? userPassword;
  final String? userContact;
  final String? userLocation;
  final dynamic profileImage;
  final dynamic userType;
  final String? refreshToken;
  final DateTime? refreshTokenExpiry;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    this.userId,
    this.userName,
    this.userEmail,
    this.token,
    this.isVerified,
    this.userPassword,
    this.userContact,
    this.userLocation,
    this.profileImage,
    this.userType,
    this.refreshToken,
    this.refreshTokenExpiry,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["user_id"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        token: json["token"],
        isVerified: json["isVerified"],
        userPassword: json["user_password"],
        userContact: json["user_contact"],
        userLocation: json["user_location"],
        profileImage: json["profile_image"],
        userType: json["user_type"],
        refreshToken: json["refresh_token"],
        refreshTokenExpiry: json["refresh_token_expiry"] == null
            ? null
            : DateTime.parse(json["refresh_token_expiry"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "user_email": userEmail,
        "token": token,
        "isVerified": isVerified,
        "user_password": userPassword,
        "user_contact": userContact,
        "user_location": userLocation,
        "profile_image": profileImage,
        "user_type": userType,
        "refresh_token": refreshToken,
        "refresh_token_expiry": refreshTokenExpiry?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
