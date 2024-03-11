// To parse this JSON data, do
//
//     final productCategory = productCategoryFromJson(jsonString);

import 'dart:convert';

ProductCategory productCategoryFromJson(String str) =>
    ProductCategory.fromJson(json.decode(str));

String productCategoryToJson(ProductCategory data) =>
    json.encode(data.toJson());

class ProductCategory {
  final int? productcategoryId;
  final String? productcategoryName;

  ProductCategory({
    this.productcategoryId,
    this.productcategoryName,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        productcategoryId: json["productcategory_id"],
        productcategoryName: json["productcategory_name"],
      );

  Map<String, dynamic> toJson() => {
        "productcategory_id": productcategoryId,
        "productcategory_name": productcategoryName,
      };
}
