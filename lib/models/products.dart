import 'dart:convert';
import 'dart:developer';

import 'dart:typed_data';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.quantity,
    this.selectedQuantity = 1,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryId,
  });

  late final int id;
  late final String title;
  late final String description;
  late final int price;
  late int selectedQuantity;
  late final Photo image;
  late final int quantity;
  late final DateTime createdAt;
  late final DateTime updatedAt;
  late final int categoryId;

  Product.fromJson(Map<String, dynamic> json) {
    log("message");
    id = json["id"];
    title = json["title"];
    description = json["description"];
    price = json["price"];

    image = Photo.fromJson(json["image"]);
    quantity = json["quantity"];
    selectedQuantity = 1;
    createdAt = DateTime.parse(json["createdAt"]);
    updatedAt = DateTime.parse(json["updatedAt"]);
    categoryId = json["CategoryId"] ?? 0;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "image": image.toJson(),
        "quantity": quantity,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "CategoryId": categoryId,
      };
}

class Photo {
  Photo({
    required this.type,
    required this.data,
  });

  late final String type;
  late final Uint8List data;

  Photo.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    data = Uint8List.fromList(
      (json["data"].cast<int>()),
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}
