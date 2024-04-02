// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromJson(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) =>
    OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) =>
    json.encode(data.toJson());

class OrderDetailModel {
  final int? orderdetailId;
  final int? orderId;
  final int? productId;
  final int? quantity;
  final int? lineTotal;
  String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? userId;
  final DateTime? orderDate;
  final int? totalAmount;
  final String? token;
  final String? userName;
  final String? userContact;
  final String? userLocation;
  final String? productName;
  final String? productImage;

  OrderDetailModel({
    this.orderdetailId,
    this.orderId,
    this.productId,
    this.quantity,
    this.lineTotal,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.orderDate,
    this.totalAmount,
    this.token,
    this.userName,
    this.userContact,
    this.userLocation,
    this.productName,
    this.productImage,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
        orderdetailId: json["orderdetail_id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        lineTotal: json["line_total"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        orderDate: json["order_date"] == null
            ? null
            : DateTime.parse(json["order_date"]),
        totalAmount: json["total_amount"],
        token: json["token"],
        userName: json["user_name"],
        userContact: json["user_contact"],
        userLocation: json["user_location"],
        productName: json["product_name"],
        productImage: json["product_image"],
      );

  Map<String, dynamic> toJson() => {
        "orderdetail_id": orderdetailId,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "line_total": lineTotal,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_id": userId,
        "order_date": orderDate?.toIso8601String(),
        "total_amount": totalAmount,
        "token": token,
        "user_name": userName,
        "user_contact": userContact,
        "user_location": userLocation,
        "product_name": productName,
        "product_image": productImage,
      };
}
