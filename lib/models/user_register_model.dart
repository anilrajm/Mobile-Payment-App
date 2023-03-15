// To parse this JSON data, do
//
//     final userRegister = userRegisterFromJson(jsonString);

import 'dart:convert';

UserRegister userRegisterFromJson(String str) => UserRegister.fromJson(json.decode(str));

String userRegisterToJson(UserRegister data) => json.encode(data.toJson());

class UserRegister {
  UserRegister({
    required this.status,
    required this.message,
    this.data,
  });

  String status;
  String message;
  dynamic data;

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
    status: json["status"],
    message: json["message"],
    data: json["data"] ??  'N/A',
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
