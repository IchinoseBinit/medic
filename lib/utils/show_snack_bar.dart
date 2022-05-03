import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSnackBar(
  BuildContext context,
  String message, {
  Color? color,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      backgroundColor: color ?? Colors.red,
      duration: const Duration(
        seconds: 3,
      ),
    ),
  );
}
