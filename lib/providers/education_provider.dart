import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:medic/api/api_call.dart';
import 'package:medic/constants/urls.dart';
import 'package:medic/models/education.dart';

class EducationProvider extends ChangeNotifier {
  List<Education> listOfEducation = [];

  fetchEducation() async {
    try {
      final response = await APICall().getRequestWithToken(educationUrl);
      final map = jsonDecode(response);
      for (var e in map) {
        listOfEducation.add(Education.fromMap(e));
      }
    } catch (ex) {
      rethrow;
    }
  }
}
