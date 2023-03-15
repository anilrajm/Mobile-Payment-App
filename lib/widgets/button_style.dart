import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';
class CustomButtonStyle {
  ButtonStyle buttonStyle(Size size)=>FilledButton.styleFrom(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0.r)),
    minimumSize:size,
  );

}