import 'package:flutter/material.dart';

class MegaColors {
  static const statusSuccess = Color(0xFF60A606);
  static const statusTopUp = Color(0xFF448AFF);
  static const statusPending = Color(0xFF4D616C);
  static const lightCyan = Color(0xFF3aafa9);
  static const secondaryC = Color(0xFFf39314);
  static const deepCyan = Color(0xFF004a62);
  static const successGreen = Color(0xFF4BB543);
  static const info = Color(0xFFADD8E6);
  static const warning = Color(0xFFFFC700);
  static const error = Color(0xFFDC0000);
}

class MegaBrand {
  static const String brandLogo = "asset/icons/megaPayBrand.png";
  static const String homePageEndpoint = 'https://megapay.co.in/';
  static const String termsAndConditionEndpoint =
      'https://megapay.co.in/Terms-&-Conditions.html';
  static const String privacyPolicyEndpoint =
      'https://megapay.co.in/Privacy-Policy.html';
  static const String contactMegaPayEndpoint =
      'https://megapay.co.in/#contactUs';
}

const List<String> billPayIcons = [
  'asset/dashboardIcons/ic-postpaid.png',
  'asset/dashboardIcons/ic-gas_bill.png',
  'asset/dashboardIcons/ic-electricity.png',
  'asset/dashboardIcons/ic-landline.png',
  'asset/dashboardIcons/ic-broadband.png',
  'asset/dashboardIcons/ic-water_bill.png',
  'asset/dashboardIcons/ic-life_insurance.png',
  'asset/dashboardIcons/ic-gas.png',
  'asset/dashboardIcons/ic-health.png',
  'asset/dashboardIcons/ic-my_dues.png',
  'asset/dashboardIcons/ic-bank_account.png',
  'asset/dashboardIcons/ic-more.png',
  'asset/dashboardIcons/ic-card.png',
  'asset/dashboardIcons/ic-insurance_bill.png',
  'asset/dashboardIcons/ic-repay_loan.png',
];

const List<String> billPayTitles = [
  'Postpaid',
  'Piped Gas',
  'Electricity',
  'Landline',
  'Broadband',
  'Water',
  'Insurance',
  'Book A Cylinder',
  'Life Insurance',
  'Municipal Tax',
  'Municipal Services',
  'Subscriptions',
  'Credit Card Bill',
  'Hospitals',
  'Loan Repayment'
];

const List profilePageOptions = [
  'My Wallet QR Code',
  // 'Status Enquiry',
  'Account Statement',
  'My Earnings',
  'Raise a Request',
  // 'Raise BBPS complaints',
  // 'settings',
  'Help',
  'Logout'
];
const List<Icon> profilePageIcons = [
  Icon(Icons.qr_code_scanner),
  // Icon(Icons.schedule_sharp),
  Icon(Icons.table_view),
  Icon(Icons.monetization_on),
  Icon(Icons.info),
  // Icon(Icons.call),
  // Icon(Icons.settings),
  Icon(Icons.help),
  Icon(Icons.logout)
];
const String profileDummyAvatar = 'asset/icons/sampleAvatar.png';

class ApiConstants {
  static const String baseUrl = "https://mega-pay.in/secure_api";
  static const String loginEndpoint = "/app_login";
  static const String dashboardEndpoint = "/dashboard";
  static const String servicesEndpoint = "/getServices";
  static const String balanceEndpoint = "/getBalance";
  static const String findOperatorEndpoint = "/findOperator";
  static const String serviceOperatorsEndpoint = "/getServiceOperators";
  static const String operatorPlanEndpoint = "/getOperatorPlan";
  static const String operatorBillEndpoint = "/getOperatorBill";
  static const String ledgerEndpoint = "/getLedger";
  static const String transactionReportEndpoint = "/getTransactionReport";
  static const String bankListEndpoint = "/getBankList";
  static const String loadWalletEndpoint = "/LoadWalletRequest";
  static const String processPaymentEndpoint = "/processPayment";
  static const String userRegisterEndpoint = '/app_register';
  static const String masterDataEndpoint = '/getMasterData';
  static const String pinCodeMasterEndpoint='/getPincodeMaster';
}

class WalletTopUpConst {
  static const String successTick = 'asset/icons/check_mark_green.png';
  static const String failCross = 'asset/icons/failure_red_cross.png';
  static const String processing = 'asset/icons/sendMoney.png';
}
final List<String> rechargeTitles = [
  'Prepaid',
  'DTH',
  'Cable TV',
  'FASTag',
];

final List<String> rechargeIcons = [
  'asset/dashboardIcons/ic-mobile.png',
  'asset/dashboardIcons/ic-dth.png',
  'asset/dashboardIcons/ic-help.png',
  'asset/dashboardIcons/ic-fastag.png'
];