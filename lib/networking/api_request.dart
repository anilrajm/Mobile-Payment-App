import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:recharge_app_mega/models/bank_list_model.dart';
import 'package:recharge_app_mega/models/dashboard_model.dart';
import 'package:recharge_app_mega/models/find_operator_model.dart';
import 'package:recharge_app_mega/models/get_balance_model.dart';
import 'package:recharge_app_mega/models/get_operator_bill_model.dart';
import 'package:recharge_app_mega/models/get_operator_list_model.dart';
import 'package:recharge_app_mega/models/get_operator_plan_model.dart';
import 'package:recharge_app_mega/models/get_services_model.dart';
import 'package:recharge_app_mega/models/login_model.dart';
import 'package:recharge_app_mega/models/master_data_model.dart';
import 'package:recharge_app_mega/models/pincode_data_model.dart';
import 'package:recharge_app_mega/models/service_request_model.dart';
import 'package:recharge_app_mega/models/transaction_history_model.dart';
import 'package:recharge_app_mega/models/user_register_model.dart';
import 'package:recharge_app_mega/views/views.dart';

class APIManagement {
  Future<Login> loginRequest(
      {required String userName,
      required String password,
      required String deviceId,
      required String location}) async {
    late Login loginModel;

    try {
      var headers = {
        'Authorization': ' 4acb2419-5ea9-437d-8f57-2dea47f7fa33',
        'Cache-Control': ' no-cache',
        'accept': ' application/json',
        'cache-control': ' no-cache',
        'Content-Type': 'application/json',
        'Cookie':
           'ci_session=a%3A5%3A%7Bs%3A10%3A%22session_id%22%3Bs%3A32%3A%222c67663988bb7844ac388060771deb99%22%3Bs%3A10%3A%22ip_address%22%3Bs%3A12%3A%2242.105.159.6%22%3Bs%3A10%3A%22user_agent%22%3Bs%3A21%3A%22PostmanRuntime%2F7.31.1%22%3Bs%3A13%3A%22last_activity%22%3Bi%3A1678992831%3Bs%3A9%3A%22user_data%22%3Bs%3A0%3A%22%22%3B%7Da73a10f20347e9af3cbe8b273fa7b791'
      };
      var request = http.Request(
          'POST', Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndpoint));

      request.body = json.encode({
        "headers": {
          "tenant_code": "mpsl",
          "device_id": deviceId,
          "client_ip": "202.142.83.251",
          "location": location,
          "end_channel_code": "CUSTOMER",
          "stan": "1678994635",
          "run_mode": "REAL",
          "function_code": "DEFAULT",
          "function_sub_code": "DEFAULT",
          "user_id": ""
        },
        "request": {
          "handle_type": "MSISDN",
          "handle_value": userName,
          "auth_type": "MPIN",
          "auth_value": password
        }
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        var jdata=jsonDecode(data);
        print(jdata['status']);
        loginModel = loginFromJson(data);

      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return loginModel;
  }

  Future<Dashboard> dashboardRequest(
      {required String sessionId,
      required String userId,
      required String deviceId,
      required String location}) async {
    late Dashboard dashboardModel;
    try {
      var headers = {
        'Authorization': sessionId,
        'Cache-Control': ' no-cache',
        'accept': ' application/json',
        'cache-control': ' no-cache',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST',
          Uri.parse(ApiConstants.baseUrl + ApiConstants.dashboardEndpoint));
      request.body = json.encode({
        "headers": {
          "tenant_code": "mpsl",
          "device_id": deviceId,
          "client_ip": "202.142.83.251",
          "location": location,
          "end_channel_code": "CUSTOMER",
          "stan": "1675098180",
          "run_mode": "REAL",
          "function_code": "DEFAULT",
          "function_sub_code": "DEFAULT",
          "user_id": userId
        },
        "request": {}
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        dashboardModel = dashboardFromJson(data);
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return dashboardModel;
  }

  Future<GetServices> getServicesRequest(
      {required String sessionId,
      required String userId,
      required String deviceId,
      required location}) async {
    late GetServices getServicesModel;
    try {
      var headers = {
        'Authorization': sessionId,
        'Cache-Control': ' no-cache',
        'accept': ' application/json',
        'cache-control': ' no-cache',
        'Content-Type': 'application/json',
        'Cookie':
            'ci_session=a%3A5%3A%7Bs%3A10%3A%22session_id%22%3Bs%3A32%3A%22365acca0650a8040f07800f377fc7bde%22%3Bs%3A10%3A%22ip_address%22%3Bs%3A13%3A%2242.104.150.27%22%3Bs%3A10%3A%22user_agent%22%3Bs%3A21%3A%22PostmanRuntime%2F7.30.0%22%3Bs%3A13%3A%22last_activity%22%3Bi%3A1675155037%3Bs%3A9%3A%22user_data%22%3Bs%3A0%3A%22%22%3B%7D44a1e71d214c55e777f9ea654bbde519'
      };
      var request = http.Request('POST',
          Uri.parse(ApiConstants.baseUrl + ApiConstants.servicesEndpoint));
      request.body = json.encode({
        "headers": {
          "tenant_code": "mpsl",
          "device_id": deviceId,
          "client_ip": "202.142.83.251",
          "location": location,
          "end_channel_code": "CUSTOMER",
          "stan": "1675162188",
          "run_mode": "REAL",
          "function_code": "DEFAULT",
          "function_sub_code": "DEFAULT",
          "user_id": userId
        },
        "request": {}
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        getServicesModel = getServicesFromJson(data);
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return getServicesModel;
  }

  Future<GetBalance> getBalanceRequest(
      {required String sessionId,
      required String userId,
      required String deviceId,
      required String location}) async {
    late GetBalance getBalanceModel;
    try {
      var headers = {
        'Authorization': sessionId,
        'Cache-Control': ' no-cache',
        'accept': ' application/json',
        'cache-control': ' no-cache',
        'Content-Type': 'application/json',
        'Cookie':
            'ci_session=a%3A5%3A%7Bs%3A10%3A%22session_id%22%3Bs%3A32%3A%2200c023308f45dc6e85a1356b88d7d211%22%3Bs%3A10%3A%22ip_address%22%3Bs%3A13%3A%2242.104.150.27%22%3Bs%3A10%3A%22user_agent%22%3Bs%3A21%3A%22PostmanRuntime%2F7.30.0%22%3Bs%3A13%3A%22last_activity%22%3Bi%3A1675155622%3Bs%3A9%3A%22user_data%22%3Bs%3A0%3A%22%22%3B%7D28278357fd33409c09b3d3767b4d9a42'
      };
      var request = http.Request('POST',
          Uri.parse(ApiConstants.baseUrl + ApiConstants.balanceEndpoint));
      request.body = json.encode({
        "headers": {
          "tenant_code": "mpsl",
          "device_id": deviceId,
          "client_ip": "202.142.83.251",
          "location": location,
          "end_channel_code": "CUSTOMER",
          "stan": "1675163198",
          "run_mode": "REAL",
          "function_code": "DEFAULT",
          "function_sub_code": "DEFAULT",
          "user_id": userId
        },
        "request": {}
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        getBalanceModel = getBalanceFromJson(data);
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return getBalanceModel;
  }

  Future<FindOperator> findOperatorRequest(
      {required String sessionId,
      required String userId,
      required String number,
      required String serviceId,
      required String deviceId,
      required String location}) async {
    late FindOperator findOperatorModel;

    try {
      var headers = {
        'Authorization': sessionId,
        'Cache-Control': ' no-cache',
        'accept': ' application/json',
        'cache-control': ' no-cache',
        'Content-Type': 'application/json',
        'Cookie':
            'ci_session=a%3A5%3A%7Bs%3A10%3A%22session_id%22%3Bs%3A32%3A%22bedb19459695fe59234d2cadead11d61%22%3Bs%3A10%3A%22ip_address%22%3Bs%3A13%3A%2242.104.150.27%22%3Bs%3A10%3A%22user_agent%22%3Bs%3A21%3A%22PostmanRuntime%2F7.30.0%22%3Bs%3A13%3A%22last_activity%22%3Bi%3A1675163866%3Bs%3A9%3A%22user_data%22%3Bs%3A0%3A%22%22%3B%7Da24dc71d5f5eee3b29e78b8511f4d11a'
      };
      var request = http.Request('POST',
          Uri.parse(ApiConstants.baseUrl + ApiConstants.findOperatorEndpoint));
      request.body = json.encode({
        "headers": {
          "tenant_code": "mpsl",
          "device_id": deviceId,
          "client_ip": "202.142.83.251",
          "location": location,
          "end_channel_code": "CUSTOMER",
          "stan": "1675163876",
          "run_mode": "REAL",
          "function_code": "DEFAULT",
          "function_sub_code": "DEFAULT",
          "user_id": userId
        },
        "request": {"service_id": serviceId, "number": number}
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        findOperatorModel = findOperatorFromJson(data);
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return findOperatorModel;
  }

  Future<GetOperatorList> getOperatorListRequest(
      {required String sessionId,
      required String userId,
      required String serviceId,
      required String deviceId,
      required String location}) async {
    late GetOperatorList getOperatorListModel;

    try {
      var headers = {
        'Authorization': sessionId,
        'Cache-Control': ' no-cache',
        'accept': ' application/json',
        'cache-control': ' no-cache',
        'Content-Type': 'application/json',
        'Cookie':
            'ci_session=a%3A5%3A%7Bs%3A10%3A%22session_id%22%3Bs%3A32%3A%22de170b341e59e4183bc552ca48ee4541%22%3Bs%3A10%3A%22ip_address%22%3Bs%3A13%3A%2242.104.150.27%22%3Bs%3A10%3A%22user_agent%22%3Bs%3A21%3A%22PostmanRuntime%2F7.30.0%22%3Bs%3A13%3A%22last_activity%22%3Bi%3A1675156305%3Bs%3A9%3A%22user_data%22%3Bs%3A0%3A%22%22%3B%7D52e0472965a1e3a607ed636463184949'
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              ApiConstants.baseUrl + ApiConstants.serviceOperatorsEndpoint));
      request.body = json.encode({
        "headers": {
          "tenant_code": "mpsl",
          "device_id": "941b50ec152347c500e9fcd0aa592331",
          "client_ip": "202.142.83.251",
          "location": location,
          "end_channel_code": "CUSTOMER",
          "stan": "1675164123",
          "run_mode": "REAL",
          "function_code": "DEFAULT",
          "function_sub_code": "DEFAULT",
          "user_id": userId
        },
        "request": {"service_id": serviceId, "number": ""}
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();

        getOperatorListModel = getOperatorListFromJson(data);
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return getOperatorListModel;
  }

  Future<GetOperatorPlan> getOperatorPlanRequest(
      {required String sessionId,
      required String userId,
      required String serviceId,
      required String number,
      required String opCode,
      required deviceId,
      required String location}) async {
    late GetOperatorPlan getOperatorPlanModel;
    try {
      var headers = {
        'Authorization': sessionId,
        'Cache-Control': ' no-cache',
        'accept': ' application/json',
        'cache-control': ' no-cache',
        'Content-Type': 'application/json',
        'Cookie':
            'ci_session=a%3A5%3A%7Bs%3A10%3A%22session_id%22%3Bs%3A32%3A%2213acc4ffe117e0ca9462f0ae72c36fe6%22%3Bs%3A10%3A%22ip_address%22%3Bs%3A13%3A%2242.104.150.27%22%3Bs%3A10%3A%22user_agent%22%3Bs%3A21%3A%22PostmanRuntime%2F7.30.0%22%3Bs%3A13%3A%22last_activity%22%3Bi%3A1675165173%3Bs%3A9%3A%22user_data%22%3Bs%3A0%3A%22%22%3B%7D616df8c0b58567ee6a3b7d7f6ddd459b'
      };
      var request = http.Request('POST',
          Uri.parse(ApiConstants.baseUrl + ApiConstants.operatorPlanEndpoint));
      request.body = json.encode({
        "headers": {
          "tenant_code": "mpsl",
          "device_id": deviceId,
          "client_ip": "202.142.83.251",
          "location": location,
          "end_channel_code": "CUSTOMER",
          "stan": "1675165635",
          "run_mode": "REAL",
          "function_code": "DEFAULT",
          "function_sub_code": "DEFAULT",
          "user_id": userId
        },
        "request": {
          "service_id": serviceId,
          "number": serviceId,
          "opcode": opCode
        },
        "or_use_any_of_these": {
          "service_id1": "1",
          "number1": "8088210012",
          "opcode1": "J",
          "service_id2": "2",
          "number2": "8147707554",
          "opcode2": "TS"
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        getOperatorPlanModel = getOperatorPlanFromJson(data);

      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return getOperatorPlanModel;
  }

  Future<GetOperatorBill> getOperatorBillRequest(
      {required String sessionId,
      required String userId,
      required String serviceId,
      required String consumerNumber,
      required String opCode,
      required String deviceId,
      required String location}) async {

    late GetOperatorBill getOperatorBillModel;
    try {
      var headers = {
        'Authorization': sessionId,
        'Cache-Control': ' no-cache',
        'accept': ' application/json',
        'cache-control': ' no-cache',
        'Content-Type': 'application/json',
        'Cookie':
            'ci_session=a%3A5%3A%7Bs%3A10%3A%22session_id%22%3Bs%3A32%3A%22c7156d21b984ffed2b4e9ace3b26a598%22%3Bs%3A10%3A%22ip_address%22%3Bs%3A13%3A%2242.104.150.27%22%3Bs%3A10%3A%22user_agent%22%3Bs%3A21%3A%22PostmanRuntime%2F7.30.0%22%3Bs%3A13%3A%22last_activity%22%3Bi%3A1675156918%3Bs%3A9%3A%22user_data%22%3Bs%3A0%3A%22%22%3B%7Dac8936670e7b54286e24cbf2294384b0'
      };
      var request = http.Request('POST',
          Uri.parse(ApiConstants.baseUrl + ApiConstants.operatorBillEndpoint));
      request.body = json.encode({
        "headers": {
          "tenant_code": "mpsl",
          "device_id": deviceId,
          "client_ip": "202.142.83.251",
          "location": location,
          "end_channel_code": "CUSTOMER",
          "stan": "1675166501",
          "run_mode": "REAL",
          "function_code": "DEFAULT",
          "function_sub_code": "DEFAULT",
          "user_id": userId
        },
        "request": {
          "service_id": serviceId,
          "number": consumerNumber,
          "opcode": opCode
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        getOperatorBillModel = getOperatorBillFromJson(data);
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return getOperatorBillModel;
  }

  Future<LedgerData> getLedgerData(
      {required String sessionId,
      required String userId,
      required String deviceId,
      required String location}) async {
    // Position position = await LocationService().getCurrentLocation();
    // String latLngString = '${position.latitude},${position.longitude}';
    late LedgerData ledgerData;
    try {
      var headers = {
        'Authorization': sessionId,
        'Cache-Control': ' no-cache',
        'accept': ' application/json',
        'cache-control': ' no-cache',
        'Content-Type': 'application/json',
        'Cookie':
            'ci_session=a%3A5%3A%7Bs%3A10%3A%22session_id%22%3Bs%3A32%3A%22eb6cf98712ba875d555ad8f68b3dd471%22%3Bs%3A10%3A%22ip_address%22%3Bs%3A12%3A%2249.15.90.222%22%3Bs%3A10%3A%22user_agent%22%3Bs%3A21%3A%22PostmanRuntime%2F7.30.1%22%3Bs%3A13%3A%22last_activity%22%3Bi%3A1676299533%3Bs%3A9%3A%22user_data%22%3Bs%3A0%3A%22%22%3B%7D9c18c12274e264b46d935c7a87583a55'
      };
      var request = http.Request('POST',
          Uri.parse(ApiConstants.baseUrl + ApiConstants.ledgerEndpoint));
      request.body = json.encode({
        "headers": {
          "tenant_code": "mpsl",
          "device_id": deviceId,
          "client_ip": "202.142.83.251",
          "location": location,
          "end_channel_code": "CUSTOMER",
          "stan": "1676299533",
          "run_mode": "REAL",
          "function_code": "DEFAULT",
          "function_sub_code": "DEFAULT",
          "user_id": userId
        },
        "request": {}
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        ledgerData = ledgerDataFromJson(data);
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return ledgerData;
  }

  Future<TransactionHistory> getTransactionHistory(
      {required String sessionId,
      required String userId,
      required deviceId,
      required String location}) async {
    late TransactionHistory transactionHistory;
    try {
      var headers = {
        'Authorization': sessionId,
        'Cache-Control': ' no-cache',
        'accept': ' application/json',
        'cache-control': ' no-cache',
        'Content-Type': 'application/json',
        'Cookie':
            'ci_session=a%3A5%3A%7Bs%3A10%3A%22session_id%22%3Bs%3A32%3A%2288cc209e372bb610b8e28ac5d83f5b34%22%3Bs%3A10%3A%22ip_address%22%3Bs%3A12%3A%2242.104.147.4%22%3Bs%3A10%3A%22user_agent%22%3Bs%3A21%3A%22PostmanRuntime%2F7.30.1%22%3Bs%3A13%3A%22last_activity%22%3Bi%3A1676390390%3Bs%3A9%3A%22user_data%22%3Bs%3A0%3A%22%22%3B%7Dc3827c3534969967643c07279dde836d'
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              ApiConstants.baseUrl + ApiConstants.transactionReportEndpoint));
      request.body = json.encode({
        "headers": {
          "tenant_code": "mpsl",
          "device_id": deviceId,
          "client_ip": "202.142.83.251",
          "location": location,
          "end_channel_code": "CUSTOMER",
          "stan": "1676392170",
          "run_mode": "REAL",
          "function_code": "DEFAULT",
          "function_sub_code": "DEFAULT",
          "user_id": userId
        },
        "request": {}
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        transactionHistory = transactionHistoryFromJson(data);
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return transactionHistory;
  }

  Future<BankList> getBankList(
      {required String sessionId,
      required String userId,
      required String paymentMode,
      required String amount,
      required String deviceId,
      required String location}) async {
    late BankList bankList;

    try {
      var headers = {
        'Authorization': sessionId,
        'Cache-Control': ' no-cache',
        'accept': ' application/json',
        'cache-control': ' no-cache',
        'Content-Type': 'application/json',
        'Cookie':
            'ci_session=a%3A5%3A%7Bs%3A10%3A%22session_id%22%3Bs%3A32%3A%225b8826846bfeed660a66a805cac55e85%22%3Bs%3A10%3A%22ip_address%22%3Bs%3A13%3A%2242.104.156.13%22%3Bs%3A10%3A%22user_agent%22%3Bs%3A21%3A%22PostmanRuntime%2F7.31.0%22%3Bs%3A13%3A%22last_activity%22%3Bi%3A1676907254%3Bs%3A9%3A%22user_data%22%3Bs%3A0%3A%22%22%3B%7Dc1eafb074267d6f97bbb07a7cd432ba2'
      };
      var request = http.Request('POST',
          Uri.parse(ApiConstants.baseUrl + ApiConstants.bankListEndpoint));
      request.body = json.encode({
        "headers": {
          "tenant_code": "mpsl",
          "device_id": deviceId,
          "client_ip": "202.142.83.251",
          "location": location,
          "end_channel_code": "CUSTOMER",
          "stan": "1676907326",
          "run_mode": "REAL",
          "function_code": "DEFAULT",
          "function_sub_code": "DEFAULT",
          "user_id": userId
        },
        "request": {
          "bank_id": "1",
          "payment_date": "2023-02-11",
          "payment_mode": paymentMode,
          "amount": amount,
          "txn_ref_number": "UPI",
          "remarks": ""
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        bankList = bankListFromJson(data);
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return bankList;
  }

  Future<LoadWalletRequest> loadWalletRequest(
      {required String sessionId,
      required String userId,
      required String bankId,
      required String paymentDate,
      required String paymentMode,
      required String amount,
      required String transactionRef,
      required String remarks,
      required String deviceId,
      required String location}) async {
    late LoadWalletRequest loadWalletRequest;
    try {
      var headers = {
        'Authorization': sessionId,
        'Cache-Control': ' no-cache',
        'accept': ' application/json',
        'cache-control': ' no-cache',
        'Content-Type': 'application/json',
        'Cookie':
            'ci_session=a%3A5%3A%7Bs%3A10%3A%22session_id%22%3Bs%3A32%3A%228c5fd762ba211301c8f0c57d51b269fc%22%3Bs%3A10%3A%22ip_address%22%3Bs%3A12%3A%2242.105.158.7%22%3Bs%3A10%3A%22user_agent%22%3Bs%3A21%3A%22PostmanRuntime%2F7.31.0%22%3Bs%3A13%3A%22last_activity%22%3Bi%3A1676960987%3Bs%3A9%3A%22user_data%22%3Bs%3A0%3A%22%22%3B%7D17f9e7687c1f8e86b7e8a148afd5e1c2'
      };
      var request = http.Request('POST',
          Uri.parse(ApiConstants.baseUrl + ApiConstants.loadWalletEndpoint));
      request.body = json.encode({
        "headers": {
          "tenant_code": "mpsl",
          "device_id": deviceId,
          "client_ip": "202.142.83.251",
          "location": location,
          "end_channel_code": "CUSTOMER",
          "stan": "1676961265",
          "run_mode": "REAL",
          "function_code": "DEFAULT",
          "function_sub_code": "DEFAULT",
          "user_id": userId
        },
        "request": {
          "bank_id": bankId,
          "payment_date": paymentDate,
          "payment_mode": paymentMode,
          "amount": amount,
          "txn_ref_number": transactionRef,
          "remarks": remarks
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        loadWalletRequest = loadWalletRequestFromJson(data);
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return loadWalletRequest;
  }

  Future<ProcessPayment> processPaymentRequest(
      {required String sessionId,
      required String userId,
      required String serviceId,
      required String number,
      required String opCode,
      required String amount,
      required String deviceId,
      required String location}) async {
    late ProcessPayment processPayments;
    try {
      var headers = {
        'Authorization': sessionId,
        'Cache-Control': ' no-cache',
        'accept': ' application/json',
        'cache-control': ' no-cache',
        'Content-Type': 'application/json',
        'Cookie':
            'ci_session=a%3A5%3A%7Bs%3A10%3A%22session_id%22%3Bs%3A32%3A%223555e0d84de85539ea739206ad434e0a%22%3Bs%3A10%3A%22ip_address%22%3Bs%3A12%3A%2242.105.159.1%22%3Bs%3A10%3A%22user_agent%22%3Bs%3A21%3A%22PostmanRuntime%2F7.31.0%22%3Bs%3A13%3A%22last_activity%22%3Bi%3A1677065694%3Bs%3A9%3A%22user_data%22%3Bs%3A0%3A%22%22%3B%7D2a4538f771a7d59c9931bfb89af89e52'
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              ApiConstants.baseUrl + ApiConstants.processPaymentEndpoint));
      request.body = json.encode({
        "headers": {
          "tenant_code": "mpsl",
          "device_id": deviceId,
          "client_ip": "202.142.83.251",
          "location": location,
          "end_channel_code": "CUSTOMER",
          "stan": "1677074446",
          "run_mode": "REAL",
          "function_code": "DEFAULT",
          "function_sub_code": "DEFAULT",
          "user_id": userId
        },
        "request": {
          "service_id": serviceId,
          "number": number,
          "opcode": opCode,
          "amount": amount
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        processPayments = processPaymentFromJson(data);
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return processPayments;
  }

  Future<UserRegister> newUserRegister(
      {required String deviceId,
      required String userName,
      required String userEmail,
      required String phoneNum,
      required String businessType,
      required String password,
      required String pinCode,
      required String geoId}) async {
    late UserRegister userRegister;
    try {
      var headers = {
        'Authorization': ' 4acb2419-5ea9-437d-8f57-2dea47f7fa33',
        'Cache-Control': ' no-cache',
        'accept': ' application/json',
        'cache-control': ' no-cache',
        'Content-Type': 'application/json',
        'Cookie':
            'ci_session=a%3A5%3A%7Bs%3A10%3A%22session_id%22%3Bs%3A32%3A%226680f66e34dd61a6277f86925816f8e0%22%3Bs%3A10%3A%22ip_address%22%3Bs%3A13%3A%2242.105.158.19%22%3Bs%3A10%3A%22user_agent%22%3Bs%3A21%3A%22PostmanRuntime%2F7.31.1%22%3Bs%3A13%3A%22last_activity%22%3Bi%3A1677996918%3Bs%3A9%3A%22user_data%22%3Bs%3A0%3A%22%22%3B%7D8982a63befb09361000b0bd6fcae2e1d'
      };
      var request = http.Request('POST',
          Uri.parse(ApiConstants.baseUrl + ApiConstants.userRegisterEndpoint));
      request.body = json.encode({
        "headers": {
          "tenant_code": "mpsl",
          "device_id": deviceId,
          "client_ip": "202.142.83.251",
          "location": '***',
          "end_channel_code": "CUSTOMER",
          "stan": "1677996923",
          "run_mode": "REAL",
          "function_code": "DEFAULT",
          "function_sub_code": "DEFAULT",
          "user_id": "2498"
        },
        "request": {
          "user_name": userName,
          "user_email": userEmail,
          "user_msisdn": phoneNum,
          "business_type": businessType,
          "user_password": password,
          "profile_photo": "BASE64_image",
          "aadhaar_number": "8088210012",
          "gender": "MALE|FEMALE|OTHER",
          "date_of_birth": "1988-11-20",
          "pan_number": "BASE64_image",
          "address_line1": "Addresss Line1",
          "address_line2": "Addresss Line2",
          "pincode": pinCode,
          "geo_id": geoId
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        userRegister = userRegisterFromJson(data);
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return userRegister;
  }

  Future<MasterData> fetchMasterData(
      {required String deviceId,
      required String dataType,
      required String dataSubType}) async {
    late MasterData businessType;
    try {
      var headers = {
        'Authorization': ' 4acb2419-5ea9-437d-8f57-2dea47f7fa33',
        'Cache-Control': ' no-cache',
        'accept': ' application/json',
        'cache-control': ' no-cache',
        'Content-Type': 'application/json',
        'Cookie':
            'ci_session=a%3A5%3A%7Bs%3A10%3A%22session_id%22%3Bs%3A32%3A%22786d778a53dca79cd3e71ddcb225ef2c%22%3Bs%3A10%3A%22ip_address%22%3Bs%3A13%3A%2242.104.152.32%22%3Bs%3A10%3A%22user_agent%22%3Bs%3A21%3A%22PostmanRuntime%2F7.31.1%22%3Bs%3A13%3A%22last_activity%22%3Bi%3A1678007510%3Bs%3A9%3A%22user_data%22%3Bs%3A0%3A%22%22%3B%7D0369051855622377660f84a165372fba'
      };
      var request = http.Request('POST',
          Uri.parse(ApiConstants.baseUrl + ApiConstants.masterDataEndpoint));
      request.body = json.encode({
        "headers": {
          "tenant_code": "mpsl",
          "device_id": deviceId,
          "client_ip": "202.142.83.251",
          "location": '***',
          "end_channel_code": "CUSTOMER",
          "stan": "1678008074",
          "run_mode": "REAL",
          "function_code": "DEFAULT",
          "function_sub_code": "DEFAULT",
          "user_id": "2498"
        },
        "request": {"data_type": dataType, "data_sub_type": dataSubType}
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        businessType = masterDataFromJson(data);
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return businessType;
  }

  Future<PincodeData> fetchPinCodeData({
    required String deviceId,
    required String pinCode,
  }) async {
    late PincodeData pincodeData;
    try {
      var headers = {
        'Authorization': ' 4acb2419-5ea9-437d-8f57-2dea47f7fa33',
        'Cache-Control': ' no-cache',
        'accept': ' application/json',
        'cache-control': ' no-cache',
        'Content-Type': 'application/json',
        'Cookie':
            'ci_session=a%3A5%3A%7Bs%3A10%3A%22session_id%22%3Bs%3A32%3A%226680f66e34dd61a6277f86925816f8e0%22%3Bs%3A10%3A%22ip_address%22%3Bs%3A13%3A%2242.105.158.19%22%3Bs%3A10%3A%22user_agent%22%3Bs%3A21%3A%22PostmanRuntime%2F7.31.1%22%3Bs%3A13%3A%22last_activity%22%3Bi%3A1677996918%3Bs%3A9%3A%22user_data%22%3Bs%3A0%3A%22%22%3B%7D8982a63befb09361000b0bd6fcae2e1d'
      };
      var request = http.Request('POST',
          Uri.parse(ApiConstants.baseUrl + ApiConstants.pinCodeMasterEndpoint));
      request.body = json.encode({
        "headers": {
          "tenant_code": "mpsl",
          "device_id": deviceId,
          "client_ip": "202.142.83.251",
          "location": '***',
          "end_channel_code": "CUSTOMER",
          "stan": "1678008635",
          "run_mode": "REAL",
          "function_code": "DEFAULT",
          "function_sub_code": "DEFAULT",
          "user_id": "2498"
        },
        "request": {"pincode": pinCode}
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        pincodeData = pincodeDataFromJson(data);
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return pincodeData;
  }

  Future<ServiceRequest> sendServiceRequest(
      {required String sessionId,
      required String deviceId,
      required String location,
      required String userId,
      required String topic,
      required String subject,
      required String message}) async {
    late ServiceRequest serviceRequest;
    try {
      var headers = {
        'Authorization': sessionId,
        'Cache-Control': ' no-cache',
        'accept': ' application/json',
        'cache-control': ' no-cache',
        'Content-Type': 'application/json',
        'Cookie':
            'ci_session=a%3A5%3A%7Bs%3A10%3A%22session_id%22%3Bs%3A32%3A%22a2ef292ab5e1a751d5d0cf7edc9e0b3c%22%3Bs%3A10%3A%22ip_address%22%3Bs%3A13%3A%2242.104.152.35%22%3Bs%3A10%3A%22user_agent%22%3Bs%3A21%3A%22PostmanRuntime%2F7.31.1%22%3Bs%3A13%3A%22last_activity%22%3Bi%3A1678514206%3Bs%3A9%3A%22user_data%22%3Bs%3A0%3A%22%22%3B%7Dc9d1c9bba61397a37b6d3ce260778edd'
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              ApiConstants.baseUrl + ApiConstants.serviceRequestEndpoint));
      request.body = json.encode({
        "headers": {
          "tenant_code": "mpsl",
          "device_id": deviceId,
          "client_ip": "202.142.83.251",
          "location": location,
          "end_channel_code": "CUSTOMER",
          "stan": "1678526178",
          "run_mode": "REAL",
          "function_code": "DEFAULT",
          "function_sub_code": "DEFAULT",
          "user_id": userId
        },
        "request": {"topic": topic, "subject": subject, "message": message}
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        serviceRequest = serviceRequestFromJson(data);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
    return serviceRequest;
  }

  Future<void> sendTokenToServer(
      {required String token,
      required String deviceId,
      required String sessionId,required String userId,required String location}) async {

    var headers = {
      'Authorization': sessionId,
      'Cache-Control': ' no-cache',
      'accept': ' application/json',
      'cache-control': ' no-cache',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse(ApiConstants.baseUrl + ApiConstants.saveTokenEndpoint));
    request.body = json.encode({
      "headers": {
        "tenant_code": "mpsl",
        "device_id": deviceId,
        "client_ip": "202.142.83.251",
        "location": location,
        "end_channel_code": "CUSTOMER",
        "stan": "1678647655",
        "run_mode": "REAL",
        "function_code": "DEFAULT",
        "function_sub_code": "DEFAULT",
        "user_id": userId
      },
      "request": {"device_id": deviceId, "token_id": token}
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
