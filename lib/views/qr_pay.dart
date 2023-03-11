import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';

class QrCodeScannerPage extends StatefulWidget {
  const QrCodeScannerPage({super.key});

  @override
  QrCodeScannerPageState createState() => QrCodeScannerPageState();
}

class QrCodeScannerPageState extends State<QrCodeScannerPage> {
  GlobalKey qrKey = GlobalKey();
  Barcode? barcode;
  late QRViewController controller;

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Scan & Pay'),
          actions: [
            Padding(
              padding: EdgeInsets.all(10.w),
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'myQRScreen');
                  },
                  child: const Text('My QR')),
            )
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: Center(
          child: QRView(
            overlay: QrScannerOverlayShape(
                borderColor: Colors.white,
                overlayColor: Colors.black.withOpacity(0.5)),
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
