import 'package:flutter/material.dart';
import 'package:medic/providers/medical_staff_provider.dart';
import 'package:medic/widgets/shadowed_container.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '/widgets/curved_body_widget.dart';

class ListOfStaffs extends StatelessWidget {
  const ListOfStaffs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list =
        Provider.of<MedicalStaffProvider>(context, listen: false).listOfStaff;
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Staffs"),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: list.isEmpty
              ? const Center(
                  child: Text("No staffs found"),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  itemBuilder: ((context, index) => ShadowedContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildCallEmailRow(
                              context,
                              Icons.person_outlined,
                              list[index].fullName,
                              isHeading: true,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            buildCallEmailRow(
                              context,
                              Icons.work_outline,
                              list[index].post,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            buildCallEmailRow(
                              context,
                              Icons.call_outlined,
                              list[index].phoneNumber,
                              isPhone: true,
                            ),
                          ],
                        ),
                        pad: 16,
                        marginH: 0,
                      )),
                  // ListTile(
                  //       title: Text(list[index].fullName),
                  //     )),
                  itemCount: list.length,
                  shrinkWrap: true,
                  primary: false,
                ),
        ),
      ),
    );
  }

  Widget buildCallEmailRow(
    BuildContext context,
    IconData iconData,
    String text, {
    bool isPhone = false,
    bool isHeading = false,
  }) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse("tel://$text"))) {
          launchUrl(Uri.parse("tel://$text"));
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            size: Theme.of(context).textTheme.headline6!.fontSize,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              text,
              style: isHeading
                  ? Theme.of(context).textTheme.headline6
                  : Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
