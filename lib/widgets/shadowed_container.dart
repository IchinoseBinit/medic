import 'package:flutter/material.dart';

class ShadowedContainer extends StatelessWidget {
  final Widget child;
  final String? title;
  final double? marginH;
  final double pad;
  final bool isCenter;
  final double? borderRadius;

  const ShadowedContainer({
    Key? key,
    required this.child,
    this.title,
    this.marginH,
    this.pad = 0,
    this.borderRadius,
    this.isCenter = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isCenter ? Alignment.center : null,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.4),
          width: 0.1,
        ),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        borderRadius: BorderRadius.circular(
          borderRadius ?? 15 * 2,
        ),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: marginH ?? 16,
      ),
      padding: EdgeInsets.all(pad),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 20,
                ),
                child: Text(
                  title.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            if (title != null)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 0.3,
                  color: Color(0xffA5A5A5),
                ),
              ),
            child,
          ],
        ),
      ),
    );
  }
}
