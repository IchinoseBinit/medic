// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'package:medic/models/products.dart';

class Order {
  Order({
    required this.id,
    required this.quantity,
    required this.address,
    required this.isAccepted,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  final int id;
  final int quantity;
  final String address;
  final bool isAccepted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product product;

  factory Order.fromJson(Map<String, dynamic> json, Product product) => Order(
        id: json["id"],
        quantity: json["quantity"],
        address: json["address"],
        isAccepted: json["isAccepted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        product: product,
      );
}
