// To parse this JSON data, do
//
//     final findOperator = findOperatorFromJson(jsonString);

import 'dart:convert';

FindOperator findOperatorFromJson(String str) => FindOperator.fromJson(json.decode(str));

class FindOperator {
  FindOperator({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory FindOperator.fromJson(Map<String, dynamic> json) => FindOperator(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );


}

class Data {
  Data({
    required this.opname,
    required this.postpaid,
    required this.opcode,
    required this.opCircle,
  });

  String opname;
  bool postpaid;
  String opcode;
  String opCircle;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    opname: json["opname"],
    postpaid: json["postpaid"],
    opcode: json["opcode"],
    opCircle: json["op_circle"],
  );


}
