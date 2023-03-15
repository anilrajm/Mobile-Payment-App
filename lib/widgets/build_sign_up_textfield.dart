import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';

class BuildSignUpTextField extends StatelessWidget {
  const BuildSignUpTextField(
      {super.key,
      required this.keyboardType,
      required this.prefixIcon,
      required this.labelText,
      required this.controller,
      this.maxLength,
      this.obscureText,
      this.onChanged,
      this.validator,
      this.pincodeKey,
      this.helperText});

  final TextEditingController controller;
  final TextInputType keyboardType;
  final IconData prefixIcon;
  final String labelText;
  final String? helperText;
  final int? maxLength;
  final bool? obscureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Key? pincodeKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        child: TextFormField(
          key: pincodeKey,
          maxLength: maxLength,
          obscureText: obscureText ?? false,
          keyboardType: keyboardType,
          decoration: InputDecoration(helperMaxLines: 3,
              helperText: helperText,
              prefixIcon: Icon(prefixIcon),
              labelText: labelText),
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ));
  }
}
