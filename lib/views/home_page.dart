import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginPageState login = LoginPageState();

  int selectedIndex = 0;
  List pages = [
    const AllService(),
    const DashBoardScreen(),
    const Transactions(),
    const ProfilePage(),
  ];

  onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var loginData =
        Provider.of<LoginProvider>(context, listen: false).loginModel;
    //Providers.
    var profile = Provider.of<LoginProvider>(context, listen: false);
    //Media-query.
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: selectedIndex != 1
              ? AppBar(
                  backgroundColor: const Color(0xFF006686),
                  actions: (selectedIndex == 0)
                      ? <Widget>[
                          Padding(
                            padding:   EdgeInsets.only(right: 10.w),
                            child: const BuildNotificationIcon(
                              count: '4',
                            ),
                          ),
                        ]
                      : (selectedIndex == 2)
                          ? [
                              Padding(
                                padding: EdgeInsets.all(8.0.w),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                10)),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/serviceRequest');
                                  },
                                  child: const Text(
                                    "Tickets",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ]
                          : [
                              Padding(
                                padding:   EdgeInsets.only(right: 10.w),
                                child: const BuildNotificationIcon(
                                  count: '4',
                                ),
                              ),
                            ],
                  flexibleSpace: Padding(
                    padding: EdgeInsets.only(top: 100.h, left: 19.w),
                    child: Row(
                      children: [
                        Text(
                          'WALLET BALANCE (as of Now)',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 15.sp),
                        ),
                        const Spacer(),
                        qrPayScanner(context)
                      ],
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(120.h),
                    child: Container(
                      alignment: AlignmentDirectional.topStart,
                      padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
                      child: Row(
                        children: [
                          Text("₹${loginData.data.wallet.balance}",
                              style: TextStyle(
                                  fontSize: 25.sp,
                                  color:
                                      const Color.fromRGBO(247, 148, 24, 1))),
                          const Spacer(

                          ),
                          Padding(
                            padding:   EdgeInsets.only(right:10.w),
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    minimumSize: Size(100.w, 30.h),
                                    side:
                                        const BorderSide(color: Colors.white38)),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/wallet');
                                },
                                child: const Text(
                                  'MANAGE',
                                  style: TextStyle(color: Colors.white),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  title: selectedIndex == 0
                      ? Row(
                          children: [
                            SizedBox(
                                height: 400.h,
                                width: 40.w,
                                child: Image.asset(
                                  'asset/icons/megaPayBrand.png',
                                )),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Mega Pay',
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.white),
                            ),
                          ],
                        )
                      : selectedIndex == 2
                          ? const Text(
                              'Transactions',
                              style: TextStyle(color: Colors.white),
                            )
                          : const Text(
                              "Profile",
                              style: TextStyle(color: Colors.white),
                            ),
                  automaticallyImplyLeading: false,
                )
              : null,
          drawer: NavigationDrawer(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: MegaColors.deepCyan,
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: MegaColors.deepCyan),
                  accountName: Text(
                    profile.loginModel.data.org.name,
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  accountEmail: Text(profile.loginModel.data.user.mobileNo),
                ), //UserAccountDrawerHeader
              ), //DrawerHeader
              _buildListTile(
                  context, 'profileUpdate', Icons.person, ' My Profile '),
              _buildListTile(
                  context, 'statementScreen', Icons.book, ' Passbook '),
              _buildListTile(
                  context, '/offers_page', Icons.workspace_premium, ' Offers '),
              _buildListTile(
                  context, 'helpScreen', Icons.video_label, ' Help '),
              _buildListTile(
                  context, '/change_password', Icons.edit, ' Change Password '),
              _buildListTile(context, 'loginScreen', Icons.logout, 'LogOut',
                  isLogout: true),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: onItemTap,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: "Home"),
              NavigationDestination(
                  icon: Icon(Icons.dashboard), label: "Dashboard"),
              NavigationDestination(
                  icon: Icon(Icons.compare_arrows), label: "History"),
              NavigationDestination(
                  icon: Icon(Icons.account_circle), label: "Profile"),
            ],
          ),
          body: Center(child: pages.elementAt(selectedIndex))),
    );
  }

  Padding qrPayScanner(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'qrScanScreen');
          },
          icon: Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
            size: 30.w,
          )),
    );
  }

  _buildListTile(
          BuildContext context, String routeName, IconData icon, String title,
          {bool isLogout = false}) =>
      ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () => isLogout
            ? _handleLogout(context)
            : Navigator.pushNamed(context, routeName),
      );

  _handleLogout(BuildContext context) async {
    await login.onLogout();
    if (context.mounted) {
      Navigator.pushNamed(context, 'loginScreen');
    }
  }

  // Exit conformation function.
  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Mega Pay'),
            content: const Text('Are you sure want to exit?'),
            actions: [
              FilledButton.tonal(
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                child: const Text('Yes'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: const Text('No'),
              ),
            ],
          ),
        ) ??
        false; //if showDialog had returned null, then return false
  }
}
