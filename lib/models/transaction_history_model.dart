import 'dart:convert';

TransactionHistory transactionHistoryFromJson(String str) =>
    TransactionHistory.fromJson(json.decode(str));

class TransactionHistory {
  TransactionHistory({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory TransactionHistory.fromJson(Map<String, dynamic> json) =>
      TransactionHistory(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  Datum({
    required this.id,
    required this.companyName,
    required this.companyId,
    required this.amount,
    required this.balance,
    required this.rechargeDate,
    required this.rechargeStatus,
    required this.mobileNo,
    required this.operatorId,
  });

  String id;
  String companyName;
  String companyId;
  String amount;
  String balance;
  String rechargeDate;
  String rechargeStatus;
  String mobileNo;
  String operatorId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        companyName: json["company_name"],
        companyId: json["company_id"],
        amount: json["amount"],
        balance: json["balance"],
        rechargeDate: json["recharge_date"],
        rechargeStatus: json["recharge_status"],
        mobileNo: json["mobile_no"],
        operatorId: json["operator_id"]??"n/a",
      );
}
