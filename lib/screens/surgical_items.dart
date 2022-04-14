import 'package:flutter/material.dart';
import 'package:medic/providers/products_provider.dart';
import 'package:medic/screens/product_screen.dart';
import 'package:medic/utils/navigate.dart';
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
                return ListView.builder(
                  itemBuilder: ((context, index) => ListTile(
                        title: Text(list[index].title),
                        onTap: () => navigate(
                          context,
                          ProductScreen(
                            id: list[index].id,
                          ),
                        ),
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
