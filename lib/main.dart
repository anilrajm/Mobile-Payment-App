import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';

import 'color_schemes.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider<DashboardProvider>(
            create: (context) => DashboardProvider()),
        ChangeNotifierProvider(create: (context) => GetServiceProvider()),
        ChangeNotifierProvider(create: (context) => GetBalanceProvider()),
        ChangeNotifierProvider(create: (context) => FindOperatorProvider()),
        ChangeNotifierProvider(create: (context) => OperatorListProvider()),
        ChangeNotifierProvider(create: (context) => OperatorPlanProvider()),
        ChangeNotifierProvider(create: (context) => OperatorBillProvider()),
        ChangeNotifierProvider(create: (create) => LedgerDataProvider()),
        ChangeNotifierProvider(create: (create) => TransactionHistoryProvider()),
        ChangeNotifierProvider(create:(create)=>PinCodeDataProvider())
      ],
      child: ScreenUtilInit(
        designSize: const Size(392.72, 850.90),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              pageTransitionsTheme: pageTransitionsTheme,
              useMaterial3: true,
              colorScheme: lightColorScheme,
              textTheme: textTheme,
            ),
            darkTheme: ThemeData(
              pageTransitionsTheme: pageTransitionsTheme,
              useMaterial3: true,
              colorScheme: darkColorScheme,
              textTheme: textTheme,
            ),
            routes: {
              "loginScreen": (BuildContext ctx) => const LoginPage(),
              "signUpScreen": (BuildContext ctx) => const SignUpPage(),
              "forgotPassScreen": (BuildContext ctx) => const ForgotPass(),
              "homePage": (BuildContext ctx) => const HomePage(),
              "billPayScreen": (BuildContext ctx) => const BillPaymentItems(),
              "statementScreen": (BuildContext ctx) => const AccountStatement(),
              "profilePage": (BuildContext ctx) => const ProfilePage(),
              'myEarningScreen': (BuildContext ctx) => const MyEarningsPage(),
              'dashboardScreen': (BuildContext ctx) => const DashBoardScreen(),
              'earningFAQ': (BuildContext ctx) => const EarningsFAQ(),
              '/serviceRequest': (BuildContext ctx) => const TicketSupport(),
              'helpScreen': (BuildContext ctx) => const HelpPage(),
              'myQRScreen': (BuildContext ctx) => const MyQRScreen(),
              'qrScanScreen': (BuildContext ctx) => const QrCodeScannerPage(),
              'profileUpdate': (BuildContext ctx) => const UpdateProfilePage(),
              '/wallet': (BuildContext ctx) => const WalletTopUp(),
              '/change_password': (BuildContext ctx) => const ChangePassword(),
              '/offers_page': (BuildContext ctx) => const OffersPage(),
              '/terms': (BuildContext ctx) => const TermsAndConditions(),
              '/privacy': (BuildContext ctx) => const PrivacyPolicy(),
              '/contactMegaPay': (BuildContext ctx) => const ContactMegaPay(),
              '/notifications': (BuildContext ctx) => NotificationPage()
            },
            initialRoute: 'loginScreen',
          );
        },
      ),
    );
  }

  final pageTransitionsTheme = const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
    },
  );
}
