import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:medic/api/api_call.dart';
import 'package:medic/constants/urls.dart';
import 'package:medic/models/products.dart';
import 'package:medic/providers/login_provider.dart';
import 'package:medic/providers/products_provider.dart';
import 'package:provider/provider.dart';

class OrderProvider extends ChangeNotifier {
  // List<Product> listOfProducts = [];

  // fetchProducts() async {
  //   try {
  //     if (listOfProducts.isNotEmpty) return;
  //     final response = await APICall().getRequestWithToken(productsUrl);
  //     final map = jsonDecode(response);
  //     for (var e in map) {
  //       listOfProducts.add(Product.fromJson(e));
  //     }
  //   } catch (ex) {
  //     log(ex.toString());
  //     rethrow;
  //   }
  // }

  postOrder(
    BuildContext context, {
    required int productId,
  }) async {
    final id = Provider.of<LoginProvider>(context, listen: false).profile!.id;
    final quantity = Provider.of<ProductsProvider>(context, listen: false)
        .getProductById(productId)
        .selectedQuantity;
    final map = {
      "userId": id,
      "ProductId": productId,
      "quantity": quantity,
    };

    final response = await APICall().postRequestWithToken(orderUrl, map);
    log(response);
  }

  // updateQuantity(int id, int quantity) {
  //   getProductById(id).selectedQuantity = quantity;
  //   notifyListeners();
  // }

  // Products getProductById(int id) {
  //   return listOfProducts.firstWhere((element) => element.id == id);
  // }
}
