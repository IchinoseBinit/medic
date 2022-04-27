import 'package:flutter/material.dart';
import 'package:medic/providers/order_provider.dart';
import 'package:medic/providers/products_provider.dart';
import 'package:medic/utils/show_snack_bar.dart';
import 'package:medic/widgets/curved_body_widget.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medic/widgets/general_alert_dialog.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductsProvider>(context).getProductById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: CurvedBodyWidget(
        widget: ListView(
          children: [
            SizedBox(
              height: 170.h,
              child: Image.memory(
                product.image.data,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rs. ${product.price}",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  "Available Quantity: ${product.quantity}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 25.h,
                  width: 25.h,
                  color: Colors.grey.shade200,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (product.selectedQuantity < product.quantity) {
                        Provider.of<ProductsProvider>(context, listen: false)
                            .updateQuantity(id, product.selectedQuantity + 1);
                      }
                    },
                    icon: const Icon(
                      Icons.add_outlined,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  product.selectedQuantity.toString(),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  height: 25.h,
                  width: 25.h,
                  color: Colors.grey.shade200,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (product.selectedQuantity > 0) {
                        Provider.of<ProductsProvider>(context, listen: false)
                            .updateQuantity(id, product.selectedQuantity - 1);
                      }
                    },
                    icon: const Icon(
                      Icons.remove_outlined,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            ElevatedButton(
              onPressed: () async {
                if (product.selectedQuantity == 0) {
                  showSnackBar(context, "Please select your quantity");
                } else {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  GeneralAlertDialog().customLoadingDialog(context);
                  await Provider.of<OrderProvider>(context, listen: false)
                      .postOrder(context, productId: product.id);
                  Navigator.pop(context);
                }
              },
              child: const Text("Buy"),
              style: ElevatedButton.styleFrom(
                // alignment:
                primary: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
