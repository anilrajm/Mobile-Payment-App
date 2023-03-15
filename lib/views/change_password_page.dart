import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body:   Center(
        child: Text(
          'Password change option will be available soon',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16.sp),
        ),
      ),
    );
  }
}
