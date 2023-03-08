// To parse this JSON data, do
//
//     final pincodeData = pincodeDataFromJson(jsonString);

import 'dart:convert';

PincodeData pincodeDataFromJson(String str) =>
    PincodeData.fromJson(json.decode(str));



class PincodeData {
  PincodeData({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory PincodeData.fromJson(Map<String, dynamic> json) => PincodeData(
        status: json["status"],
        message: json["message"],
        data: json['data'] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : [],
      );
}

class Datum {
  Datum({
    required this.id,
    required this.stateName,
    required this.districtName,
    required this.talukName,
    required this.pincode,
  });

  String id;
  String stateName;
  String districtName;
  String talukName;
  String pincode;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        stateName: json["state_name"],
        districtName: json["district_name"],
        talukName: json["taluk_name"],
        pincode: json["pincode"],
      );
}
