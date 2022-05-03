import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medic/models/order.dart';
import '/screens/order_details/order_details.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigate(context),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.product.title,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Purchased on: ${DateFormat("yyyy-MM-dd hh:mm a").format(order.createdAt)}",
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                    ],
                  ),
                  Text(
                    'Rs. ${order.quantity * order.product.price}',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.red,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.place,
                          color: Colors.orangeAccent,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          order.address,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 4.5 * 8,
                    width: 4.5 * 8,
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                        8 * 2,
                      ),
                    ),
                    child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.orangeAccent,
                          size: 24,
                        ),
                        onPressed: () => navigate(context)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderDetail(
          order: order,
        ),
      ),
    );
  }
}
