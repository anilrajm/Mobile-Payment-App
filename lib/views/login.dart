import 'package:flutter/material.dart';
import 'package:recharge_app_mega/networking/api_request.dart';
import 'package:recharge_app_mega/views/views.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String _token = '';
  CustomButtonStyle buttonStyle = CustomButtonStyle();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  bool loading = false;
  final _storage = const FlutterSecureStorage();
  late String username;
  late String password;
  bool _savePassword = false;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _onFormSubmit() async {
    if (_savePassword) {
      await _storage.write(key: "KEY_USERNAME", value: username);
      await _storage.write(key: "KEY_PASSWORD", value: password);
    }
  }

  onLogout() async {
    await _storage.deleteAll();
  }

  Future<void> _readFromStorage() async {
    userNameController.text = await _storage.read(key: "KEY_USERNAME") ?? '';
    passwordController.text = await _storage.read(key: "KEY_PASSWORD") ?? '';
  }

  @override
  void initState() {
    super.initState();
    _readFromStorage();
    requestPermission();
    getToken();
    initInfo();
  }

  initInfo() {
    var androidInitialize =
    const AndroidInitializationSettings('@mipmap/notification_icon');
    var initializationsSettings =
    InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(
        initializationsSettings,
        onDidReceiveNotificationResponse: (payload) async {
          try {
            if (payload.payload != null) {

            } else {

            }
          } catch (e) {

          }
          return;
        });
    FirebaseMessaging.onMessage.listen(
            (RemoteMessage message) async {
          print(".... .onMessage.... ");
          print("onMessage: ${message.notification?.title}/${message.notification
              ?.body}}");

          BigTextStyleInformation bigTextStyleInformation =
          BigTextStyleInformation(message.notification!.body
              .toString(), htmlFormatBigText: true,
            contentTitle: message.notification!.title.toString(),
            htmlFormatContentTitle: true,);

          AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(

            'Offers', 'Promotions', importance: Importance.high,

            styleInformation: bigTextStyleInformation,
            priority: Priority.high,
            playSound: true,
          );
// sound: RowResourceAndroidNotificationSound("notification'),

          NotificationDetails platformChannelSpecifics = NotificationDetails(
              android: androidPlatformChannelSpecifics);
          await flutterLocalNotificationsPlugin.show(
              0, message.notification?.title, message.notification?.body,
              platformChannelSpecifics, payload: message.data['body']);
        });}

        void getToken()
    async {
      await _firebaseMessaging.getToken().then((token) {
        setState(() {
          if (token != null) _token = token;
          print('My token is: $_token');
        });
      });
    }

    void requestPermission() async {
      NotificationSettings settings = await _firebaseMessaging
          .requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true);

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }
    }

    @override
    Widget build(BuildContext context) {
      // Instances of data provider.
      final dashboard = Provider.of<DashboardProvider>(context, listen: false);
      final services = Provider.of<GetServiceProvider>(context, listen: false);

      return Scaffold(
        body: SafeArea(
          child: Consumer<LoginProvider>(
            builder: (context, provider, child) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(children: [
                      SizedBox(
                        width: double.infinity,
                        child: Image.asset("asset/icons/login_image.png",
                            fit: BoxFit.fitWidth, height: 297.815.h),
                      ),
                      // BrandLogo()
                    ]),
                    Padding(
                      padding: EdgeInsets.only(left: 25.w),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.52.h,
                    ),
                    Form(
                      child: Column(children: [
                        Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            child: Form(
                              child: Column(
                                children: [
                                  TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        username = userNameController.text;
                                      });
                                    },
                                    controller: userNameController,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.phone_android,
                                        ),
                                        hintText: "Mobile number"),
                                  ),
                                  SizedBox(height: 25.52.h),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        password = passwordController.text;
                                      });
                                    },
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                        ),
                                        hintText: "Password"),
                                  )
                                ],
                              ),
                            )),
                        Row(
                          children: [
                            SizedBox(
                              width: 23.56.w,
                            ),
                            Checkbox(
                              value: _savePassword,
                              onChanged: (value) {
                                setState(() {
                                  _savePassword = value!;
                                });
                              },
                            ),
                            const Text(
                              "Remember me",
                              style: TextStyle(),
                            ),
                            SizedBox(width: 54.98.w),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "forgotPassScreen");
                                },
                                child: const Text(
                                  "Forgot password?",
                                ))
                          ],
                        )
                      ]),
                    ),
                    SizedBox(
                      height: 34.036.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.20.w),
                      child: FilledButton(
                        onPressed: () async {
                          loading = true;
                          await provider.login(
                              userName: userNameController.text,
                              password: passwordController.text);

                          if (provider.isLoading == false) {
                            if (provider.loginModel.status == 'success') {
                              await _onFormSubmit();
                              var data = provider.loginModel.data;
                              var sessionKey = data.sessionId;
                              var userId = data.user.userId;
                              var deviceId = provider.deviceId;
                              var location = provider.location;
                              print('User ID : $userId');
                              print('Session Key: $sessionKey');
                              print('Device ID: $deviceId');
                              print('Location: $location');
                              print('Token: $_token');

                              await APIManagement().sendTokenToServer(
                                  token: _token,
                                  deviceId: deviceId,
                                  sessionId: sessionKey,
                                  userId: userId,
                                  location: location);

                              await dashboard.fetchDashboard(
                                  sessionId: sessionKey,
                                  userId: userId,
                                  deviceId: deviceId,
                                  location: location);
                              await services.getService(
                                  sessionId: sessionKey,
                                  userId: userId,
                                  deviceId: deviceId,
                                  location: provider.location);
                              loading = false;

                              if (context.mounted) {
                                Navigator.pushReplacementNamed(
                                    context, 'homePage');
                              }
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          provider.loginModel.message)),
                                );
                              }
                            }

                            if (provider.loginModel.status == 'warning') {
                              loading = false;
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          provider.loginModel.message)),
                                );
                              }
                            }
                            if (provider.loginModel.status == 'info') {
                              loading = false;
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          provider.loginModel.message)),
                                );
                              }
                            }
                          }
                        },
                        style: buttonStyle.buttonStyle(Size(357.w, 47.h)),
                        child: loading
                            ? LoadingAnimationWidget.horizontalRotatingDots(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .onSecondary,
                            size: 30.w)
                            : Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 34.036.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.20.w),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "signUpScreen");
                        },
                        style: buttonStyle.buttonStyle(Size(357.w, 47.h)),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }

    @override
    void dispose() {
      userNameController.dispose();
      passwordController.dispose();
      // TODO: implement dispose
      super.dispose();
    }
  }
