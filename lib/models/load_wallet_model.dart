import 'dart:convert';

LoadWalletRequest loadWalletRequestFromJson(String str) =>
    LoadWalletRequest.fromJson(json.decode(str));

class LoadWalletRequest {
  LoadWalletRequest({
    required this.status,
      required this.message,
    this.data,
  });

  String status;
  String message;
  dynamic data;

  factory LoadWalletRequest.fromJson(Map<String, dynamic> json) =>
      LoadWalletRequest(
        status: json["status"],
        message: json["message"],
        data: json["data"] ?? "no data",
      );
}
