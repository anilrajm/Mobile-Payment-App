import 'dart:convert';

GetOperatorPlan getOperatorPlanFromJson(String str) => GetOperatorPlan.fromJson(json.decode(str));



class GetOperatorPlan {
  GetOperatorPlan({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory GetOperatorPlan.fromJson(Map<String, dynamic> json) => GetOperatorPlan(
    status: json["status"],
    message: json["message"],
    data: json['data'] != null
        ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
        : [],
  );}

class Datum {
  Datum({
    required this.amount,
    required this.description,
  });

  int amount;
  String description;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    amount: json["amount"],
    description: json["description"],
  );
}
