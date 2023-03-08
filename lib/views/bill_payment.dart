import 'package:flutter/material.dart';
import 'package:recharge_app_mega/models/get_operator_list_model.dart';
import 'package:recharge_app_mega/models/transaction_history_model.dart';
import 'package:recharge_app_mega/views/views.dart';

class BillPayment extends StatefulWidget {
  final int index;
  final String serviceId;
  final String sessionId;
  final String userId;

  const BillPayment(
      {super.key,
      required this.index,
      required this.serviceId,
      required this.sessionId,
      required this.userId});

  @override
  State<BillPayment> createState() => _BillPaymentState();
}

class _BillPaymentState extends State<BillPayment> {
  late final Future _transactionHistoryFuture;
  final _formKey = GlobalKey<FormState>();
  late final Future myFuture;
  late String _accountNumber;
  late String _selectedProvider;

// Text editing controllers.
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController billAmountController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var deviceData = Provider.of<LoginProvider>(context, listen: false);
    // Cache future to objects to avoid multiple future method calls bu FutureBuilder.
    myFuture = getOperator(deviceData.deviceId);
    _transactionHistoryFuture = getTransactionHistory(deviceData.deviceId);
  }

  @override
  Widget build(BuildContext context) {
    //Providers.
    final billProvider =
        Provider.of<OperatorBillProvider>(context, listen: false);
    final billData = Provider.of<OperatorBillProvider>(context);
    final services = Provider.of<GetServiceProvider>(context, listen: false)
        .getServicesModel;
    var transactionsProvider =
        Provider.of<TransactionHistoryProvider>(context, listen: false);
    var deviceData = Provider.of<LoginProvider>(context, listen: false);
    //Media-query
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    //ThemeData.
    final textStyle = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(billPayTitles[widget.index]),
        ),
        body: Column(
          children: [
            Form(
                key: _formKey,
                child: buildPaymentCard(height, width, billProvider, context,
                    billData, size, textStyle, color, deviceData.deviceId)),
            Expanded(
              child: Card(
                margin: EdgeInsets.only(top: 12.h, left: 20.w, right: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, top: 10.h),
                      child: Text(
                        'Recent Payments',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: BuildTransactionHistory(
                          transactionHistoryFuture: _transactionHistoryFuture,
                          history: transactionsProvider,
                          size: size,
                          color: color),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Card buildPaymentCard(
      double height,
      double width,
      OperatorBillProvider billProvider,
      BuildContext context,
      OperatorBillProvider billData,
      Size size,
      TextTheme textStyle,
      ColorScheme color,
      String deviceId) {
    return Card(
      margin: EdgeInsets.only(top: 8.h, left: 20.w, right: 20.w),
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
                controller: accountNumberController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: MegaColors.deepCyan),
                  labelText: 'Account Number',
                ),
                onChanged: (value) {
                  setState(() {
                    _accountNumber = value;
                  });
                },
                validator: (value) {
                  if (value!.length != 10) {
                    return 'Invalid account number';
                  }
                  return null;
                }),
            SizedBox(
              height: 30.h,
            ),
            FutureBuilder(
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButtonFormField(
                      isExpanded: true,
                      menuMaxHeight: 0.5.sh,
                      hint: const Text("Providers"),
                      items: [
                        ...Provider.of<OperatorListProvider>(context,
                                listen: false)
                            .operatorListModel
                            .data
                            .map((operator) => DropdownMenuItem(
                                value: operator.opcode,
                                child: Text(
                                  operator.opname,
                                  overflow: TextOverflow.ellipsis,
                                )))
                            .toList()
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedProvider = value!;
                        });
                      });
                }
                return const CupertinoActivityIndicator();
              },
              future: myFuture,
            ),
            SizedBox(
              height: 30.h,
            ),
            TextFormField(
                controller: billAmountController,
                decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(8.0.h),
                      child: FilledButton(
                        onPressed: () async {
                          await billProvider.fetchOperatorBill(
                              sessionId: widget.sessionId,
                              serviceId: widget.serviceId,
                              consumerNumber: accountNumberController.text,
                              opCode: _selectedProvider,
                              userId: widget.userId,
                              deviceId: deviceId);
                          if (context.mounted &&
                              billData.operatorBillModel.status == "info") {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text("Bill Data"),
                                content:
                                    Text(billData.operatorBillModel.message),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text("Ok"),
                                  ),
                                ],
                              ),
                            );
                          }

                          setState(() {
                            billAmountController.text =
                                billData.operatorBillModel.status;
                          });
                        },
                        child: Text('Fetch Bill'),
                      ),
                    ),
                    hintText: 'Amount'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the amount';
                  }
                  return null;
                }),
            SizedBox(
              height: 30.h,
            ),
            FilledButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(5.r)),
                  minimumSize: Size(425.45.h, 51.0536.w),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 0.4.sh,
                          child: FutureProvider<ProcessPayment>(
                            initialData: ProcessPayment(
                                status: 'fetching',
                                message: 'Recharge processing...'),
                            create: (context) => ProcessPaymentProvider()
                                .processPaymentService(
                                    sessionId: widget.sessionId,
                                    userId: widget.userId,
                                    serviceId: widget.serviceId,
                                    number: accountNumberController.text,
                                    opCode: _selectedProvider,
                                    amount: billAmountController.text,
                                    deviceId: deviceId),
                            child: Consumer<ProcessPayment>(
                              builder: (context, payment, child) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'asset/icons/${payment.message.contains('processing') ? 'sendMoney.png' : 'check_mark_green.png'}',
                                      height: 60.h,
                                      width: 60.h,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      payment.message,
                                      style: textStyle.titleMedium?.copyWith(
                                        color: color.primary,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    payment.message.contains('processing')
                                        ? SizedBox()
                                        : FilledButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Ok'))
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                child: Text(
                  "Pay Bill",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  Future<GetOperatorList> getOperator(String deviceId) {
    var operators = Provider.of<OperatorListProvider>(context, listen: false)
        .fetchOperatorList(
            sessionId: widget.sessionId,
            serviceId: widget.serviceId,
            userId: widget.userId,
            deviceId: deviceId);
    return operators;
  }

  Future<TransactionHistory> getTransactionHistory(String deviceId) async {
    var loginData =
        Provider.of<LoginProvider>(context, listen: false).loginModel.data;
    var sessionId = loginData.sessionId;
    var userId = loginData.user.userId;

    var transactionHistory =
        Provider.of<TransactionHistoryProvider>(context, listen: false);
    var historyFuture = await transactionHistory.fetchTransactionHistory(
        sessionId: sessionId, userId: userId, deviceId: deviceId);
    return historyFuture;
  }

  @override
  void dispose() {
    billAmountController.dispose();
    accountNumberController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
