import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:recharge_app_mega/views/views.dart';

class MyQRScreen extends StatelessWidget {
  const MyQRScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = Provider.of<LoginProvider>(context).loginModel.data.org.name;
    return Scaffold(
        appBar: AppBar(
          title: const Text('My QR Code'),
        ),
        body: Column(
          children: [
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 60.w, vertical: 150.h),
              child: SizedBox(
                  height: 400.h,
                  width: 300.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      QrImage(
                        data: "http://www.google.com",
                        version: QrVersions.auto,
                        size: 200.w,
                      ),
                      Text(
                        name,
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
                      Wrap(spacing: 50.w, children: [
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                foregroundColor: MegaColors.lightCyan),
                            onPressed: () {},
                            child: const Text('Download')),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                foregroundColor: MegaColors.lightCyan),
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
