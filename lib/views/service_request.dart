import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';

class TicketSupport extends StatefulWidget {
  const TicketSupport({Key? key}) : super(key: key);

  @override
  State<TicketSupport> createState() => _TicketSupportState();
}

class _TicketSupportState extends State<TicketSupport> {
  final _emailIDController = TextEditingController();
  final _transactionIDController = TextEditingController();
  final _requestDetails = TextEditingController();

  CustomButtonStyle buttonStyle=CustomButtonStyle();

  late String emailID;
  late String transactionNO;
  String? requestDetails;

  @override
  @override
  Widget build(BuildContext context) {
    //Media-query.
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Service Request'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
                SizedBox(
                height: 50.h,
              ),
              Padding(
                padding:   EdgeInsets.all(20.w),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Email ID',
                      filled: true,
                      border: InputBorder.none),
                  controller: _emailIDController,
                ),
              ),
              Padding(
                padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Transaction ID/ Reference Number',
                      filled: true,
                      border: InputBorder.none),
                  controller: _transactionIDController,
                ),
              ),
              Padding(
                padding:
                     EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: TextFormField(
                  maxLines: 15,
                  decoration: const InputDecoration(
                      hintText: 'Additional details',
                      filled: true,
                      border: InputBorder.none,
                      labelStyle: TextStyle()),
                  controller: _requestDetails,
                ),
              ),
              Padding(
                padding:   EdgeInsets.all(20.w),
                child: FilledButton(
                    style: buttonStyle.buttonStyle(Size(1.1.sw, 47.h)),
                    onPressed: () {
                      setState(() {
                        emailID = _emailIDController.text;
                        transactionNO = _transactionIDController.text;
                        requestDetails = _requestDetails.text;
                      });
                    },
                    child:   Text(
                      'Submit',
                      style:
                          TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailIDController.dispose();
    _requestDetails.dispose();
    _transactionIDController.dispose();
    super.dispose();
  }
}
