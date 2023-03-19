import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recharge_app_mega/models/get_operator_bill_model.dart';
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
  bool _validateAllFields = false;
  final _formKey = GlobalKey<FormState>();
  late final Future myFuture;

    String _selectedProvider='';

// Text editing controllers.
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController billAmountController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var deviceData = Provider.of<LoginProvider>(context, listen: false);

    // Cache future to objects to avoid multiple future method calls by FutureBuilder.
    myFuture = getOperator(
        deviceId: deviceData.deviceId, location: deviceData.location);
    _transactionHistoryFuture = getTransactionHistory(
        deviceId: deviceData.deviceId, location: deviceData.location);
  }

  @override
  Widget build(BuildContext context) {

    var transactionsProvider = Provider.of<TransactionHistoryProvider>(context, listen: false);
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
          title: Text(BillPayConstants.billPayTitles[widget.index]),
        ),
        body: Column(
          children: [
            Form(
                key: _formKey,
                child: buildPaymentCard(
                    height: height,
                    width: width,
                    context: context,
                    size: size,
                    textStyle: textStyle,
                    color: color,
                    deviceId: deviceData.deviceId,
                    location: deviceData.location)),
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
                        BillPayConstants.recentPaymentsText,
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
      {required double height,
      required double width,
      required BuildContext context,
      required Size size,
      required TextTheme textStyle,
      required ColorScheme color,
      required String deviceId,
      required String location}) {
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
                  labelText: BillPayConstants.accountNumFieldLabel,
                ),
                validator: (value) {
                  if (value!.isNotEmpty||_validateAllFields  ) {
                    return null;
                  }
                  return BillPayConstants.accountNumValidator;
                },),
            SizedBox(
              height: 30.h,
            ),
            FutureBuilder(
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButtonFormField(
                      isExpanded: true,
                      menuMaxHeight: 0.5.sh,
                      hint: const Text(BillPayConstants.providerDropdownHint),
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
                      ],validator:  (value) {
                if (value!=null|| _validateAllFields) {
                return null;
                } else {
                return 'Please select a provider';
                }
                },
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
                        onPressed: () { setState(() {
                          _validateAllFields = false;
                        });if(_formKey.currentState!.validate()) {

                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 0.3.sh,
                                  child: FutureProvider<GetOperatorBill>(
                                      create: (create) => OperatorBillProvider()
                                          .fetchOperatorBill(
                                          sessionId: widget.sessionId,
                                          serviceId: widget.serviceId,
                                          consumerNumber:
                                          accountNumberController.text,
                                          opCode: _selectedProvider,
                                          userId: widget.userId,
                                          deviceId: deviceId,
                                          location: location),
                                      initialData: GetOperatorBill(
                                          status: ApiResponseConst.fetchText,
                                          message: 'fetching bill',
                                          data: []),
                                      child: Consumer<GetOperatorBill>(
                                          builder: (context, bill, child) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  bill.status == ApiResponseConst.fetchText ? ApiResponseConst.loadingClock : bill.status == ApiResponseConst.successText ? ApiResponseConst.successIcon : ApiResponseConst.failIcon,
                                                  height: 60.h,
                                                  width: 60.w,
                                                ),      SizedBox(
                                                  height: 20.h,
                                                ), Text(
                                                  textAlign: TextAlign.center,
                                                  bill.message,
                                                  style: textStyle.titleMedium
                                                      ?.copyWith(
                                                    color: color.primary,
                                                  ),
                                                ),            SizedBox(height: 20.h),
                                                bill.status==ApiResponseConst.fetchText?SizedBox():

                                                FilledButton(
                                                    onPressed: () {if(bill.status==ApiResponseConst.successText){
                                                      setState(() {
                                                        accountNumberController.text=bill.data[0].billAmount;
                                                      });

                                                    } //ToDo: Assign amount to the amountController.text
                                                    Navigator.pop(
                                                        context);
                                                    },
                                                    child:   Text(bill.status==ApiResponseConst.successText?'Pay':'OK'))
                                              ],
                                            );
                                          })),
                                );
                              });   }
                        },
                        child: const Text(BillPayConstants.fetchBillButtonText),
                      )),
                  hintText: BillPayConstants.amountFieldHint,
                ),
                validator: (value) {
                  if (!_validateAllFields || value!.isNotEmpty) {
                    return null;
                  }
                  return BillPayConstants.amountValidator;
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
                onPressed: () { setState(() {
                  _validateAllFields = true;
                });
                  if (_formKey.currentState!.validate()) {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 0.4.sh,
                          child: FutureProvider<ProcessPayment>(
                            initialData: ProcessPayment(
                                status: BillPayConstants.fetchingStatus,
                                message: BillPayConstants.processingMessage),
                            create: (context) => ProcessPaymentProvider()
                                .processPaymentService(
                                    sessionId: widget.sessionId,
                                    userId: widget.userId,
                                    serviceId: widget.serviceId,
                                    number: accountNumberController.text,
                                    opCode: _selectedProvider,
                                    amount: billAmountController.text,
                                    deviceId: deviceId,
                                    location: location),
                            child: Consumer<ProcessPayment>(
                              builder: (context, payment, child) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      payment.message.contains(
                                              BillPayConstants.processingText)
                                          ? ProjectImages.walletLoadProcessing
                                          : ProjectImages.successTick,
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
                                    payment.message.contains(
                                            BillPayConstants.processingText)
                                        ? const SizedBox()
                                        : FilledButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                                BillPayConstants.okButtonText))
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
                  BillPayConstants.payButtonText,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  Future<GetOperatorList> getOperator(
      {required String deviceId, required String location}) {
    var operators = Provider.of<OperatorListProvider>(context, listen: false)
        .fetchOperatorList(
            sessionId: widget.sessionId,
            serviceId: widget.serviceId,
            userId: widget.userId,
            deviceId: deviceId,
            location: location);
    return operators;
  }

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

  @override
  void dispose() {
    billAmountController.dispose();
    accountNumberController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
