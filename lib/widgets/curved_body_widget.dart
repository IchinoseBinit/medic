import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/constants/constants.dart';

class CurvedBodyWidget extends StatelessWidget {
  const CurvedBodyWidget({required this.widget, Key? key}) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.h,
        width: 100.w,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
          color: Colors.white,
        ),
        padding: basePadding,
        child: widget);
  }
}
