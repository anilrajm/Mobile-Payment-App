import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';

class BuildEditProfileField extends StatelessWidget {
  const BuildEditProfileField({
    super.key,
    required this.fieldController,
    required this.fieldLabel,
    required this.keyboardType,
  });

  final TextEditingController fieldController;
  final String fieldLabel;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(8.50.w),
      child: TextFormField(
        controller: fieldController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: BorderSide.none),
            filled: true,
            labelText: fieldLabel,
            contentPadding: EdgeInsets.only(left: 19.63.w, top: 42.545.h),
            floatingLabelAlignment: FloatingLabelAlignment.start),
      ),
    );
  }
}
