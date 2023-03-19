import 'dart:convert';

GetOperatorBill getOperatorBillFromJson(String str) => GetOperatorBill.fromJson(json.decode(str));



class GetOperatorBill {
  GetOperatorBill({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory GetOperatorBill.fromJson(Map<String, dynamic> json) =>
      GetOperatorBill(
        status: json["status"],
        message: json["message"],
        data:json['data'] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : [],
      );

}

class Datum {
  Datum({
    required this.status,
     required this.customerName,
     required this.billDate,
     required this.dueDate,
     required this.billAmount,
  });

  String status;
  String customerName;
  String billDate;
  String dueDate;
  String billAmount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        status: json["status"],
        customerName: json["CustomerName"],
        billDate: json["Billdate"],
        dueDate: json["Duedate"],
        billAmount: json["Billamount"],
      );

}
