import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';

class BrandLogo extends StatefulWidget {
  const BrandLogo({Key? key}) : super(key: key);

  @override
  State<BrandLogo> createState() => _BrandLogoState();
}

class _BrandLogoState extends State<BrandLogo> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Positioned(
        top: 8.50.h,
        left: 11.78.w,
        child: Card(
          elevation: 5,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(200)),
              color: MegaColors.lightCyan,
            ),
            height: 42.54.h,
            width: 43.19.w,
            child: Image.asset(MegaBrand.brandLogo),
          ),
        ));
  }
}
