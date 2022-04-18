import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medic/models/products.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Products product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 220.w,
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product.id.toString(),
              child: Image.memory(widget.product.image.data),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(1, (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(
          right: 16.h,
        ),
        padding: EdgeInsets.all(8.h),
        height: 48.h,
        width: 48.h,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(.85),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Colors.orangeAccent
                  .withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Center(child: Image.memory(widget.product.image.data)),
      ),
    );
  }
}
