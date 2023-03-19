import 'dart:convert';

LedgerData ledgerDataFromJson(String str) =>
    LedgerData.fromJson(json.decode(str));

class LedgerData {
  LedgerData({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory LedgerData.fromJson(Map<String, dynamic> json) => LedgerData(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  Datum({
    required this.id,
    required this.txnDate,
    required this.credit,
    required this.debit,
    required this.balance,
    required this.tds,
    required this.serviceTax,
    required this.description,
    required this.paymentId,
  });

  String id;
  DateTime txnDate;
  String credit;
  String debit;
  String balance;
  String tds;
  String serviceTax;
  String description;
  String paymentId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        txnDate: DateTime.parse(json["txn_date"]),
        credit: json["credit"],
        debit: json["debit"],
        balance: json["balance"],
        tds: json["tds"],
        serviceTax: json["serviceTax"],
        description: json["description"],
        paymentId: json["payment_id"],
      );
}
