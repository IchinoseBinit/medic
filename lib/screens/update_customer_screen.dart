import 'package:flutter/material.dart';
import 'package:medic/providers/login_provider.dart';
import 'package:medic/utils/show_snack_bar.dart';
import 'package:medic/utils/validation_mixin.dart';
import 'package:medic/widgets/curved_body_widget.dart';
import 'package:medic/widgets/general_alert_dialog.dart';
import 'package:medic/widgets/general_text_field.dart';
import 'package:provider/provider.dart';

class UpdateCustomerScreen extends StatelessWidget {
  UpdateCustomerScreen({Key? key}) : super(key: key);

  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update your Details"),
      ),
      body: CurvedBodyWidget(
        widget: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GeneralTextField(
                  title: "Full Name",
                  controller: fullNameController,
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validate: (value) =>
                      ValidationMixin().validate(value!, "Full Name"),
                  onFieldSubmitted: (_) {},
                ),
                const SizedBox(
                  height: 16,
                ),
                GeneralTextField(
                  title: "Address",
                  controller: addressController,
                  textInputType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.done,
                  validate: (value) =>
                      ValidationMixin().validate(value!, "Address"),
                  onFieldSubmitted: (_) {
                    submit(context);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () {
                    submit(context);
                  },
                  child: const Text("Update"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        GeneralAlertDialog().customLoadingDialog(context);
        await Provider.of<LoginProvider>(context, listen: false)
            .updateCustomer();
        Navigator.pop(context);
        showSnackBar(context, "Successfully Updated the information",
            color: Colors.black);
      } catch (ex) {
        Navigator.pop(context);
        GeneralAlertDialog().customAlertDialog(context, ex.toString());
      }
    }
  }
}
