import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medic/constants/image_constant.dart';
import '/widgets/curved_body_widget.dart';

class ListOfMedicines extends StatelessWidget {
  ListOfMedicines({required this.title, Key? key}) : super(key: key);

  final String title;

  final list = [
    "Betardin",
    "Flexon",
    "Paracetamol",
    "Dettol",
    "Brucet",
    "Dcold",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                ImageConstant.medicines,
                width: 170.h,
                height: 300.h,
              ),
              SizedBox(
                height: 8.h,
              ),
              ListView.builder(
                itemBuilder: ((context, index) => ListTile(
                      title: Text(list[index]),
                    )),
                itemCount: list.length,
                shrinkWrap: true,
                primary: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}