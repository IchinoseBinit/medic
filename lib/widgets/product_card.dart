import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medic/models/products.dart';
import 'package:medic/utils/navigate.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/screens/details/details_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    this.category = "todays deals",
  }) : super(key: key);

  final double width, aspectRetio;
  final Products product;
  final String category;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.w,
      child: GestureDetector(
        onTap: () => navigate(
          context,
          ProductDetailsScreen(product: product),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: Container(
                padding: EdgeInsets.all(
                  6.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Hero(
                  tag: '${product.id.toString()} $category',
                  child: Image.memory(
                    product.image.data,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.title,
              // style: const TextStyle(color: Colors.black),
              maxLines: 2,
            ),
            Text(
              "\$${product.price}",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.orangeAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
