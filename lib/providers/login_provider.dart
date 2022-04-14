import 'package:flutter/material.dart';
import 'package:medic/api/api_call.dart';
import 'package:medic/api/api_client.dart';
import 'package:medic/constants/urls.dart';

class LoginProvider extends ChangeNotifier {
  loginUser({
    required String username,
    required String password,
  }) async {
    try {
      final map = {"username": username, "password": password};

      APIClient.token = await APICall().postRequestWithoutToken(loginUrl, map);
      notifyListeners();
    } catch (ex) {
      rethrow;
    }
  }
}
