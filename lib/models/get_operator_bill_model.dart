import 'dart:convert';

GetOperatorBill getOperatorBillFromJson(String str) =>
    GetOperatorBill.fromJson(json.decode(str));



class GetOperatorBill {
  GetOperatorBill({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory GetOperatorBill.fromJson(Map<String, dynamic> json) =>
      GetOperatorBill(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

}

class Data {
  Data({
    required this.status,
     this.customerName,
     this.billdate,
     this.duedate,
     this.billamount,
  });

  String status;
  String? customerName;
  String? billdate;
  String? duedate;
  String? billamount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        customerName: json["CustomerName"]??"",
        billdate: json["Billdate"]??"",
        duedate: json["Duedate"]??"",
        billamount: json["Billamount"]??"",
      );






  Map<String, dynamic> toJson() => {
        "status": status,
        "CustomerName": customerName,
        "Billdate": billdate,
        "Duedate": duedate,
        "Billamount": billamount,
      };
}
