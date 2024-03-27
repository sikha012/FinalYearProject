// To parse this JSON data, do
//
//     final petProfile = petProfileFromJson(jsonString);

import 'dart:convert';

PetProfile petProfileFromJson(String str) =>
    PetProfile.fromJson(json.decode(str));

String petProfileToJson(PetProfile data) => json.encode(data.toJson());

class PetProfile {
  final int? petId;
  final String? petName;
  final int? petAge;
  final int? petcategoryId;
  final int? ownerId;
  final String? petImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? petcategoryName;
  final int? recordCount;

  PetProfile({
    this.petId,
    this.petName,
    this.petAge,
    this.petcategoryId,
    this.ownerId,
    this.petImage,
    this.createdAt,
    this.updatedAt,
    this.petcategoryName,
    this.recordCount,
  });

  factory PetProfile.fromJson(Map<String, dynamic> json) => PetProfile(
        petId: json["pet_id"],
        petName: json["pet_name"],
        petAge: json["pet_age"],
        petcategoryId: json["petcategory_id"],
        ownerId: json["owner_id"],
        petImage: json["pet_image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        petcategoryName: json["petcategory_name"],
        recordCount: json["record_count"],
      );

  Map<String, dynamic> toJson() => {
        "pet_id": petId,
        "pet_name": petName,
        "pet_age": petAge,
        "petcategory_id": petcategoryId,
        "owner_id": ownerId,
        "pet_image": petImage,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "petcategory_name": petcategoryName,
        "record_count": recordCount,
      };
}
