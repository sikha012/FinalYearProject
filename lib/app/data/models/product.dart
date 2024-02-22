// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  final int? productId;
  final String? productName;
  final int? productPrice;
  final int? productstockQuantity;
  final String? productDescription;
  final String? productImage;
  final int? petcategoryId;
  final int? productcategoryId;
  final int? sellerId;

  Product({
    this.productId,
    this.productName,
    this.productPrice,
    this.productstockQuantity,
    this.productDescription,
    this.productImage,
    this.petcategoryId,
    this.productcategoryId,
    this.sellerId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        productName: json["product_name"],
        productPrice: json["product_price"],
        productstockQuantity: json["productstock_quantity"],
        productDescription: json["product_description"],
        productImage: json["product_image"],
        petcategoryId: json["petcategory_id"],
        productcategoryId: json["productcategory_id"],
        sellerId: json["seller_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_price": productPrice,
        "productstock_quantity": productstockQuantity,
        "product_description": productDescription,
        "product_image": productImage,
        "petcategory_id": petcategoryId,
        "productcategory_id": productcategoryId,
        "seller_id": sellerId,
      };
}
