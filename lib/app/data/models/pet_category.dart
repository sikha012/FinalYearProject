// To parse this JSON data, do
//
//     final petCategory = petCategoryFromJson(jsonString);

import 'dart:convert';

PetCategory petCategoryFromJson(String str) =>
    PetCategory.fromJson(json.decode(str));

String petCategoryToJson(PetCategory data) => json.encode(data.toJson());

class PetCategory {
  final int? petcategoryId;
  final String? petcategoryName;

  PetCategory({
    this.petcategoryId,
    this.petcategoryName,
  });

  factory PetCategory.fromJson(Map<String, dynamic> json) => PetCategory(
        petcategoryId: json["petcategory_id"],
        petcategoryName: json["petcategory_name"],
      );

  Map<String, dynamic> toJson() => {
        "petcategory_id": petcategoryId,
        "petcategory_name": petcategoryName,
      };
}
