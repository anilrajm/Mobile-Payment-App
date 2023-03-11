// To parse this JSON data, do
//
//     final businessType = businessTypeFromJson(jsonString);

import 'dart:convert';

MasterData masterDataFromJson(String str) => MasterData.fromJson(json.decode(str));


class MasterData {
  MasterData({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory MasterData.fromJson(Map<String, dynamic> json) => MasterData(
    status: json["status"],
    message: json["message"],
    data:json['data']!=null? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))):[],
  );


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

}
