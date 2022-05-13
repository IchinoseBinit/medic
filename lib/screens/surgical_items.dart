import 'package:flutter/material.dart';
import 'package:medic/providers/products_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medic/widgets/product_card.dart';
import 'package:provider/provider.dart';

import '/widgets/curved_body_widget.dart';

class SurgicalItems extends StatelessWidget {
  SurgicalItems({required this.title, Key? key}) : super(key: key);

  final String title;

  // final list = [
  //   "Scissors",
  //   "Bandages",
  //   "Pain Killers",
  //   "Gloves",
  //   "Stethoscope",
  //   "Masks",
  // ];

  @override
  Widget build(BuildContext context) {
    final future =
        Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final list =
                    Provider.of<ProductsProvider>(context, listen: false)
                        .listOfProducts;
                return list.isEmpty
                    ? const Center(
                        child: Text("No Items"),
                      )
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 120.h,
                          crossAxisSpacing: 5.w,
                          childAspectRatio: .5,
                        ),
                        itemBuilder: ((context, index) => ProductCard(
                              product: list[index],
                            )),
                        itemCount: list.length,
                        shrinkWrap: true,
                        primary: false,
                      );
              }),
        ),
      ),
    );
  }
}
