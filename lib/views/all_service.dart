import 'package:flutter/material.dart';
import 'package:recharge_app_mega/models/get_services_model.dart' as service;
import 'package:recharge_app_mega/views/views.dart';

class AllService extends StatefulWidget {
  const AllService({super.key});

  @override
  State<AllService> createState() => _AllServiceState();
}

class _AllServiceState extends State<AllService> {
  @override
  Widget build(BuildContext context) {
    //Providers.
    final services = Provider.of<GetServiceProvider>(context, listen: false)
        .getServicesModel;
    final loginData =
        Provider.of<LoginProvider>(context, listen: false).loginModel;
    final sessionKey = loginData.data.sessionId;
    final userId = loginData.data.user.userId;

    //ThemData.
    final textStyle = Theme.of(context).textTheme;

    // Method to filter the recharge services.
    List<service.Datum> rechargeService = services.data
        .where((element) =>
            element.serviceId == AllServicesConstants.prepaid ||
            element.serviceId == AllServicesConstants.dth ||
            element.serviceId == AllServicesConstants.fastag ||
            element.serviceId == AllServicesConstants.cableTV)
        .toList();

    return Consumer<LoginProvider>(
      builder: (BuildContext context, value, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.h,
              ),
              BuildMarquee(
                  news: value.loginModel.data.general.news.replaceAll('\n', ''),
                  // Formatted to a single line string.
                  size: 45.h,
                  paddingSize: 10.h),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Consumer<DashboardProvider>(
                  builder: (context, value, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Cards for displaying count of 'Success', 'Top Up', 'Pending'.
                        BuildStatusCards(
                          statusCount: value.dashboardModel.data.totalSuccess,
                          labelText: AllServicesConstants.successText,
                          labelTextColor: MegaColors.statusSuccess,
                        ),
                        BuildStatusCards(
                            statusCount:
                                value.dashboardModel.data.totalPurchase,
                            labelText: AllServicesConstants.topUpText,
                            labelTextColor: MegaColors.statusTopUp),
                        BuildStatusCards(
                            statusCount: value.dashboardModel.data.totalPending,
                            labelText: AllServicesConstants.pendingText,
                            labelTextColor: MegaColors.statusPending)
                      ],
                    );
                  },
                ),
              ),
              // A card of recharge services.
              Card(
                margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, top: 10.h),
                      child: Text(
                        AllServicesConstants.rechargeText,
                        style: textStyle.titleMedium,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 10.w, right: 10.w, top: 10.h, bottom: 2.h),
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 12.w,
                        shrinkWrap: true,
                        childAspectRatio: 0.4.w / 0.5.w,
                        crossAxisCount: 4,
                        children:
                            List.generate(rechargeService.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RechargePayment(
                                            index: index,
                                            serviceId: rechargeService[index]
                                                .serviceId,
                                            sessionId: sessionKey,
                                            userId: userId,
                                          )));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  RechargeConstants.rechargeIcons[index],
                                  fit: BoxFit.contain,
                                  width: 60.w,
                                  height: 60.h,
                                ),
                                Text(
                                  RechargeConstants.rechargeTitles[index],
                                  textAlign: TextAlign.center,
                                  style: textStyle.bodyMedium,
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              const BillPaymentItems() // Other services.
            ],
          ),
        );
      },
    );
  }
}
