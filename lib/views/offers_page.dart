import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({Key? key}) : super(key: key);
  final String errorRive = 'asset/rive_assets/2686-5508-koneksi-terputus.riv';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offers'),
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
