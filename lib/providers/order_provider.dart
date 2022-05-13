import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:medic/api/api_call.dart';
import 'package:medic/constants/urls.dart';
import 'package:medic/models/order.dart';
import 'package:medic/providers/login_provider.dart';
import 'package:medic/providers/products_provider.dart';
import 'package:provider/provider.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> listOfOrders = [];

  fetchOrders(BuildContext context) async {
    try {
      final id = Provider.of<LoginProvider>(context, listen: false).profile!.id;
      final response = await APICall().getRequestWithToken("$orderUrl/$id");
      final list = jsonDecode(response);

      listOfOrders.clear();
      for (var item in list) {
        final productId = item["ProductId"] as int;
        var product = Provider.of<ProductsProvider>(context, listen: false)
            .getProductById(id);

        product ??= await Provider.of<ProductsProvider>(context, listen: false)
            .fetchProductById(productId);
        listOfOrders.add(Order.fromJson(item, product));
      }
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  postOrder(
    BuildContext context, {
    required int productId,
  }) async {
    try {
      final id = Provider.of<LoginProvider>(context, listen: false).profile!.id;
      final quantity = Provider.of<ProductsProvider>(context, listen: false)
          .getProductById(productId)!
          .selectedQuantity;
      final map = {
        "userId": id,
        "ProductId": productId,
        "quantity": quantity,
      };

      final response = await APICall().postRequestWithToken(orderUrl, map);
      log(response);
    } catch (ex) {
      rethrow;
    }
  }
}
