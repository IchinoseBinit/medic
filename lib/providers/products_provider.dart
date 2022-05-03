import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:medic/api/api_call.dart';
import 'package:medic/constants/urls.dart';
import 'package:medic/models/products.dart';
import 'package:collection/collection.dart';

class ProductsProvider extends ChangeNotifier {
  List<Product> listOfProducts = [];
  List<Product> listOfLatestProducts = [];

  fetchProducts() async {
    try {
      if (listOfProducts.isNotEmpty) return;
      final response = await APICall().getRequestWithToken(productsUrl);
      listOfProducts = productFromJson(response);
      print(listOfProducts.first.title);
      notifyListeners();
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  Future<Product> fetchProductById(String id) async {
    try {
      final response = await APICall().getRequestWithToken("$productsUrl/$id");
      return Product.fromJson(jsonDecode(response));
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  fetchLatestProducts() async {
    try {
      if (listOfLatestProducts.isNotEmpty) return;
      final response = await APICall().getRequestWithToken(latestProductsUrl);
      listOfLatestProducts = productFromJson(response);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  updateQuantity(int id, int quantity) {
    getProductById(id)!.selectedQuantity = quantity;
    notifyListeners();
  }

  Product? getProductById(int id) {
    final list = [...listOfLatestProducts, ...listOfProducts];
    return list.firstWhereOrNull((element) => element.id == id);
  }
}
