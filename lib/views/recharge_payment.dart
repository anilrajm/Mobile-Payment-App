import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recharge_app_mega/models/get_operator_list_model.dart';
import 'package:recharge_app_mega/models/get_operator_plan_model.dart';
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

  bool _validateAllFields = false;

  bool operatorFetch = false;
  String? autoFetchOpName;
    String _selectedProvider='';

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
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = Provider.of<LoginProvider>(context, listen: false);
    var services = Provider.of<GetServiceProvider>(context, listen: false)
        .getServicesModel;
    var fetchOperator = Provider.of<FindOperatorProvider>(context);

    var transactionsProvider =
        Provider.of<TransactionHistoryProvider>(context, listen: false);

    List<service.Datum> filteredData = services.data
        .where((element) =>
            element.serviceId == '1' ||
            element.serviceId == '2' ||
            element.serviceId == '11' ||
            element.serviceId == '10')
        .toList();

    //ThemeData.
    var textStyle = Theme.of(context).textTheme;
    var color = Theme.of(context).colorScheme;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(filteredData[widget.index].serviceName),
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
                            maxLength: widget.index == 0 ? 10 : null,
                            decoration: InputDecoration(
                                labelText: labelText(widget.index)),
                            controller: _mobileNumberController,
                            onChanged: (value) async {
                              if (value.length == 10) {
                                if (filteredData[widget.index].serviceId ==
                                    "1") {
                                  operatorFetch = true;
                                  await fetchOperator.findOperator(
                                    sessionId: widget.sessionId,
                                    serviceId:
                                        filteredData[widget.index].serviceId,
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
                            validator:
                               (value) {
                                    if (value!.isNotEmpty||_validateAllFields  ) {
                                return null;
                              } else {   return 'Please enter a valid number';

                                    }
                                  }
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
                                  ],validator:  (value) {
                                if (value!=null|| _validateAllFields||_selectedProvider.isNotEmpty) {
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
                          decoration: InputDecoration(
                            suffixIcon: FilledButton(
                                onPressed: () {setState(() {
    _validateAllFields = false;
    });if(_formKey.currentState!.validate()) {

    showModalBottomSheet(
                                    enableDrag: true,
                                    isDismissible: true,
                                    elevation: 10,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: 0.5.sh,
                                        child: FutureProvider<GetOperatorPlan>(
                                            initialData: GetOperatorPlan(
                                                status: "fetching",
                                                message: "Getting plans",
                                                data: []),
                                            create: (context) =>
                                                OperatorPlanProvider()
                                                    .fetchOperatorPlan(
                                                        sessionId: widget
                                                            .sessionId,
                                                        serviceId: filteredData[
                                                                widget.index]
                                                            .serviceId,
                                                        number:
                                                            _mobileNumberController
                                                                .text,
                                                        opCode:
                                                            _selectedProvider,
                                                        userId: widget.userId,
                                                        deviceId:
                                                            deviceData.deviceId,
                                                        location: deviceData
                                                            .location),
                                            child: Consumer<GetOperatorPlan>(
                                                builder:
                                                    (context, plan, child) {
                                              return plan.status == 'fetching'
                                                  ? const Center(
                                                      child:
                                                          CupertinoActivityIndicator(),
                                                    )
                                                  : plan.status == 'success'
                                                      ? ListView.separated(
                                                          itemCount:
                                                              plan.data.length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return ListTile(
                                                              enabled: true,
                                                              onTap: () {
                                                                setState(() {
                                                                  _amountController
                                                                          .text =
                                                                      plan
                                                                          .data[
                                                                              index]
                                                                          .amount
                                                                          .toString();
                                                                  Navigator.pop(
                                                                      context);
                                                                });
                                                              },
                                                              style:
                                                                  ListTileStyle
                                                                      .drawer,
                                                              title: Text(plan
                                                                  .data[index]
                                                                  .description),
                                                              trailing: Text(
                                                                "₹${plan.data[index].amount}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: MegaColors
                                                                        .deepCyan),
                                                              ),
                                                            );
                                                          },
                                                          separatorBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return const Divider(
                                                              thickness: 1,
                                                            );
                                                          },
                                                        )
                                                      : Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                                ProjectImages
                                                                    .failCross,
                                                                height: 60.h,
                                                                width: 60.h),
                                                            SizedBox(
                                                              height: 20.h,
                                                            ),
                                                            Text(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              plan.message,
                                                              style: textStyle
                                                                  .titleMedium
                                                                  ?.copyWith(
                                                                color: color
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                            })),
                                      );
                                    },
                                  );}
                                },

                                // _showPlansBottomSheet();

                                child: const Text('Show Plans')),
                            labelText: 'Amount',
                          ),

                          controller: _amountController,
                            validator: (value) {
                              if (!_validateAllFields || value!.isNotEmpty) {
                                return null;
                              }
                              return BillPayConstants.amountValidator;
                            }
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
                              setState(() {
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
                                            status: 'fetch',
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
                                                  payment.status.contains(
                                                          ApiResponseConst
                                                              .fetchText)
                                                      ? ApiResponseConst
                                                          .loadingClock
                                                      : payment.status.contains(
                                                              ApiResponseConst
                                                                  .successText)
                                                          ? ApiResponseConst
                                                              .successIcon
                                                          : ApiResponseConst
                                                              .failIcon,
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
                                                payment.status.contains(
                                                        ApiResponseConst
                                                            .fetchText)
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
                          color: color),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  String labelText(int index) {
    String hint = '';
    switch (index) {
      case 0:
        hint = 'Phone Number';
        break;
      case 1:
        hint = 'Subscriber ID';
        break;
      case 2:
        hint = 'Connection ID';
        break;
      case 3:
        hint = 'Fastag ID';
        break;
    }

    return hint;
  }

  // Function to fetch all operators of the selected service.
  // Items in Dropdown Menu.
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

  // Function to fetch all transaction history.
  //To show in Recent payments card.

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
