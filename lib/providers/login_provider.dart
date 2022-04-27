import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medic/api/api_call.dart';
import 'package:medic/api/api_client.dart';
import 'package:medic/constants/urls.dart';
import 'package:medic/models/profile.dart';

class LoginProvider extends ChangeNotifier {
  Profile? profile;
  loginUser({
    required String username,
    required String password,
  }) async {
    try {
      final map = {"username": username, "password": password};

      // APIClient.token = await APICall().postRequestWithoutToken(loginUrl, map);
      final res = await APICall().postRequestWithoutToken(loginUrl, map);
      profile = profileFromJson(res);
      APIClient.token = profile!.token;

      notifyListeners();
    } catch (ex) {
      rethrow;
    }
  }
}
