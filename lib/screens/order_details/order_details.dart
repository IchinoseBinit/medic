import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medic/models/order.dart';
import 'package:medic/models/products.dart';
import 'package:medic/widgets/curved_body_widget.dart';

class OrderDetail extends StatelessWidget {
  OrderDetail({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Order Details"),
        ),
        body: CurvedBodyWidget(
          widget: Material(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverFillRemaining(
                  fillOverscroll: true,
                  hasScrollBody: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8 * 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Material(
                                    borderRadius: BorderRadius.circular(
                                      8,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Icon(
                                        CupertinoIcons.gift_alt,
                                        color: Colors.orangeAccent,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat("yyyy-MM-dd hh:mm a")
                                              .format(order.createdAt),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        const SizedBox(
                                          height: 8 * .5,
                                        ),
                                        Text(
                                          order.id.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                color: Colors.black,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8 * .5,
                              ),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.place,
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    order.address,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // Material(
                      //   color: Theme.of(context).primaryColorDark,
                      //   borderRadius: BorderRadius.circular(
                      //     8 * 2,
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(
                      //       8 * 2,
                      //     ),
                      //     child: Table(
                      //       textDirection: TextDirection.ltr,
                      //       children: [
                      //         customTableRow(context, 'VAT', details['charge']),
                      //         customTableRow(context, 'Shipping Charge',
                      //             details['shipping']),
                      //         customTableRow(
                      //             context, 'Total Amount', details['price']),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      const SizedBox(
                        height: 8,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8 * 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              collapsedIconColor: Colors.black,
                              iconColor: Colors.black,
                              maintainState: true,
                              title: Text(
                                'Your Order',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: productDetailCard(
                                    context,
                                    order.product,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  TableRow customTableRow(BuildContext context, String title, String value) {
    return TableRow(children: [
      Text(
        title,
        style: Theme.of(context).textTheme.bodyText2,
        textScaleFactor: 1.1,
      ),
      Text(
        value,
        textAlign: TextAlign.end,
        style: Theme.of(context).textTheme.bodyText1,
        textScaleFactor: 1.1,
      ),
    ]);
  }

  Widget productDetailCard(BuildContext context, Product product) {
    return ListTile(
      dense: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
        8 * 2,
      )),
      title: Text(
        product.title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(
        'x ${order.quantity}',
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: Colors.orangeAccent,
            ),
      ),
      trailing: Text(
        'Rs. ${product.price * order.quantity}',
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: Colors.orangeAccent,
            ),
      ),
      leading: Material(
        color: Colors.orangeAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(
          8,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              8,
            ),
            child: Image.memory(
              product.image.data,
            ),
          ),
        ),
      ),
    );
  }
}
