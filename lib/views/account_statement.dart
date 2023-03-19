import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'views.dart';

class AccountStatement extends StatefulWidget {
  const AccountStatement({Key? key}) : super(key: key);

  @override
  State<AccountStatement> createState() => _AccountStatementState();
}

class _AccountStatementState extends State<AccountStatement> {
  late final Future ledgerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var loginData = Provider.of<LoginProvider>(context, listen: false);
    var sessionId = loginData.loginModel.data.sessionId;
    var userId = loginData.loginModel.data.user.userId;
    ledgerFuture = getLedgerData(
        sessionId: sessionId,
        userId: userId,
        deviceId: loginData.deviceId,
        location: loginData.location);
  }

  @override
  Widget build(BuildContext context) {
    //Providers.
    var loginData = Provider.of<LoginProvider>(context, listen: false);
    var ledger = Provider.of<LedgerDataProvider>(context, listen: false);
    //ThemeData.
    TextTheme textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AccountStatementConstants.appbarTitle),
      ),
      body: Column(children: [
        Card(
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 11.w),
          child: Container(
            margin: EdgeInsets.only(left: 20.w),
            height: 80.h,
            child: Row(
              children: [
                Container(
                  height: double.infinity,
                  width: 150.w,
                  color: MegaColors.lightCyan,
                  child: Center(
                    child: Text(AccountStatementConstants.balanceTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                        ),
                        textAlign: TextAlign.center),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text("₹ ${loginData.loginModel.data.wallet.balance}",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: FutureBuilder(
                future: ledgerFuture,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CupertinoActivityIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(
                          child: Text(AccountStatementConstants.errorText));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: ledger.ledgerData.data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    minVerticalPadding: 12.h,
                                    title: Text(ledger
                                        .ledgerData.data[index].description),
                                    subtitle: Padding(
                                      padding: EdgeInsets.only(top: 8.h),
                                      child: Text(
                                        "${AccountStatementConstants.transactionLabel} ${ledger.ledgerData.data[index].paymentId}",
                                      ),
                                    ),

                                    trailing: ledger.ledgerData.data[index]
                                                .credit ==
                                            AccountStatementConstants
                                                .ledgerCheck
                                        ? buildDebitText(
                                            ledger, index) // Debit text in red.
                                        : buildCreditText(ledger,
                                            index), // Credit text in green.
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 18.w, bottom: 10.h, right: 16.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            '${AccountStatementConstants.dateText} ${DateFormat(AccountStatementConstants.dateFormat).format(ledger.ledgerData.data[index].txnDate)}',
                                            style: textStyle.bodyMedium),
                                        Text(
                                          '${AccountStatementConstants.rupeeSign} ${ledger.ledgerData.data[index].balance}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    } else {
                      return const Text(AccountStatementConstants.emptyDataText);
                    }
                  } else {
                    return Text('${AccountStatementConstants.stateText} ${snapshot.connectionState}');
                  }
                }),
          ),
        ),
      ]),
    );
  }

  Text buildCreditText(LedgerDataProvider ledger, int index) {
    return Text(
      "+ ${ledger.ledgerData.data[index].credit}",
      style: TextStyle(
          color: Colors.green, fontSize: 15.sp, fontWeight: FontWeight.bold),
    );
  }

  Text buildDebitText(LedgerDataProvider ledger, int index) {
    return Text(
      "- ${ledger.ledgerData.data[index].debit}",
      style: TextStyle(
          color: Colors.red, fontSize: 15.sp, fontWeight: FontWeight.bold),
    );
  }

  Future<LedgerData> getLedgerData(
      {required String sessionId,
      required String userId,
      required String deviceId,
      required String location}) {
    var ledger = Provider.of<LedgerDataProvider>(context, listen: false)
        .fetchLedgerData(
            sessionId: sessionId,
            userId: userId,
            deviceId: deviceId,
            location: location);
    return ledger;
  }
}
