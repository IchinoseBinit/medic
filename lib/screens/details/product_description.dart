import 'package:flutter/material.dart';
import 'package:medic/models/products.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Products product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                maxLines: 2,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 8.h),
              Text(
                "Rs. ${product.price}",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.orangeAccent),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
          ),
          child: Text(
            product.description,
            maxLines: 3,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
