import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';

Column printData(String que, String ans) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        que,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
      ),
      SizedBox(
        height: 3.h,
      ),
      Text(
        ans,
        style: TextStyle(fontSize: 15.sp),
      ),
      SizedBox(
        height: 10.h,
      )
    ],
  );
}

class EarningsFAQ extends StatelessWidget {
  const EarningsFAQ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:   const Text(FAQConstants.appbarTitle),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(15.h),
          child: Column(children:   [
            printData(FAQConstants.que1, FAQConstants.ans1),
            printData(FAQConstants.que2, FAQConstants.ans2),
            printData(FAQConstants.que3, FAQConstants.ans3),
            printData(FAQConstants.que4, FAQConstants.ans4),
            printData(FAQConstants.que5, FAQConstants.ans5),
            printData(FAQConstants.que6, FAQConstants.ans6),
            printData(FAQConstants.que7, FAQConstants.ans7),
            printData(FAQConstants.que8, FAQConstants.ans8),
            printData(FAQConstants.que9, FAQConstants.ans9),
          ]),
        )));
  }
}
