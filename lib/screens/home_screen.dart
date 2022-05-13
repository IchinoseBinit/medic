import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medic/providers/login_provider.dart';
import 'package:medic/providers/medical_staff_provider.dart';
import 'package:medic/providers/products_provider.dart';
import 'package:medic/screens/list_of_staff_screen.dart';
import 'package:medic/screens/login_screen.dart';
import 'package:medic/screens/orders/order_screen.dart';
import 'package:medic/screens/surgical_items.dart';
import 'package:medic/screens/update_customer_screen.dart';
import 'package:medic/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '/utils/navigate.dart';
import '/widgets/curved_body_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<LoginProvider>(context, listen: false).profile;
    final future =
        Provider.of<ProductsProvider>(context, listen: false).fetchProducts();

    final staffFuture =
        Provider.of<MedicalStaffProvider>(context, listen: false)
            .fetchlistOfStaff();
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
              label: "Update Profile",
              widget: UpdateCustomerScreen(),
            ),
            SizedBox(
              height: 8.h,
            ),
            buildListTile(
              context,
              label: "Your Orders",
              widget: const OrderScreen(),
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
            buildListTile(
              context,
              label: "Staffs",
              widget: const ListOfStaffs(),
            ),
            const Spacer(),
            ListTile(
              title: const Text("Log out"),
              trailing: const Icon(
                Icons.arrow_right_outlined,
              ),
              onTap: () => navigateAndRemoveAll(context, LoginScreen()),
            ),
            SizedBox(
              height: 8.h,
            ),
          ],
        ),
      ),
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
                            width: 20,
                          ),
                          itemCount: list.length,
                          shrinkWrap: true,
                          primary: false,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Emergency Contacts",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          GestureDetector(
                            onTap: () =>
                                navigate(context, const ListOfStaffs()),
                            child: const Text("See More"),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FutureBuilder(
                          future: staffFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final list = Provider.of<MedicalStaffProvider>(
                                    context,
                                    listen: false)
                                .listOfStaff;
                            return ListView.builder(
                              itemBuilder: (context, index) => Card(
                                child: ListTile(
                                  title: Text(list[index].fullName),
                                  subtitle: Text(list[index].post),
                                  trailing: const Icon(
                                    Icons.call_outlined,
                                    size: 24,
                                  ),
                                  leading: const Icon(
                                    Icons.person_outlined,
                                    size: 42,
                                  ),
                                  onTap: () async {
                                    if (await canLaunchUrl(Uri.parse(
                                        "tel://${list[index].phoneNumber}"))) {
                                      launchUrl(Uri.parse(
                                          "tel://${list[index].phoneNumber}"));
                                    }
                                  },
                                ),
                              ),
                              itemCount: list.length > 3 ? 3 : list.length,
                              shrinkWrap: true,
                              primary: false,
                            );
                          })
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
