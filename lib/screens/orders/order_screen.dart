import 'package:flutter/material.dart';
import 'package:medic/models/order.dart';
import 'package:medic/providers/order_provider.dart';
import 'package:medic/widgets/curved_body_widget.dart';
import 'package:provider/provider.dart';

import '/screens/orders/history_card.dart';
import '/utils/scroll_configuration.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orderScreen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final future =
        Provider.of<OrderProvider>(context, listen: false).fetchOrders(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
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
              final list = Provider.of<OrderProvider>(context, listen: false)
                  .listOfOrders;

              return list.isEmpty
                  ? const Center(
                      child: Text("No Orders Found"),
                    )
                  : DefaultTabController(
                      length: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TabBar(
                            labelColor:
                                Theme.of(context).textTheme.bodyText1!.color,
                            indicatorColor: Colors.orangeAccent,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorWeight: 5,
                            onTap: (index) {},
                            tabs: const [
                              Tab(
                                icon: Text(
                                  'Pending',
                                ),
                              ),
                              Tab(
                                icon: Text(
                                  'Accepted',
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ScrollConfiguration(
                              behavior: MyBehavior(),
                              child: TabBarView(
                                children: [
                                  pendingOrders(
                                    context,
                                    list,
                                  ),
                                  completedOrders(
                                    context,
                                    list,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            }),
      ),
    );
  }

  Widget pendingOrders(
    BuildContext context,
    List<Order> list,
  ) {
    return ListView.separated(
      itemBuilder: (context, index) => !list[index].isAccepted
          ? OrderCard(
              order: list[index],
            )
          : const SizedBox.shrink(),
      itemCount: list.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      separatorBuilder: (_, index) => !list[index].isAccepted
          ? const SizedBox(
              height: 8,
            )
          : const SizedBox.shrink(),
    );
  }

  Widget completedOrders(
    BuildContext context,
    List<Order> list,
  ) {
    return ListView.separated(
      itemBuilder: (context, index) => list[index].isAccepted
          ? OrderCard(
              order: list[index],
            )
          : const SizedBox.shrink(),
      itemCount: list.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      separatorBuilder: (_, index) => list[index].isAccepted
          ? const SizedBox(
              height: 8,
            )
          : const SizedBox.shrink(),
    );
  }
}
