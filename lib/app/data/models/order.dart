// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  final int? orderId;
  final OrderClass? order;

  Order({
    this.orderId,
    this.order,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["orderId"],
        order:
            json["order"] == null ? null : OrderClass.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "order": order?.toJson(),
      };
}

class OrderClass {
  final int? userId;
  final DateTime? orderDate;
  final int? totalAmount;
  final String? orderStatus;

  OrderClass({
    this.userId,
    this.orderDate,
    this.totalAmount,
    this.orderStatus,
  });

  factory OrderClass.fromJson(Map<String, dynamic> json) => OrderClass(
        userId: json["userId"],
        orderDate: json["orderDate"] == null
            ? null
            : DateTime.parse(json["orderDate"]),
        totalAmount: json["totalAmount"],
        orderStatus: json["orderStatus"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "orderDate": orderDate?.toIso8601String(),
        "totalAmount": totalAmount,
        "orderStatus": orderStatus,
      };
}
