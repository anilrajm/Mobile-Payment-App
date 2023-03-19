import 'package:flutter/material.dart';
import 'package:recharge_app_mega/models/transaction_history_model.dart';
import 'package:recharge_app_mega/views/views.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  late final Future _transactionHistoryFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var deviceData = Provider.of<LoginProvider>(context, listen: false);
    _transactionHistoryFuture = getTransactionHistory(
        deviceId: deviceData.deviceId, location: deviceData.location);
  }

// Dummy DropDownMenu Items
  final List<String> monthItems = [
    'This Month',
    'jan',
    'feb',
    'March',
    'April',
    'May',
    'Jun'
  ];

  final List<String> categoryItems = [
    'All',
    'Mobile',
    'DTH',
    'Gas',
    'Insurance'
  ];

  final List<String> filterItems = [
    'Today',
    'Yesterday',
    'Last 7 days',
    'Last 30 days',
    'Last 6 months'
  ];

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).colorScheme;
    var history =
        Provider.of<TransactionHistoryProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 17.018.h),
        Padding(
          padding: EdgeInsets.all(8.0.w),
          child: TextFormField(
            decoration: InputDecoration(
                hintText: "Search",
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                border: const OutlineInputBorder()),
          ),
        ),

//DropDownMenus.
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildDropdownButtonTransaction('This Month', monthItems),
            buildDropdownButtonTransaction('All', categoryItems),
            buildDropdownButtonTransaction('Today', filterItems),
          ],
        ),

        Expanded(
          child: BuildTransactionHistory(
              transactionHistoryFuture: _transactionHistoryFuture,
              history: history,

              color: color),
        ),
      ],
    );
  }

  DropdownButton<String> buildDropdownButtonTransaction(
      String value, List<String> items) {
    return DropdownButton<String>(
      value: value,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (_) {},
    );
  }

// Transaction history fetch function
  Future<TransactionHistory> getTransactionHistory(
      {required String deviceId, required String location}) async {
    var loginData =
        Provider.of<LoginProvider>(context, listen: false).loginModel.data;
    var sessionId = loginData.sessionId;
    var userId = loginData.user.userId;

    var transactionHistory =
        Provider.of<TransactionHistoryProvider>(context, listen: false);
    var historyFuture = await transactionHistory.fetchTransactionHistory(
        sessionId: sessionId,
        userId: userId,
        deviceId: deviceId,
        location: location);
    return historyFuture;
  }
}
