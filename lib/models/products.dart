import 'dart:typed_data';

class Products {
  late final int id;
  late final String title;
  late final String description;
  late final int price;
  late final Photo image;
  late int quantity;
  late int selectedQuantity;
  late final String createdAt;
  late final String updatedAt;
  late final int categoryId;

  Products(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.image,
      required this.quantity,
      required this.selectedQuantity,
      required this.createdAt,
      required this.updatedAt,
      required this.categoryId});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    image = Photo.fromJson(json['image']);
    quantity = json['quantity'];
    selectedQuantity = 0;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    categoryId = json['CategoryId'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['title'] = this.title;
  //   data['description'] = this.description;
  //   data['price'] = this.price;
  //   if (this.image != null) {
  //     data['image'] = this.image!.toJson();
  //   }
  //   data['quantity'] = this.quantity;
  //   data['createdAt'] = this.createdAt;
  //   data['updatedAt'] = this.updatedAt;
  //   data['CategoryId'] = this.categoryId;
  //   return data;
  // }
}

class Photo {
  late final String type;
  late final Uint8List data;

  Photo({required this.type, required this.data});

  Photo.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = Uint8List.fromList(json['data'].cast<int>());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = type;
    data['data'] = this.data;
    return data;
  }
}
