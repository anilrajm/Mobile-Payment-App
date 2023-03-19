import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recharge_app_mega/views/views.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    var info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String time = DateFormat("hh:mm:ss a").format(DateTime.now());
  List<String> options = [
    'Terms and Conditions',
    'Privacy Policy',
    'Application Version',
    'Data Version',
    'Data Refresh Time',
    'Contact Us'
  ];

  Widget _infoTile(String title) {
    return Text(title.isEmpty ? 'Not set' : title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(left: 14.w),
                  child: GestureDetector(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Navigator.pushNamed(context, '/terms');
                          break;
                        case 1:
                          Navigator.pushNamed(context, '/privacy');
                          break;

                        case 5:
                          Navigator.pushNamed(context, '/contactMegaPay');
                          break;
                      }
                    },
                    child: ListTile(
                      subtitle: index == 2
                          ? _infoTile(_packageInfo.version)
                          : index == 3
                              ? _infoTile(_packageInfo.buildNumber)
                              : index == 4
                                  ? Text('$time,  $date')
                                  : null,
                      title: Text(
                        options[index],
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18.sp),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          )
        ],
      ),
    );
  }
}
