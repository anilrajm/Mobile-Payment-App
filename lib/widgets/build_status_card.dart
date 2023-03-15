import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';

class BuildStatusCards extends StatelessWidget {
  const BuildStatusCards({
    super.key,
    required this.statusCount,
    required this.labelText,
    required this.labelTextColor,
  });

  final String statusCount;
  final String labelText;
  final Color labelTextColor;

  @override
  Widget build(BuildContext context) {
    //Media-query.
    final size=MediaQuery.of(context).size;

    return Card(
      child: SizedBox(
        width: 0.27.sw,
        height:  0.07.sh,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 8.50.h),
            Text(
              labelText,
              style:
              TextStyle(fontWeight: FontWeight.bold, color: labelTextColor),
            ),
            Text(statusCount)
          ],
        ),
      ),
    );
  }
}
