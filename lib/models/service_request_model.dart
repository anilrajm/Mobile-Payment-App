// To parse this JSON data, do
//
//     final serviceRequest = serviceRequestFromJson(jsonString);

import 'dart:convert';

ServiceRequest serviceRequestFromJson(String str) => ServiceRequest.fromJson(json.decode(str));



class ServiceRequest {
  ServiceRequest({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory ServiceRequest.fromJson(Map<String, dynamic> json) => ServiceRequest(
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

  Map<String, dynamic> toJson() => {
    "code": code,
    "value": value,
  };
}
