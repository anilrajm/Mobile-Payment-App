import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

class MyQRScreen extends StatefulWidget {
  const MyQRScreen({Key? key}) : super(key: key);

  @override
  State<MyQRScreen> createState() => _MyQRScreenState();
}

class _MyQRScreenState extends State<MyQRScreen> {
  UPIDetails? _upiDetails;

  @override
  void initState() {
    super.initState();
    final loginModel =
        Provider.of<LoginProvider>(context, listen: false).loginModel;
    _upiDetails = UPIDetails(
      upiID: loginModel.data.paymentOptions.upi,
      payeeName: loginModel.data.org.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    var upiId =
        Provider.of<LoginProvider>(context, listen: false).loginModel.data;
    return Scaffold(
        appBar: AppBar(
          title: const Text('My QR Code'),
        ),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.symmetric(horizontal: 60.w, vertical: 150.h),
              child: SizedBox(
                  height: 400.h,
                  width: 300.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UPIPaymentQRCode(
                        upiDetails: _upiDetails!,
                        loader: const CircularProgressIndicator(),
                        size: 200,
                        embeddedImagePath: 'asset/icons/megaPayBrand.png',
                        embeddedImageSize: Size(60.w, 60.h),
                        upiQRErrorCorrectLevel: UPIQRErrorCorrectLevel.low,
                      ),
                      Text(
                        upiId.paymentOptions.upi,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                      Divider(
                        indent: 30.w,
                        endIndent: 30.w,
                        height: 60.h,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    fixedSize: Size(110.w, 40.h)),
                                onPressed: () {},
                                child: const Text('Download')),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    fixedSize: Size(110.w, 40.h)),
                                onPressed: () {},
                                child: const Text('Share'))
                          ])
                    ],
                  )),
            ),
          ],
        ));
  }
}
