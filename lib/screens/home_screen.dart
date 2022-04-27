import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medic/providers/login_provider.dart';
import 'package:medic/providers/products_provider.dart';
import 'package:medic/screens/list_of_medicines.dart';
import 'package:medic/screens/surgical_items.dart';
import 'package:medic/widgets/product_card.dart';
import 'package:provider/provider.dart';
import '/utils/navigate.dart';
import '/widgets/curved_body_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<LoginProvider>(context, listen: false).profile;
    final future =
        Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
    // final future =
    //     Provider.of<RoomProvider>(context, listen: false).fetchRoom(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Home!"),
      ),
      drawer: Drawer(
          child: Column(
        children: [
          // Consumer<UserProvider>(builder: (_, data, __) {
          //   // data.
          //   return
          UserAccountsDrawerHeader(
            accountName: Text(data?.username ?? "No Name"),
            accountEmail: Text(
              data?.email ?? "No Email",
            ),
          ),

          buildListTile(
            context,
            label: "List of Medicines",
            widget: ListOfMedicines(
              title: "List of Medicines",
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          buildListTile(
            context,
            label: "Items",
            widget: SurgicalItems(
              title: "Items",
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
        ],
      )),
      body: CurvedBodyWidget(
        widget: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final list = Provider.of<ProductsProvider>(context, listen: false)
                .listOfProducts;
            return list.isEmpty
                ? const Center(
                    child: Text("No products"),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Latest products",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => ProductCard(
                            product: list[index],
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                          itemCount: list.length,
                          shrinkWrap: true,
                          primary: false,
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  Widget buildListTile(
    BuildContext context, {
    required String label,
    required Widget widget,
  }) {
    return ListTile(
      title: Text(label),
      trailing: const Icon(
        Icons.arrow_right_outlined,
      ),
      onTap: () => navigate(context, widget),
    );
  }
}
