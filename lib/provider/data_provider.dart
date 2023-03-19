import 'package:flutter/foundation.dart';
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
import 'package:recharge_app_mega/models/transaction_history_model.dart';
import 'package:recharge_app_mega/models/user_register_model.dart';
import 'package:recharge_app_mega/networking/api_request.dart';
import 'package:recharge_app_mega/provider/location_provider.dart';
import 'package:recharge_app_mega/views/views.dart';

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  late Login _loginModel;

  Login get loginModel => _loginModel;

  late String _deviceId;

  String get deviceId => _deviceId;

  late String _location;

  String get location => _location;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  login({
    required String userName,
    required String password,
  }) async {
    setLoading(true);

    _location = await LocationProvider()
        .getLocation(); // storing longitude and latitude String

    AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    _deviceId = androidInfo.id.toString();
    notifyListeners();

    _loginModel = await APIManagement().loginRequest(
        userName: userName,
        password: password,
        deviceId: _deviceId,
        location: _location);
    notifyListeners();
    setLoading(false);
  }
}

class DashboardProvider with ChangeNotifier {
  late Dashboard _dashboardModel;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Dashboard get dashboardModel => _dashboardModel;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  fetchDashboard(
      {required String sessionId,
      required String userId,
      required String deviceId,
      required String location}) async {
    setLoading(true);

    try {
      _dashboardModel = await APIManagement().dashboardRequest(
          sessionId: sessionId,
          userId: userId,
          deviceId: deviceId,
          location: location);
      notifyListeners();
      setLoading(false);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching dashboard: $e');
      }
    } finally {
      setLoading(false);
    }
  }
}

class GetServiceProvider with ChangeNotifier {
  late GetServices _getServicesModel;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  GetServices get getServicesModel => _getServicesModel;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  getService(
      {required String sessionId,
      required String userId,
      required String deviceId,
      required String location}) async {
    setLoading(true);

    try {
      _getServicesModel = await APIManagement().getServicesRequest(
          sessionId: sessionId,
          userId: userId,
          deviceId: deviceId,
          location: location);
      notifyListeners();
      setLoading(false);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching services: $e');
      }
    } finally {
      setLoading(false);
    }
  }
}

class GetBalanceProvider with ChangeNotifier {
  late GetBalance _getBalanceModel;

  GetBalance get getBalanceModel => _getBalanceModel;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  getBalance(
      {required String sessionId,
      required String userId,
      required String deviceId,
      required String location}) async {
    setLoading(true);
    try {
      _getBalanceModel = await APIManagement().getBalanceRequest(
          sessionId: sessionId,
          userId: userId,
          deviceId: deviceId,
          location: location);
      notifyListeners();
      setLoading(false);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching balance: $e');
      }
    } finally {
      setLoading(false);
    }
  }
}

class FindOperatorProvider with ChangeNotifier {
  FindOperator? _findOperatorModel;

  FindOperator? get findOperatorModel => _findOperatorModel;

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  findOperator(
      {required String sessionId,
      required String serviceId,
      required String number,
      required String userId,
      required String deviceId,
      required String location}) async {
    setLoading(true);
    try {
      _findOperatorModel = (await APIManagement().findOperatorRequest(
          sessionId: sessionId,
          serviceId: sessionId,
          number: number,
          userId: userId,
          deviceId: deviceId,
          location: ''));
      notifyListeners();
      setLoading(false);
    } catch (e) {
      if (kDebugMode) {
        print("Error Fetching operator: $e");
      }
    } finally {
      setLoading(false);
    }
  }
}

class OperatorListProvider with ChangeNotifier {
  late GetOperatorList _operatorListModel;

  GetOperatorList get operatorListModel => _operatorListModel;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    // notifyListeners();
  }

  Future<GetOperatorList> fetchOperatorList(
      {required String sessionId,
      required String serviceId,
      required String userId,
      required String deviceId,
      required String location}) async {
    setLoading(true);

    try {
      _operatorListModel = await APIManagement().getOperatorListRequest(
          sessionId: sessionId,
          serviceId: serviceId,
          userId: userId,
          deviceId: deviceId,
          location: location);
      notifyListeners();
      setLoading(false);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching operator list: $e');
      }
    } finally {
      setLoading(false);
    }
    return _operatorListModel;
  }
}

class OperatorPlanProvider {
  late GetOperatorPlan _operatorPlanModel;

  Future<GetOperatorPlan> fetchOperatorPlan(
      {required String sessionId,
      required String serviceId,
      required String number,
      required String opCode,
      required String userId,
      required String deviceId,
      required String location}) async {
    try {
      _operatorPlanModel = await APIManagement().getOperatorPlanRequest(
          sessionId: sessionId,
          serviceId: serviceId,
          number: number,
          opCode: opCode,
          userId: userId,
          deviceId: deviceId,
          location: location);
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching operator plan: $e");
      }

    }

    return _operatorPlanModel;
  }
}

class OperatorBillProvider{
  late GetOperatorBill _operatorBillModel;
  Future<GetOperatorBill> fetchOperatorBill(
      {required String sessionId,
      required String serviceId,
      required String consumerNumber,
      required String opCode,
      required String userId,
      required String deviceId,
      required String location}) async {

    try {
      _operatorBillModel = await APIManagement().getOperatorBillRequest(
          sessionId: sessionId,
          serviceId: serviceId,
          consumerNumber: consumerNumber,
          opCode: opCode,
          userId: userId,
          deviceId: deviceId,
          location: location);
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching operator bill: $e");
      }
    }  return _operatorBillModel;

  }
}

class LedgerDataProvider with ChangeNotifier {
  late LedgerData _ledgerData;

  LedgerData get ledgerData => _ledgerData;

  Future<LedgerData> fetchLedgerData(
      {required String sessionId,
      required String userId,
      required String deviceId,
      required String location}) async {
    try {
      _ledgerData = await APIManagement().getLedgerData(
          sessionId: sessionId,
          userId: userId,
          deviceId: deviceId,
          location: location);
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching ledger data: $e");
      }
    }

    return _ledgerData;
  }
}

class TransactionHistoryProvider with ChangeNotifier {
  late TransactionHistory _transactionHistory;

  get transactionHistory => _transactionHistory;

  Future<TransactionHistory> fetchTransactionHistory(
      {required String sessionId,
      required String userId,
      required String deviceId,
      required String location}) async {
    try {
      _transactionHistory = await APIManagement().getTransactionHistory(
          sessionId: sessionId,
          userId: userId,
          deviceId: deviceId,
          location: location);
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching transaction history: $e");
      }
    }

    return _transactionHistory;
  }
}

class BankListProvider {
  late BankList _bankList;

  BankList get bankList => _bankList;

  Future<BankList> fetchBankList(
      {required String sessionId,
      required String userId,
      required String amount,
      required String paymentMode,
      required String deviceId,
      required String location}) async {
    try {
      _bankList = await APIManagement().getBankList(
          sessionId: sessionId,
          userId: userId,
          amount: amount,
          paymentMode: paymentMode,
          deviceId: deviceId,
          location: location);
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching the bank list: $e");
      }
    }

    return _bankList;
  }
}

class LoadWalletProvider {
  late LoadWalletRequest loadWalletModel;

  Future<LoadWalletRequest> loadWallet(
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
    try {
      loadWalletModel = await APIManagement().loadWalletRequest(
        sessionId: sessionId,
        userId: userId,
        bankId: bankId,
        paymentDate: paymentDate,
        paymentMode: paymentMode,
        amount: amount,
        transactionRef: transactionRef,
        remarks: remarks,
        deviceId: deviceId,
        location: location,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error loading wallet: $e');
      }
      rethrow;
    }
    return loadWalletModel;
  }
}

class ProcessPaymentProvider {
  late ProcessPayment processPayments;

  Future<ProcessPayment> processPaymentService(
      {required String sessionId,
      required String userId,
      required String serviceId,
      required String number,
      required String opCode,
      required String amount,
      required String deviceId,
      required String location}) async {
    try {
      processPayments = await APIManagement().processPaymentRequest(
        sessionId: sessionId,
        userId: userId,
        amount: amount,
        serviceId: serviceId,
        number: number,
        opCode: opCode,
        deviceId: deviceId,
        location: location,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error processing payment request: $e');
      }
      rethrow;
    }
    return processPayments;
  }
}

class UserRegisterProvider {
  late UserRegister newUserRegister;
  late String _deviceId;

  Future<UserRegister> registerNewUser(
      {required String userName,
      required String userEmail,
      required String phoneNum,
      required String businessType,
      required String password,
      required String pinCode,
      required String geoId}) async {
    try {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      _deviceId = androidInfo.id.toString();
      newUserRegister = await APIManagement().newUserRegister(
        businessType: businessType,
        deviceId: _deviceId,
        geoId: geoId,
        userName: userName,
        password: password,
        phoneNum: phoneNum,
        pinCode: pinCode,
        userEmail: userEmail,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error processing payment request: $e');
      }
      rethrow;
    }
    return newUserRegister;
  }
}

class MasterDataProvider {
  late MasterData businessType;
  late String _deviceId;

  Future<MasterData> fetchMasterData(
      {required String dataType, required String dataSubType}) async {
    try {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      _deviceId = androidInfo.id.toString();

      businessType = await APIManagement().fetchMasterData(
        deviceId: _deviceId,
        dataType: dataType,
        dataSubType: dataSubType,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error processing payment request: $e');
      }
      rethrow;
    }
    return businessType;
  }
}

class PinCodeDataProvider with ChangeNotifier {
  bool _isLoading = false;

  PincodeData? _pincodeData;
  late String _deviceId;

  bool get isLoading => _isLoading;

  PincodeData? get pincodeData => _pincodeData;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<PincodeData?> fetchPinCodeData({
    required String pinCode,
  }) async {
    setLoading(true);
    try {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      _deviceId = androidInfo.id.toString();

      _pincodeData = await APIManagement().fetchPinCodeData(
        deviceId: _deviceId,
        pinCode: pinCode,
      );
      notifyListeners();
      setLoading(false);
    } catch (e) {
      if (kDebugMode) {
        print('Error processing payment request: $e');
      }
      rethrow;
    } finally {
      setLoading(false);
    }
    return pincodeData;
  }
}
