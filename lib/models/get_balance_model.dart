import 'dart:convert';

GetBalance getBalanceFromJson(String str) => GetBalance.fromJson(json.decode(str));

class GetBalance {
  GetBalance({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory GetBalance.fromJson(Map<String, dynamic> json) => GetBalance(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    required this.walletBalance,
  });

  String walletBalance;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    walletBalance: json["wallet_balance"],
  );

}
