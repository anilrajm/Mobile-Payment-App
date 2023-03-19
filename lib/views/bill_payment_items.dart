import 'package:flutter/material.dart';
import 'package:recharge_app_mega/models/get_services_model.dart' as service;
import 'package:recharge_app_mega/views/views.dart';

import 'bill_payment.dart';

class BillPaymentItems extends StatefulWidget {
  const BillPaymentItems({Key? key}) : super(key: key);

  @override
  State<BillPaymentItems> createState() => _BillPaymentItemsState();
}

class _BillPaymentItemsState extends State<BillPaymentItems> {
  @override
  Widget build(BuildContext context) {
    //Providers.
    final loginData = Provider.of<LoginProvider>(context).loginModel.data;
    final sessionKey = loginData.sessionId;
    final userId = loginData.user.userId;
    final services = Provider.of<GetServiceProvider>(context, listen: false)
        .getServicesModel;
    //ThemeData
    final textStyle = Theme.of(context).textTheme;

    List<service.Datum> filteredData = services.data
        .where((element) =>
            element.serviceId != '1' &&
            element.serviceId != '2' &&
            element.serviceId != '10' &&
            element.serviceId != '11')
        .toList();

    //Media-query.

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 11.78.w, vertical: 5.95),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 11.78.w, top: 8.50.h),
            child: Text(
              "Utilities",
              style: textStyle.titleMedium,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: 9.81.w, right: 9.81.w, top: 8.50.h, bottom: 8.50.h),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              crossAxisSpacing: 12.w,
              shrinkWrap: true,
              childAspectRatio: 0.7,
              children: List.generate(filteredData.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BillPayment(
                                  serviceId: filteredData[index].serviceId,
                                  index: index,
                                  sessionId: sessionKey,
                                  userId: userId,
                                )));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        BillPayConstants.billPayIcons[index],
                        width: 58.90.w,
                        height: 68.h,
                      ),
                      Text(BillPayConstants.billPayTitles[index],
                          textAlign: TextAlign.center,
                          style: textStyle.bodyMedium),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
