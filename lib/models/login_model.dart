import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

class Login {
  Login({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  dynamic data;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    status: json["status"],
    message: json["message"],
    data:json["data"]!=null? Data.fromJson(json["data"]):"NA",
  );


}

class Data {
  Data({
    required this.org,
    required this.user,
    required this.contactDetails,
    required this.wallet,
    required this.general,
    required this.paymentOptions,
    required this.support,
    required this.sessionId,
  });

  Org org;
  User user;
  ContactDetails contactDetails;
  Wallet wallet;
  General general;
  PaymentOptions paymentOptions;
  Support support;
  String sessionId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    org: Org.fromJson(json["org"]),
    user: User.fromJson(json["user"]),
    contactDetails: ContactDetails.fromJson(json["contact_details"]),
    wallet: Wallet.fromJson(json["wallet"]),
    general: General.fromJson(json["general"]),
    paymentOptions: PaymentOptions.fromJson(json["payment_options"]),
    support: Support.fromJson(json["support"]),
    sessionId: json["session_id"],
  );


}

class ContactDetails {
  ContactDetails({
    required this.postalAddress,
    required this.pincode,
  });

  String postalAddress;
  String pincode;

  factory ContactDetails.fromJson(Map<String, dynamic> json) => ContactDetails(
    postalAddress: json["postal_address"],
    pincode: json["pincode"],
  );


}

class General {
  General({
    required this.news,
  });

  String news;

  factory General.fromJson(Map<String, dynamic> json) => General(
    news: json["news"],
  );

}

class Org {
  Org({
    required this.name,
    required this.type,
  });

  String name;
  String type;

  factory Org.fromJson(Map<String, dynamic> json) => Org(
    name: json["name"],
    type: json["type"],
  );


}

class PaymentOptions {
  PaymentOptions({
    required this.upi,
    required this.setAmount,
    required this.upiGateway,
    required this.paytmGateway,
    required this.marchantUpi,
  });

  String upi;
  String setAmount;
  String upiGateway;
  String paytmGateway;
  String marchantUpi;

  factory PaymentOptions.fromJson(Map<String, dynamic> json) => PaymentOptions(
    upi: json["upi"],
    setAmount: json["set_amount"],
    upiGateway: json["upi_gateway"],
    paytmGateway: json["paytm_gateway"],
    marchantUpi: json["marchant_upi"],
  );


}

class Support {
  Support({
    required this.whatsapp,
    required this.email,
  });

  String whatsapp;
  String email;

  factory Support.fromJson(Map<String, dynamic> json) => Support(
    whatsapp: json["whatsapp"],
    email: json["email"],
  );


}

class User {
  User({
    required this.userId,
    required this.username,
    required this.mobileNo,
    required this.emailid,
  });

  String userId;
  String username;
  String mobileNo;
  String emailid;

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["user_id"],
    username: json["username"],
    mobileNo: json["mobile_no"],
    emailid: json["emailid"],
  );


}

class Wallet {
  Wallet({
    required this.balance,
  });

  String balance;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    balance: json["balance"],
  );


}




