// To parse this JSON data, do
//
//     final medicalStaff = medicalStaffFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<MedicalStaff> medicalStaffFromJson(String str) => List<MedicalStaff>.from(
    json.decode(str).map((x) => MedicalStaff.fromJson(x)));

String medicalStaffToJson(List<MedicalStaff> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MedicalStaff {
  MedicalStaff({
    required this.id,
    required this.fullName,
    required this.post,
    required this.qualification,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.medicalStaffCategoryId,
  });

  final int id;
  final String fullName;
  final String post;
  final String qualification;
  final String phoneNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int medicalStaffCategoryId;

  factory MedicalStaff.fromJson(Map<String, dynamic> json) => MedicalStaff(
        id: json["id"],
        fullName: json["fullName"],
        post: json["post"],
        qualification: json["qualification"],
        phoneNumber: json["phoneNumber"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        medicalStaffCategoryId: json["MedicalStaffCategoryId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "post": post,
        "qualification": qualification,
        "phoneNumber": phoneNumber,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "MedicalStaffCategoryId": medicalStaffCategoryId,
      };
}
