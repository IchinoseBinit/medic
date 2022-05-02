import 'package:flutter/cupertino.dart';
import 'package:medic/api/api_call.dart';
import 'package:medic/constants/urls.dart';
import 'package:medic/models/medical_staff.dart';

class MedicalStaffProvider extends ChangeNotifier {
  List<MedicalStaff> listOfStaff = [];

  fetchlistOfStaff() async {
    try {
      final response = await APICall().getRequestWithToken(medicalStaffUrl);
      listOfStaff = medicalStaffFromJson(response);
    } catch (ex) {
      rethrow;
    }
  }
}
