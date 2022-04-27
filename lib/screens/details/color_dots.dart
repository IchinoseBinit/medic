import 'package:flutter/material.dart';

import '/models/products.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorDots extends StatelessWidget {
  const ColorDots({
    Key? key,
    required this.product,
    required this.quantity,
    required this.incrementChange,
    required this.decrementChange,
  }) : super(key: key);

  final Product product;
  final int quantity;
  final Function incrementChange;
  final Function decrementChange;

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    int selectedColor = 3;
    return Padding(
      padding: EdgeInsets.only(
        left: 20.h,
        right: 20.h,
        bottom: 12.h,
      ),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                decrementChange();
              },
              icon: Icon(
                Icons.remove_circle,
                size: 32,
                color: Theme.of(context).primaryColor,
              )),
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            radius: 20.r,
            child: Text(
              quantity.toString(),
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          IconButton(
            onPressed: () {
              incrementChange();
            },
            icon: Icon(
              Icons.add_circle,
              size: 32,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
