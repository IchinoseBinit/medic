import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/constants/constants.dart';
import '/screens/home_screen.dart';
import '/screens/register_screen.dart';
import '/utils/validation_mixin.dart';
import '/widgets/general_alert_dialog.dart';
import '/widgets/general_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  // final bool canCheckBioMetric;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: basePadding,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // Image.asset(
                //   ImageConstants.logo,
                //   width: SizeConfig.width * 40,
                //   height: SizeConfig.height * 25,
                // ),
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
                  title: "Password",
                  isObscure: true,
                  controller: passwordController,
                  textInputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  validate: (value) =>
                      ValidationMixin().validatePassword(value!),
                  onFieldSubmitted: (_) {
                    _submit(context, false);
                  },
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () {
                    _submit(context, false);
                  },
                  child: const Text("Login"),
                ),
                SizedBox(height: 16.h),
                const Text("OR"),
                SizedBox(height: 8.h),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text("Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context, bool isAuthenticated) async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      GeneralAlertDialog().customLoadingDialog(context);
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );

      // Provider.of<UserProvider>(context, listen: false).setUser(map);
      // }
      // Navigator.pop(context);
      // if (isAuthenticated) {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (_) => const HomeScreen(),
      //     ),
      //   );
      // } else {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (_) => FingerPrintAuthScreen(
      //         username: emailController.text,
      //         password: passwordController.text,
      //       ),
      //     ),
      //   );
      // }
    } catch (e) {}
  }
}
