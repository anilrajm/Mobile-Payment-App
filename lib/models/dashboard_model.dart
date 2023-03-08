import 'dart:convert';
Dashboard dashboardFromJson(String str) => Dashboard.fromJson(json.decode(str));

class Dashboard {
  Dashboard({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );


}

class Data {
  Data({
    required this.totalPurchase,
    required this.totalSuccess,
    required this.totalPending,
    required this.walletBalance,
  });

  String totalPurchase;
  String totalSuccess;
  String totalPending;
  String walletBalance;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalPurchase: json["total_purchase"],
    totalSuccess: json["total_success"],
    totalPending: json["total_pending"],
    walletBalance: json["wallet_balance"],
  );


}

