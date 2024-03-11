// To parse this JSON data, do
//
//     final seller = sellerFromJson(jsonString);

import 'dart:convert';

Seller sellerFromJson(String str) => Seller.fromJson(json.decode(str));

String sellerToJson(Seller data) => json.encode(data.toJson());

class Seller {
  final int? sellerId;
  final String? sellerName;
  final String? sellerLocation;
  final String? sellerContact;
  final String? sellerEmail;

  Seller({
    this.sellerId,
    this.sellerName,
    this.sellerLocation,
    this.sellerContact,
    this.sellerEmail,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        sellerId: json["seller_id"],
        sellerName: json["seller_name"],
        sellerLocation: json["seller_location"],
        sellerContact: json["seller_contact"],
        sellerEmail: json["seller_email"],
      );

  Map<String, dynamic> toJson() => {
        "seller_id": sellerId,
        "seller_name": sellerName,
        "seller_location": sellerLocation,
        "seller_contact": sellerContact,
        "seller_email": sellerEmail,
      };
}
