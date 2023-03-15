import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recharge_app_mega/models/bank_list_model.dart';
import 'package:recharge_app_mega/views/views.dart';

class WalletTopUp extends StatefulWidget {
  const WalletTopUp({Key? key}) : super(key: key);

  @override
  State<WalletTopUp> createState() => _WalletTopUpState();
}

class _WalletTopUpState extends State<WalletTopUp> {
  DateTime _dateTime = DateTime.now();

  final List<String> _options = ['upi', 'bank'];
  final List<String> _titles = ['UPI Payment', 'Net Banking'];
  String? _paymentMode;

  TextEditingController topUpAmountController = TextEditingController();
  TextEditingController tranRefController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  int? _value;

  final String bankAccountIcon = 'asset/dashboardIcons/ic-bank_account.png';
  CustomButtonStyle buttonStyle = CustomButtonStyle();

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat("dd-MM-yyyy").format(_dateTime).toString();
  }

  @override
  Widget build(BuildContext context) {
    //Providers.
    var loginData = Provider.of<LoginProvider>(context, listen: false);
    var balance = loginData.loginModel.data.wallet.balance;

    //ThemeData.
    var textStyle = Theme.of(context).textTheme;
    var color = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("MegaPe Wallet"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10.w),
              width: 1.sw,
              height: 0.66.sh,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 34.03.h),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15.w,
                      ),
                      child: const Text("Balance"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w, top: 5.h),
                      child: Text(
                        "₹ $balance",
                        style: textStyle.titleLarge,
                      ),
                    ),
                    Divider(endIndent: 20.w, indent: 20.w),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 12.w, right: 12.w, top: 20.h),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        style: TextStyle(fontSize: 18.sp),
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter an amount';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16.h, horizontal: 16.w),
                            border: const OutlineInputBorder(),
                            hintText: "Enter Amount",
                            hintStyle: TextStyle(fontSize: 20.sp),
                            prefixText: "₹",
                            prefixStyle: TextStyle(fontSize: 20.sp)),
                        controller: topUpAmountController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.w, top: 22.h),
                      child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 5.0.w,
                        children: List<Widget>.generate(
                          3,
                          (int index) {
                            final List<int> amounts = [500, 1000, 2000];

                            return ChoiceChip(
                              label: Text("${amounts[index]}"),
                              selected: _value == index,
                              onSelected: (bool selected) {
                                setState(() {
                                  _value = selected ? index : null;
                                  if (selected) {
                                    topUpAmountController.text =
                                        amounts[index].toString();
                                  } else {
                                    topUpAmountController.clear();
                                  }
                                });
                              },
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 12.w, top: 10.h, bottom: 10.h),
                      child: Text(
                        'Payment Mode',
                        style: textStyle.titleMedium,
                      ),
                    ),
                    Column(
                      children: _options
                          .asMap()
                          .entries
                          .map(
                            (entry) => ListTile(
                              leading: Image.asset(
                                'asset/dashboardIcons/${entry.key == 0 ? 'ic-upi_id.png' : 'ic-bank_account.png'}',
                                width: 40.w,
                                height: 40.w,
                              ),
                              title: RadioListTile(
                                title: Text(_titles[entry.key]),
                                value: entry.value,
                                groupValue: _paymentMode,
                                onChanged: (value) {
                                  setState(() {
                                    _paymentMode = value;
                                  });
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(
                      height: 8.50.h,
                    ),
                    Center(
                      child: FilledButton(
                        onPressed: () {
                          if (_paymentMode == 'bank' &&
                              topUpAmountController.text.isNotEmpty) {
                            showModalBottomSheet(
                              enableDrag: true,
                              isDismissible: true,
                              elevation: 10,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 0.45.sh,
                                  child: FutureProvider<BankList>(
                                    initialData: BankList(
                                        status: 'loading',
                                        message: '',
                                        data: []),
                                    create: (context) => BankListProvider()
                                        .fetchBankList(
                                            sessionId: loginData
                                                .loginModel.data.sessionId,
                                            userId: loginData
                                                .loginModel.data.user.userId,
                                            amount: topUpAmountController.text,
                                            paymentMode: _paymentMode!,
                                            deviceId: loginData.deviceId,
                                            location: loginData.location),
                                    child: Consumer<BankList>(
                                        builder: (context, bankList, child) {
                                      if (bankList.status == 'loading') {
                                        return Center(
                                            child: CupertinoActivityIndicator(
                                                animating: true, radius: 20.r));
                                      } else {
                                        return ListView.separated(
                                          itemCount: bankList.data.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ListTile(
                                              enabled: true,
                                              onTap: () {
                                                Navigator.pop(context);
                                                showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    elevation: 10,
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Padding(
                                                        padding: EdgeInsets.only(
                                                            top: 20.h,
                                                            right: 20.w,
                                                            left: 20.w,
                                                            bottom:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                                bankList
                                                                    .data[index]
                                                                    .bankName,
                                                                style: textStyle
                                                                    .titleMedium),
                                                            const Divider(),
                                                            TextFormField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              controller:
                                                                  tranRefController,
                                                              decoration: InputDecoration(
                                                                  prefixIconColor:
                                                                      color
                                                                          .primary,
                                                                  prefixIcon: const Icon(
                                                                      CupertinoIcons
                                                                          .number),
                                                                  border:
                                                                      const OutlineInputBorder(),
                                                                  hintText:
                                                                      'Bank UTR Ref No.'),
                                                            ),
                                                            SizedBox(
                                                              height: 15.h,
                                                            ),
                                                            TextFormField(
                                                                onTap:
                                                                    () async {
                                                                  DateTime? newDate = await showDatePicker(
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          _dateTime,
                                                                      firstDate:
                                                                          DateTime(
                                                                              2000),
                                                                      lastDate:
                                                                          DateTime(
                                                                              2100));
                                                                  if (newDate ==
                                                                      null) {
                                                                    return;
                                                                  }
                                                                  setState(() {
                                                                    _dateTime =
                                                                        newDate;
                                                                    dateController
                                                                        .text = DateFormat(
                                                                            "dd-MM-yyyy")
                                                                        .format(
                                                                            _dateTime)
                                                                        .toString();
                                                                  });
                                                                },
                                                                keyboardType:
                                                                    TextInputType
                                                                        .datetime,
                                                                controller:
                                                                    dateController,
                                                                decoration: InputDecoration(
                                                                    prefixIconColor:
                                                                        color
                                                                            .primary,
                                                                    prefixIcon: const Icon(
                                                                        CupertinoIcons
                                                                            .calendar),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                    hintText:
                                                                        'Select Date')),
                                                            SizedBox(
                                                              height: 15.h,
                                                            ),
                                                            TextFormField(
                                                                controller:
                                                                    remarksController,
                                                                decoration: InputDecoration(
                                                                    prefixIconColor:
                                                                        color
                                                                            .primary,
                                                                    prefixIcon:
                                                                        const Icon(Icons
                                                                            .notes),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                    hintText:
                                                                        'Remarks')),
                                                            SizedBox(
                                                              height: 15.h,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                FilledButton
                                                                    .tonal(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: const Text(
                                                                            'Close')),
                                                                SizedBox(
                                                                  width: 15.w,
                                                                ),
                                                                FilledButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      showModalBottomSheet(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return SizedBox(
                                                                            height:
                                                                                0.4.sh,
                                                                            child:
                                                                                FutureProvider<LoadWalletRequest>(
                                                                              initialData: LoadWalletRequest(status: 'fetching', message: 'Your request is processing..'),
                                                                              create: (context) => LoadWalletProvider().loadWallet(
                                                                                sessionId: loginData.loginModel.data.sessionId,
                                                                                userId: loginData.loginModel.data.user.userId,
                                                                                bankId: bankList.data[index].bankId,
                                                                                paymentDate: dateController.text,
                                                                                paymentMode: _paymentMode!,
                                                                                amount: topUpAmountController.text,
                                                                                transactionRef: tranRefController.text,
                                                                                remarks: remarksController.text,
                                                                                deviceId: loginData.deviceId,
                                                                                location: loginData.location,
                                                                              ),
                                                                              child: Consumer<LoadWalletRequest>(
                                                                                builder: (context, loadWalletRequest, child) {
                                                                                  String status = loadWalletRequest.message;
                                                                                  return Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children: [
                                                                                      Image.asset(
                                                                                        status.contains('processing')
                                                                                            ? ProjectImages.walletLoadProcessing
                                                                                            : status.contains('submitted')
                                                                                                ? ProjectImages.successTick
                                                                                                : ProjectImages.failCross,
                                                                                        height: 60.h,
                                                                                        width: 60.h,
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 20.h,
                                                                                      ),
                                                                                      Text(
                                                                                        textAlign: TextAlign.center,
                                                                                        loadWalletRequest.message,
                                                                                        style: textStyle.titleMedium?.copyWith(
                                                                                          color: color.primary,
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 20.h,
                                                                                      ),
                                                                                      status.contains('processing')
                                                                                          ? const SizedBox()
                                                                                          : FilledButton(
                                                                                              onPressed: () {
                                                                                                Navigator.pop(context);
                                                                                                setState(() {
                                                                                                  tranRefController.clear();
                                                                                                  topUpAmountController.clear();
                                                                                                  dateController.clear();
                                                                                                  remarksController.clear();
                                                                                                  _value = null;
                                                                                                  _paymentMode = null;
                                                                                                });
                                                                                              },
                                                                                              child: const Text('OK'))
                                                                                    ],
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    child: const Text(
                                                                        'Submit'))
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height: 20.h)
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              },
                                              style: ListTileStyle.list,
                                              leading:
                                                  Image.asset(bankAccountIcon),
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "Account No: ${bankList.data[index].accountNumber}"),
                                                  Text(
                                                      'IFSC: ${bankList.data[index].ifscCode}'),
                                                  Text(
                                                      'Bank: ${bankList.data[index].bankName}')
                                                ],
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
                                    }),
                                  ),
                                );
                              },
                            );
                          } else if (_paymentMode == 'upi') {
                            showDialog(
                              //show confirm dialogue
                              //the return value will be from "Yes" or "No" options
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Mega Pay'),
                                content: const Text(
                                    'UPI Payment, will be available soon.'),
                                actions: [
                                  FilledButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    //return false when click on "NO"
                                    child: const Text('Okay'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        style: buttonStyle.buttonStyle(Size(0.85.sw, 47.h)),
                        child: const Text("PROCEED TO TOPUP "),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    tranRefController.dispose();
    dateController.dispose();
    remarksController.dispose();
    topUpAmountController.dispose();
    super.dispose();
  }
}
