import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);
  final String errorRive = 'asset/rive_assets/2686-5508-koneksi-terputus.riv';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Center(
        child: RiveAnimation.asset(
          errorRive,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
