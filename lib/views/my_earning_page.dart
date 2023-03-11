import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';

class MyEarningsPage extends StatefulWidget {
  const MyEarningsPage({Key? key}) : super(key: key);

  @override
  State<MyEarningsPage> createState() => _MyEarningsPageState();
}

List<String> earnings = [
  'Money Transfer',
  'Banking',
  'Cash Services',
  'Recharges',
  'Bill Payments',
  'Healthcare and Insurance',
  'Micro-ATM',
  'Gold',
  'Promotions, incentives and others'
];
List<double> amount = [
  12.65,
  62.00,
  52.36,
  2652.00,
  45,
  0.00,
  465.00,
  356.25,
  35.00
];



class _MyEarningsPageState extends State<MyEarningsPage> {
  @override

  Widget build(BuildContext context) {
    //Providers
    final loginData=Provider.of<LoginProvider>(context,listen:false);

    double totalAmount = amount.reduce((value, element) => value + element);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding:   EdgeInsets.only(right: 10.w),
            child: IconButton(
                tooltip: "How my earnings are calculate",
                onPressed: () {Navigator.push(context,MaterialPageRoute(builder:(context)=>const EarningsFAQ()));},
                icon:   Icon(
                  Icons.info,
                  size: 30.w,
                )),
          )
        ],
        elevation: 0,
        title: const Text("My Earnings"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration:   BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r)),
                gradient: const LinearGradient(
                    colors: [
                   MegaColors.lightCyan,
                    MegaColors.deepCyan,
                    ],
                    begin: Alignment.bottomRight,
                    end: FractionalOffset.topRight)),
            width: double.infinity,
            height: 170.18.h,
            child: Padding(
              padding:     EdgeInsets.only(top: 25.h, left: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                    "Welcome back,",
                    style: TextStyle(color: Colors.white70, fontSize: 28.sp),
                  ),
                  Padding(
                    padding:   EdgeInsets.only(left: 8.w, top: 8.h),
                    child: Text(
                    loginData.loginModel.data.org.name,
                      style:   TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 220.w),
                    child:   Text(
                      "Your Earning's",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 190.w, top: 2.55.h),
                    child: Text("₹ ${loginData.loginModel.data.wallet.balance}",
                      style:   TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
            Padding(
            padding: EdgeInsets.all(8.0.w),
            child: const Text(
              "PRODUCT WISE (JANUARY GROSS EARNINGS)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MegaColors.deepCyan,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: earnings.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(
                        vertical: 5.95.h,
                        horizontal: 11.78.w),
                    child: Container(
                      margin: EdgeInsets.only(left: 19.63.w),
                      height: 85.09.h,
                      child: Row(
                        children: [
                          Container(
                            height: double.infinity,
                            width: 180.w,
                            color:
                                index % 2 == 0 ? MegaColors.lightCyan : Colors.blueGrey,
                            child: Center(
                              child: Text(earnings[index],
                                  style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                  textAlign: TextAlign.center),
                            ),
                          ),SizedBox(width: 54.98.w),
                          amount[index]!=0?    Text(
                            '₹ ${amount[index]}',style:   TextStyle(
                            fontSize: 18.sp
                          ),
                          ):Text( '₹ ${amount[index]}',style:   TextStyle(
                              fontSize: 18.sp,color: Colors.blueAccent
                          ))
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
