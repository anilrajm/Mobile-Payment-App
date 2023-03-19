import 'dart:convert';

ProcessPayment processPaymentFromJson(String str) => ProcessPayment.fromJson(json.decode(str));



class ProcessPayment {
  ProcessPayment({
    required this.status,
    required this.message,

  });

  String status;
  String message;



  factory ProcessPayment.fromJson(Map<String, dynamic> json) => ProcessPayment(
    status: json["status"],
    message: json["message"],
  );



}
