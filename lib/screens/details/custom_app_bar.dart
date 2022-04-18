import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  // final double rating;

  // const CustomAppBar({Key? key, required this.rating}) : super(key: key);
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.h,
          vertical: 8.h,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              foregroundColor: Theme.of(context).textTheme.headline6!.color,
              child: IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            const Spacer(),
            // Container(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: 12.w,
            //     vertical: 8.h,
            //   ),
            //   decoration: BoxDecoration(
            //     color: Theme.of(context).primaryColorDark,
            //     borderRadius: BorderRadius.circular(14),
            //   ),
            //   child: Row(
            //     children: [
            //       Text(
            //         "$rating",
            //         style: Theme.of(context).textTheme.subtitle2!.copyWith(
            //               color: Theme.of(context).textTheme.headline6!.color,
            //             ),
            //       ),
            //       const SizedBox(width: 5),
            //       Icon(
            //         Icons.star_outlined,
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
