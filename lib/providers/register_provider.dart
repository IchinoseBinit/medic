import 'package:flutter/material.dart';
import 'package:medic/api/api_call.dart';
import 'package:medic/constants/urls.dart';

class RegisterProvider extends ChangeNotifier {
  registerUser(
    BuildContext context, {
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final map = {"email": email, "username": username, "password": password};

      await APICall().postRequestWithoutToken(registerUrl, map);
    } catch (ex) {
      rethrow;
    }
  }
}
