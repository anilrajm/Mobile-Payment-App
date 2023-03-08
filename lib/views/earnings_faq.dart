import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';

String que1 = 'What is the earnings section?';
String ans1 ='It gives the overall gross commission earned over the given time frame. For example. Your gross monthly earnings are displayed for you to analyse and make a conscious call to improve your earnings.';


String que2 = 'How is the earnings calculated? ';
String ans2 = 'Our systems calculate the earnings for the day at end of the business day and then update the same.';


String que3 = 'How is the daily earnings calculated? ';
String ans3 = 'The earnings are calculated at the end of the day and displayed the next day.';

String que4 = 'How is the weekly earnings calculated?';
String ans4 =  'The daily earnings are calculated at the end of the day and added to the weekly report. The week starts from Monday and ends on Sunday.';


String que5 = 'How is the monthly earnings calculated?';
String ans5 ='The daily earnings are calculated at the end of the day and added to the monthly report. The month starts from the 1st and ends on the last day of the month.';


String que6 = 'Why can\'t I see today\'s earnings?';
String ans6 =  'Earnings are calculated at the end of the day for the full day. We will be coming up with today\'s earnings data shortly. Please check this space for updates.';


String que7 = 'Why can\'t I see my monthly average earnings?';

String ans7 =  'We need time to calculate the earnings. The only reason you are not able to see the earnings is you are new to our system. We need at least 3months data to give you an accurate monthly average.';


String que8 = 'Why can\'t I see my weekly average earnings?';

String ans8 = 'We need time to calculate the earnings. The only reason you are not able to see the earnings is you are new to our system. We need at least 2 weeks data to give you an accurate weekly average.';


String que9 = 'Why can\'t I see my daily average earnings?';

String ans9 = 'We need time to calculate the earnings. The only reason you are not able to see the earnings is you are new to our system. We need at least 2 weeks data to give you an accurate weekly average.';
int c=1;

Column printData(String que, String ans) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        que,
        style:   TextStyle(
            fontWeight: FontWeight.bold, fontSize: 15.sp),
      ),
      SizedBox(
        height: 3.h,
      ),
      Text(
        ans,
        style:   TextStyle(fontSize: 15.sp),
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
          title: const Text("Frequently asked questions?"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding:   EdgeInsets.all(15.h),
              child: Column(children: [
                printData(que1, ans1),
                printData(que2, ans2),
                printData(que3, ans3),
                printData(que4, ans4),
                printData(que5, ans5),
                printData(que6, ans6),
                printData(que7, ans7),
                printData(que8, ans8),
                printData(que9, ans9),
              ]),
            )));
  }
}
