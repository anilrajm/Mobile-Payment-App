import 'package:flutter/material.dart';
import 'package:recharge_app_mega/models/master_data_model.dart';
import 'package:recharge_app_mega/models/service_request_model.dart';
import 'package:recharge_app_mega/networking/api_request.dart';
import 'package:recharge_app_mega/views/views.dart';

class TicketSupport extends StatefulWidget {
  const TicketSupport({Key? key}) : super(key: key);

  @override
  State<TicketSupport> createState() => _TicketSupportState();
}

class _TicketSupportState extends State<TicketSupport> {
  String _selectedTopic = ' ';

  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  CustomButtonStyle buttonStyle = CustomButtonStyle();

  @override
  @override
  Widget build(BuildContext context) {
    //ThemeData.
    var textStyle = Theme.of(context).textTheme;
    var color = Theme.of(context).colorScheme;

    LoginProvider loginData =
        Provider.of<LoginProvider>(context, listen: false);
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
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: FutureProvider<MasterData>(
                    create: (context) => MasterDataProvider().fetchMasterData(
                        dataType: MasterDataType.serviceRequest,
                        dataSubType: MasterDataSubType.serviceRequest),
                    initialData:
                        MasterData(status: 'loading', message: '', data: []),
                    child: Consumer<MasterData>(
                        builder: (context, request, child) {
                      return DropdownButtonFormField(
                          isExpanded: true,
                          icon: const FaIcon(FontAwesomeIcons.caretDown),
                          menuMaxHeight: 0.5.sh,
                          decoration: const InputDecoration(
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Topic",
                          ),
                          items: [
                            ...request.data
                                .map((topic) => DropdownMenuItem(
                                    value: topic.value,
                                    child: Text(
                                      topic.code,
                                      overflow: TextOverflow.ellipsis,
                                    )))
                                .toList()
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedTopic = value!;
                            });
                          });
                    })),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Subject',
                      filled: true,
                      border: InputBorder.none),
                  controller: _subjectController,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: TextFormField(
                  maxLines: 15,
                  decoration: const InputDecoration(
                      hintText: 'Message',
                      filled: true,
                      border: InputBorder.none,
                      labelStyle: TextStyle()),
                  controller: _messageController,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: FilledButton(
                    style: buttonStyle.buttonStyle(Size(1.1.sw, 47.h)),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                                height: 0.4.sh,
                                child: FutureProvider<ServiceRequest>(
                                  create: (context) => APIManagement()
                                      .sendServiceRequest(
                                          sessionId: loginData
                                              .loginModel.data.sessionId,
                                          deviceId: loginData.deviceId,
                                          location: loginData.location,
                                          userId: loginData
                                              .loginModel.data.user.userId,
                                          topic: _selectedTopic,
                                          subject: _subjectController.text,
                                          message: _messageController.text),
                                  initialData: ServiceRequest(
                                      status: 'fetching',
                                      message: 'Your request is processing..',
                                      data: []),
                                  child: Consumer<ServiceRequest>(
                                    builder: (context, serviceRequest, child) {
                                      String status = serviceRequest.message;
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            status.contains('processing')
                                                ? ProjectImages
                                                    .serviceRequestLoading
                                                : status.contains(
                                                        'Request Recorded')
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
                                            serviceRequest.message,
                                            style:
                                                textStyle.titleMedium?.copyWith(
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
                                                      {
                                                        _selectedTopic = '';
                                                        _subjectController
                                                            .clear();
                                                        _messageController
                                                            .clear();
                                                      }
                                                    });
                                                  },
                                                  child: const Text('OK'))
                                        ],
                                      );
                                    },
                                  ),
                                ));
                          });
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
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
    _subjectController.dispose();
    _messageController.dispose();

    super.dispose();
  }
}
