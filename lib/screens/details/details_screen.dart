import 'package:flutter/material.dart';
import 'package:medic/models/products.dart';
import 'package:medic/providers/products_provider.dart';
import 'package:medic/screens/details/color_dots.dart';
import 'package:medic/utils/scroll_configuration.dart';
import 'package:provider/provider.dart';
import '/screens/details/product_description.dart';
import '/screens/details/product_images.dart';
import '/screens/details/top_rounded_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_app_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);
  final Products product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  incrementValueChanged() {
    final product = Provider.of<ProductsProvider>(context, listen: false)
        .getProductById(widget.product.id);
    if (product.selectedQuantity < widget.product.quantity) {
      Provider.of<ProductsProvider>(context, listen: false)
          .updateQuantity(widget.product.id, product.selectedQuantity + 1);
    }
  }

  decrementValueChanged() {
    final product = Provider.of<ProductsProvider>(context, listen: false)
        .getProductById(widget.product.id);
    if (product.selectedQuantity > 0) {
      Provider.of<ProductsProvider>(context, listen: false)
          .updateQuantity(widget.product.id, product.selectedQuantity - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            AppBar().preferredSize.height,
          ),
          // child: CustomAppBar(rating: widget.product.product.),
          child: const CustomAppBar(),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 8.h,
          ),
          child: ElevatedButton(
            onPressed: () {
              // Provider.of<CartProvider>(context, listen: false).addToCart(
              //   widget.product.product,
              //   quantity,
              // );
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //     content: Text(
              //       "Successfully added to the cart",
              //       textAlign: TextAlign.center,
              //     ),
              //     duration: Duration(
              //       seconds: 3,
              //     ),
              //   ),
              // );
            },
            child: const Text("Buy"),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
          ),
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImages(product: widget.product),
                TopRoundedContainer(
                  color: const Color(0xfffcfcfc),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductDescription(
                        product: widget.product,
                      ),
                      Consumer<ProductsProvider>(builder: (_, val, __) {
                        return TopRoundedContainer(
                          color: Theme.of(context).canvasColor,
                          child: ColorDots(
                            product: widget.product,
                            quantity: val
                                .getProductById(widget.product.id)
                                .selectedQuantity,
                            incrementChange: incrementValueChanged,
                            decrementChange: decrementValueChanged,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetailsArguments {
  final Products product;

  ProductDetailsArguments({required this.product});
}
