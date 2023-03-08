import 'package:flutter/material.dart';
  import 'package:recharge_app_mega/views/views.dart';

void toastWidget(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,textColor: Colors.white,fontSize: 16.0.sp);
}
