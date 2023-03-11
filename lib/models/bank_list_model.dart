import 'dart:convert';

BankList bankListFromJson(String str) => BankList.fromJson(json.decode(str));
class BankList {
  BankList({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory BankList.fromJson(Map<String, dynamic> json) => BankList(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );


}

class Datum {
  Datum({
    required this.userBankId,
    required this.bankId,
    required this.ifscCode,
    required this.accountNumber,
    required this.branchName,
    required this.addDate,
    required this.editDate,
    required this.ipAddress,
    required this.userId,
    required this.bankName,
  });

  String userBankId;
  String bankId;
  String ifscCode;
  String accountNumber;
  String branchName;
  String addDate;
  String editDate;
  String ipAddress;
  String userId;
  String bankName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userBankId: json["user_bank_id"],
    bankId: json["bank_id"],
    ifscCode: json["ifsc_code"],
    accountNumber: json["account_number"],
    branchName: json["branch_name"],
    addDate: json["add_date"],
    editDate: json["edit_date"],
    ipAddress: json["ip_address"],
    userId: json["user_id"],
    bankName: json["bank_name"],
  );


}
