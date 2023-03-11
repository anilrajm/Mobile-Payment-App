import 'dart:convert';

GetServices getServicesFromJson(String str) => GetServices.fromJson(json.decode(str));



class GetServices {
  GetServices({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory GetServices.fromJson(Map<String, dynamic> json) => GetServices(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );}

class Datum {
  Datum({
    required this.serviceId,
    required this.serviceName,
    required this.active,
  });

  String serviceId;
  String serviceName;
  String active;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    serviceId: json["service_id"],
    serviceName: json["service_name"],
    active: json["active"],
  );
}
