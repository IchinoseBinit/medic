import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:medic/api/api_call.dart';
import 'package:medic/constants/urls.dart';
import 'package:medic/models/products.dart';

class ProductsProvider extends ChangeNotifier {
  List<Products> listOfProducts = [];

  fetchProducts() async {
    try {
      if (listOfProducts.isNotEmpty) return;
      final response = await APICall().getRequestWithToken(productsUrl);
      final map = jsonDecode(response);
      for (var e in map) {
        listOfProducts.add(Products.fromJson(e));
      }
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  updateQuantity(int id, int quantity) {
    getProductById(id).selectedQuantity = quantity;
    notifyListeners();
  }

  Products getProductById(int id) {
    return listOfProducts.firstWhere((element) => element.id == id);
  }
}
