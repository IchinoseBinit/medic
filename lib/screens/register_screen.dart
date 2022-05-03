import 'package:flutter/material.dart';
import 'package:medic/providers/register_provider.dart';
import 'package:provider/provider.dart';
import '/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/utils/validation_mixin.dart';
import '/widgets/general_alert_dialog.dart';
import '/widgets/general_text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: basePadding,
        child: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 8.h,
              ),
              GeneralTextField(
                title: "Email",
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validate: (value) => ValidationMixin().validateEmail(value!),
                onFieldSubmitted: (_) {},
              ),
              SizedBox(
                height: 16.h,
              ),
              GeneralTextField(
                title: "Username",
                controller: usernameController,
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validate: (value) =>
                    ValidationMixin().validate(value!, "Username"),
                onFieldSubmitted: (_) {},
              ),
              SizedBox(
                height: 16.h,
              ),
              GeneralTextField(
                title: "Password",
                isObscure: true,
                controller: passwordController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                validate: (value) => ValidationMixin().validatePassword(value!),
                onFieldSubmitted: (_) {},
              ),
              SizedBox(height: 16.h),
              GeneralTextField(
                title: "Confirm Password",
                isObscure: true,
                controller: confirmPasswordController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                validate: (value) => ValidationMixin().validatePassword(
                    passwordController.text,
                    isConfirmPassword: true,
                    confirmValue: value!),
                onFieldSubmitted: (_) {
                  submit(context);
                },
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () async {
                  await submit(context);
                },
                child: Text("Register"),
              ),
            ],
          ),
        )),
      ),
    );
  }

  submit(context) async {
    final dialog = GeneralAlertDialog();
    try {
      if (formKey.currentState!.validate()) {
        dialog.customLoadingDialog(context);
        await Provider.of<RegisterProvider>(context, listen: false)
            .registerUser(
          context,
          email: emailController.text,
          username: usernameController.text,
          password: passwordController.text,
        );
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } catch (ex) {
      Navigator.pop(context);
      dialog.customAlertDialog(context, ex.toString());
    }
  }
}
