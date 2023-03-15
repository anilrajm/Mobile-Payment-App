import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recharge_app_mega/models/get_operator_list_model.dart';
import 'package:recharge_app_mega/models/get_services_model.dart' as service;
import 'package:recharge_app_mega/models/transaction_history_model.dart';
import 'package:recharge_app_mega/views/views.dart';

class RechargePayment extends StatefulWidget {
  final int index;
  final String serviceId;
  final String sessionId;
  final String userId;

  const RechargePayment(
      {super.key,
      required this.index,
      required this.serviceId,
      required this.sessionId,
      required this.userId});

  @override
  State<RechargePayment> createState() => _RechargePaymentState();
}

class _RechargePaymentState extends State<RechargePayment> {
  late final Future _transactionHistoryFuture;
  late final Future myFuture;
  late String _phoneNumber;
  late String _amount;
  late String _hintText;
  late String _submitText;
  late String _labelText;
  late String _dropHint;
  bool operatorFetch = false;
  String? autoFetchOpName;
  late String _selectedProvider;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var deviceData = Provider.of<LoginProvider>(context, listen: false);
    myFuture = getOperator(
        deviceId: deviceData.deviceId, location: deviceData.location);
    _transactionHistoryFuture = getTransactionHistory(
        deviceId: deviceData.deviceId, location: deviceData.location);
    switch (widget.index) {
      case 0:
        _dropHint = 'Operator';
        _hintText = 'Enter phone number to recharge';
        _labelText = 'Phone Number';

        break;
      case 1:
        _dropHint = 'DTH Providers';
        _hintText = 'Enter subscriber ID to recharge';
        _labelText = 'Subscriber ID';

        break;
      case 2:
        _dropHint = 'Operators';
        _hintText = 'Enter connection ID to recharge';
        _labelText = 'Connection ID';

        break;
      case 3:
        _dropHint = 'Operators';
        _hintText = 'Enter data card number to recharge';
        _labelText = 'Fastag ID';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = Provider.of<LoginProvider>(context, listen: false);
    var services = Provider.of<GetServiceProvider>(context, listen: false)
        .getServicesModel;
    var fetchOperator = Provider.of<FindOperatorProvider>(context);

    var plansProvider =
        Provider.of<OperatorPlanProvider>(context, listen: false);
    var transactionsProvider =
        Provider.of<TransactionHistoryProvider>(context, listen: false);

    List<service.Datum> _filteredData = services.data
        .where((element) =>
            element.serviceId == '1' ||
            element.serviceId == '2' ||
            element.serviceId == '11' ||
            element.serviceId == '10')
        .toList();
    //Media-query.
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    //ThemeData.
    var textStyle = Theme.of(context).textTheme;
    var color = Theme.of(context).colorScheme;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(_filteredData[widget.index].serviceName),
        ),
        body: Column(
          children: [
            Form(
                key: _formKey,
                child: Card(
                  margin: EdgeInsets.all(19.63.w),
                  child: Padding(
                    padding: EdgeInsets.all(15.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: _labelText),
                          controller: _mobileNumberController,
                          onChanged: (value) async {
                            if (value.length == 10) {
                              if (_filteredData[widget.index].serviceId ==
                                  "1") {
                                operatorFetch = true;
                                await fetchOperator.findOperator(
                                  sessionId: widget.sessionId,
                                  serviceId:
                                      _filteredData[widget.index].serviceId,
                                  number: _mobileNumberController.text,
                                  userId: widget.userId,
                                  deviceId: deviceData.deviceId,
                                  location: deviceData.location,
                                );
                                operatorFetch = false;
                                setState(() {
                                  _selectedProvider = fetchOperator
                                      .findOperatorModel!.data.opcode;
                                  autoFetchOpName = fetchOperator
                                      .findOperatorModel!.data.opname;
                                });
                                if (kDebugMode) {
                                  print(_selectedProvider);
                                }
                              }
                            }
                          },
                          validator: (value) {
                            if (value!.length != 10) {
                              return 'Invalid mobile number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        FutureBuilder(
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              return DropdownButtonFormField(
                                  menuMaxHeight: 0.5.sh,
                                  isExpanded: true,
                                  hint: operatorFetch
                                      ? const CupertinoActivityIndicator()
                                      : Text(autoFetchOpName ?? "Providers"),
                                  items: [
                                    ...Provider.of<OperatorListProvider>(
                                            context,
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
                          decoration: InputDecoration(
                            suffixIcon: FilledButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    enableDrag: true,
                                    isDismissible: true,
                                    elevation: 10,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: 0.5.sh,
                                        child: FutureBuilder(
                                          builder: (BuildContext context,
                                              AsyncSnapshot<dynamic> snapshot) {
                                            if (snapshot.hasData) {
                                              return ListView.separated(
                                                itemCount: plansProvider
                                                    .operatorPlanModel
                                                    .data
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return ListTile(
                                                    enabled: true,
                                                    onTap: () {
                                                      setState(() {
                                                        _amountController.text =
                                                            plansProvider
                                                                .operatorPlanModel
                                                                .data[index]
                                                                .amount
                                                                .toString();
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    style: ListTileStyle.drawer,
                                                    title: Text(plansProvider
                                                        .operatorPlanModel
                                                        .data[index]
                                                        .description),
                                                    trailing: Text(
                                                      "₹${plansProvider.operatorPlanModel.data[index].amount}",
                                                      style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: MegaColors
                                                              .deepCyan),
                                                    ),
                                                  );
                                                },
                                                separatorBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return const Divider(
                                                    thickness: 1,
                                                  );
                                                },
                                              );
                                            }
                                            return Center(
                                              child: CupertinoActivityIndicator(
                                                  animating: true,
                                                  radius: 20.r),
                                            );
                                          },
                                          future:
                                              plansProvider.fetchOperatorPlan(
                                                  sessionId: widget.sessionId,
                                                  serviceId: _filteredData[
                                                          widget.index]
                                                      .serviceId,
                                                  number:
                                                      _mobileNumberController
                                                          .text,
                                                  opCode: _selectedProvider,
                                                  userId: widget.userId,
                                                  deviceId: deviceData.deviceId,
                                                  location:
                                                      deviceData.location),
                                        ),
                                      );
                                    },
                                  );
                                },

                                // _showPlansBottomSheet();

                                child: const Text('Show Plans')),
                            labelText: 'Amount',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the amount';
                            }
                            return null;
                          },
                          controller: _amountController,
                          onChanged: (value) {
                            setState(() {
                              _amount = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        SizedBox(
                          width: 7.85.w,
                        ),
                        FilledButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(5.r)),
                              minimumSize: Size(0.5.sh, 0.13.sw),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 2.5.sh,
                                      child: FutureProvider<ProcessPayment>(
                                        initialData: ProcessPayment(
                                            status: 'fetching',
                                            message: 'Recharge processing...'),
                                        create: (context) =>
                                            ProcessPaymentProvider()
                                                .processPaymentService(
                                                    sessionId: widget.sessionId,
                                                    userId: widget.userId,
                                                    serviceId: widget.serviceId,
                                                    number:
                                                        _mobileNumberController
                                                            .text,
                                                    opCode: _selectedProvider,
                                                    amount:
                                                        _amountController.text,
                                                    deviceId:
                                                        deviceData.deviceId,
                                                    location:
                                                        deviceData.location),
                                        child: Consumer<ProcessPayment>(
                                          builder: (context, payment, child) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'asset/icons/${payment.message.contains('processing') ? 'sendMoney.png' : 'check_mark_green.png'}',
                                                  height: 60.h,
                                                  width: 60.w,
                                                ),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  payment.message,
                                                  style: textStyle.titleMedium
                                                      ?.copyWith(
                                                    color: color.primary,
                                                  ),
                                                ),
                                                SizedBox(height: 20.h),
                                                payment.message
                                                        .contains('processing')
                                                    ? const SizedBox()
                                                    : FilledButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text('Ok'))
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
                              "Recharge",
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                )),
            Expanded(
              child: Card(
                margin: EdgeInsets.all(19.63.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.509.w),
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
    _mobileNumberController.dispose();
    _amountController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
