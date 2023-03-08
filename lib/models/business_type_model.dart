// To parse this JSON data, do
//
//     final businessType = businessTypeFromJson(jsonString);

import 'dart:convert';

BusinessType businessTypeFromJson(String str) => BusinessType.fromJson(json.decode(str));

String businessTypeToJson(BusinessType data) => json.encode(data.toJson());

class BusinessType {
  BusinessType({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory BusinessType.fromJson(Map<String, dynamic> json) => BusinessType(
    status: json["status"],
    message: json["message"],
    data:json['data']!=null? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.code,
    required this.value,
  });

  String code;
  String value;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    code: json["code"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "value": value,
  };
}
