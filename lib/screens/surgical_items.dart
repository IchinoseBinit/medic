import 'package:flutter/material.dart';

import '/widgets/curved_body_widget.dart';

class SurgicalItems extends StatelessWidget {
  SurgicalItems({required this.title, Key? key}) : super(key: key);

  final String title;

  final list = [
    "Scissors",
    "Bandages",
    "Pain Killers",
    "Gloves",
    "Stethoscope",
    "Masks",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: ListView.builder(
            itemBuilder: ((context, index) => ListTile(
                  title: Text(list[index]),
                )),
            itemCount: list.length,
            shrinkWrap: true,
            primary: false,
          ),
        ),
      ),
    );
  }
}
