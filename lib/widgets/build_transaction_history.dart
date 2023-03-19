import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';

class BuildTransactionHistory extends StatelessWidget {
  const BuildTransactionHistory({
    super.key,
    required Future transactionHistoryFuture,
    required this.history,
    required this.color,
  }) : _transactionHistoryFuture = transactionHistoryFuture;

  final Future _transactionHistoryFuture;
  final TransactionHistoryProvider history;
  final ColorScheme color;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _transactionHistoryFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CupertinoActivityIndicator(
            radius: 18.r,
            animating: true,
            color: MegaColors.deepCyan,
          ));
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                var status =
                    history.transactionHistory.data[index].rechargeStatus;
                var transaction = history.transactionHistory.data[index];
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                          minVerticalPadding: 12.h,
                          title: Text(transaction.companyName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Company ID: ${transaction.companyId}'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text('Mobile No: ${transaction.mobileNo}')
                            ],
                          ),
                          trailing: Text(
                            '₹${transaction.amount}',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10.w, bottom: 10.h, right: 10.w),
                        child: Row(children: [
                          SizedBox(
                            width: 5.89.w,
                          ),
                          Text(
                            "Date: ${transaction.rechargeDate}",
                          ),
                          const Spacer(),
                          if (status == "Pending")
                            Text(
                              '$status 🕐',
                              style: TextStyle(
                                  color: color.primary,
                                  fontWeight: FontWeight.bold),
                            )
                          else
                            status == "Success"
                                ? Text('$status ✅',
                                    style: const TextStyle(
                                        color: MegaColors.successGreen,
                                        fontWeight: FontWeight.bold))
                                : Text('$status ❗',
                                    style: TextStyle(
                                        color: color.error,
                                        fontWeight: FontWeight.bold))
                        ]),
                      )
                    ],
                  ),
                );
              },
              itemCount: history.transactionHistory.data.length,
            );
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }
}
