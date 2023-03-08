import 'dart:convert';

GetOperatorList getOperatorListFromJson(String str) => GetOperatorList.fromJson(json.decode(str));

class GetOperatorList {
  GetOperatorList({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory GetOperatorList.fromJson(Map<String, dynamic> json) => GetOperatorList(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );
}

class Datum {
  Datum({
    required this.opcode,
    required this.opname,
    required this.logo,
    required this.enabled,
    required this.validation,
  });

  String opcode;
  String opname;
  String logo;
  bool enabled;
  Validation validation;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    opcode: json["opcode"],
    opname: json["opname"],
    logo: json["logo"],
    enabled: json["enabled"],
    validation: Validation.fromJson(json["validation"]),
  );}

class Validation {
  Validation({
    required this.fieldValidation,
    required this.amountValidation,
    required this.minLen,
    required this.maxLen,
    required this.minAmt,
    required this.maxAmt,
  });

  bool fieldValidation;
  bool amountValidation;
  String minLen;
  String maxLen;
  String minAmt;
  String maxAmt;

  factory Validation.fromJson(Map<String, dynamic> json) => Validation(
    fieldValidation: json["field_validation"],
    amountValidation: json["amount_validation"],
    minLen: json["min_len"],
    maxLen: json["max_len"],
    minAmt: json["min_amt"],
    maxAmt: json["max_amt"],
  );}
