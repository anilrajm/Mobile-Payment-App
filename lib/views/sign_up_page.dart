import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:recharge_app_mega/models/business_type_model.dart';
import 'package:recharge_app_mega/models/user_register_model.dart';
import 'package:recharge_app_mega/views/views.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  RegExp nameRegExp = RegExp(r'^[a-z A-Z]+$');
  RegExp numberRegExp = RegExp(r'^(?:[+][91])?\d{10,12}$');

  RegExp pincodeRegExp = RegExp(r'^[1-9]\d{5}$');
  RegExp passValidRegExp = RegExp(r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#&*~])(?=.{8,16}).*$");
  // RegExp emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$'); // Update: added email validator plugin instead.
  CustomButtonStyle buttonStyle = CustomButtonStyle();

  // Store selected business type
  String _selectedBusinessType = '';
  String _geoId = 'Nil';

  //Text Editing controllers for fields
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final String passwordHelper='Password must have 1 uppercase, 1 lowercase, 1 number, and 1 special character. Length should be between 8-16 characters.';

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme;
    var color = Theme.of(context).colorScheme;
    //Providers.
    var pincodeData = Provider.of<PinCodeDataProvider>(context, listen: false);
    SizedBox space = SizedBox(
      height: 25.52.h,
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10.w),
                  width: double.infinity,
                  child: Image.asset("asset/icons/sign_up_image.png",
                      fit: BoxFit.fitWidth, height: 0.35.sh),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.w),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                space,
                BuildSignUpTextField(
                  controller: usernameController,
                  keyboardType: TextInputType.name,
                  prefixIcon: FontAwesomeIcons.user,
                  labelText: "Username",
                  validator: (value) {
                    if (value!.isEmpty || !nameRegExp.hasMatch(value)) {
                      return 'Please enter a valid username';
                    } else {
                      return null;
                    }
                  },
                ),
                space,
                BuildSignUpTextField(
                  controller: mobileNumController,
                  keyboardType: TextInputType.phone,
                  prefixIcon: FontAwesomeIcons.phone,
                  labelText: "Phone Number",
                  validator: (value) {
                    if (value!.isEmpty || !numberRegExp.hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    } else {
                      return null;
                    }
                  },
                ),
                space,
                BuildSignUpTextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: FontAwesomeIcons.envelope,
                  labelText: "Email",
                  validator: (value) {
                    if (value!.isEmpty || !EmailValidator.validate(value)) {
                      return 'Please enter a valid email address';
                    } else {
                      return null;
                    }
                  },
                ),
                space,
                Padding(
                  padding: EdgeInsets.only(left: 38.w, right: 30.w),
                  child: FutureProvider<BusinessType>(
                      create: (context) =>
                          BusinessTypeProvider().fetchBusinessTypes(),
                      initialData: BusinessType(
                          status: 'loading', message: '', data: []),
                      child: Consumer<BusinessType>(
                          builder: (context, business, child) {
                        return DropdownButtonFormField(
                            isExpanded: true,
                            icon: const FaIcon(FontAwesomeIcons.caretDown),
                            menuMaxHeight: 0.5.sh,
                            decoration: const InputDecoration(
                                hintText: "Business type",
                                icon: FaIcon(
                                  FontAwesomeIcons.shop,
                                )),
                            items: [
                              ...business.data
                                  .map((business) => DropdownMenuItem(
                                      value: business.value,
                                      child: Text(
                                        business.code,
                                        overflow: TextOverflow.ellipsis,
                                      )))
                                  .toList()
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedBusinessType = value!;
                              });
                            });
                      })),
                ),
                space,
                BuildSignUpTextField(
                  maxLength: 6,
                  controller: pincodeController,
                  keyboardType: TextInputType.number,
                  prefixIcon: FontAwesomeIcons.locationDot,
                  labelText: "Pincode",
                  validator: (value) {
                    if (value!.isEmpty || !pincodeRegExp.hasMatch(value)) {
                      return 'Please enter a valid pincode';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) async {
                    if (value.length == 6) {
                      await pincodeData.fetchPinCodeData(
                          pinCode: pincodeController.text);
                    }
                  },
                ),
                space,
                Padding(
                    padding: EdgeInsets.only(left: 45.w, right: 30.w),
                    child: Consumer<PinCodeDataProvider>(
                        builder: (context, location, child) {
                      return Column(
                        children: [
                          DropdownButtonFormField(
                              isExpanded: true,
                              icon: const FaIcon(FontAwesomeIcons.caretDown),
                              menuMaxHeight: 0.4.sh,
                              decoration: const InputDecoration(
                                  hintText: 'State',
                                  icon: FaIcon(
                                    FontAwesomeIcons.globe,
                                  )),
                              items: [
                                ...?location.pincodeData
                                    ?.data // TODO: Duplicate elements in dropdown needed to be fixed.
                                    .map((data) => DropdownMenuItem(
                                        value: data.id,
                                        child: Text(
                                          data.stateName,
                                          overflow: TextOverflow.ellipsis,
                                        )))
                                    .toList()
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _geoId = value!;
                                });
                              }),
                          space,
                          DropdownButtonFormField(
                              isExpanded: true,
                              icon: const FaIcon(FontAwesomeIcons.caretDown),
                              menuMaxHeight: 0.5.sh,
                              decoration: const InputDecoration(
                                  hintText: 'District',
                                  icon: FaIcon(
                                    FontAwesomeIcons.chartArea,
                                  )),
                              items: [
                                ...?location.pincodeData
                                    ?.data // TODO: Duplicate elements in dropdown need to be fixed.
                                    .map((data) => DropdownMenuItem(
                                        value: data.id,
                                        child: Text(
                                          data.districtName,
                                          overflow: TextOverflow.ellipsis,
                                        )))
                                    .toList()
                              ],
                              onChanged: (value) {
                                setState(() {
                                  if (value == _geoId && _geoId != "Nil") {
                                    _geoId = value!;
                                  } else {
                                    print('no state selected');
                                  }
                                });
                              }),
                          space,
                          DropdownButtonFormField(
                              isExpanded: true,
                              icon: const FaIcon(FontAwesomeIcons.caretDown),
                              menuMaxHeight: 0.5.sh,
                              decoration: const InputDecoration(
                                  hintText: 'Taluk',
                                  icon: FaIcon(
                                    FontAwesomeIcons.mapLocation,
                                  )),
                              items: [
                                ...?location.pincodeData?.data
                                    .map((data) => DropdownMenuItem(
                                        // TODO: Wrong combination should not be allowed!!.
                                        value: data.id,
                                        child: Text(
                                          data.talukName,
                                          overflow: TextOverflow.ellipsis,
                                        )))
                                    .toList()
                              ],
                              onChanged: (value) {
                                setState(() {
                                  if (value == _geoId && _geoId != "Nil") {
                                    _geoId = value!;
                                  } else {
                                    print('no state selected');
                                  }
                                });
                              })
                        ],
                      );
                    })),
                space,
                BuildSignUpTextField(
                  controller: passwordController,
                  keyboardType: TextInputType.name,
                  prefixIcon: FontAwesomeIcons.lock,
                  labelText: "Password",
                  helperText: passwordHelper,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty || !passValidRegExp.hasMatch(value)) {
                      return "Please match the requested format.";
                    } else {
                      return null;
                    }
                  },
                ),
                space,
                BuildSignUpTextField(
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.name,
                  prefixIcon: FontAwesomeIcons.lock,
                  labelText: "Confirm Password",
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty ||
                        !value.contains(passwordController.text)) {
                      return "Those passwords didn't match. Try again.";
                    } else {
                      return null;
                    }
                  },
                ),
                space,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.20.w),
                  child: FilledButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 0.4.sh,
                              child: FutureProvider<UserRegister>(
                                initialData: UserRegister(
                                    status: 'fetching',
                                    message: 'Your request is processing..'),
                                create: (context) => UserRegisterProvider()
                                    .registerNewUser(
                                        userName: usernameController.text,
                                        userEmail: emailController.text,
                                        phoneNum: mobileNumController.text,
                                        businessType: _selectedBusinessType,
                                        password:
                                            confirmPasswordController.text,
                                        pinCode: pincodeController.text,
                                        geoId: _geoId),
                                child: Consumer<UserRegister>(
                                  builder: (context, user, child) {
                                    String status = user.message;
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          status.contains('processing')
                                              ? WalletTopUpConst.processing
                                              : status.contains('Demo SUccess')
                                                  ? WalletTopUpConst.successTick
                                                  : WalletTopUpConst.failCross,
                                          height: 60.h,
                                          width: 60.h,
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Text(
                                          textAlign: TextAlign.center,
                                          user.message,
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
                                                  Navigator.popAndPushNamed(
                                                      context, "loginScreen");
                                                  // clear all text fields
                                                  // setState(() {
                                                  //
                                                  // });
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
                      }
                    },
                    style: buttonStyle.buttonStyle(Size(1.1.sh, 47.h)),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.50.h),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        " Already have an account?",
                        style: TextStyle(
                            fontSize: 15.sp, color: const Color(0xFF044c63)),
                      )),
                ),
                SizedBox(height: 34.03.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    mobileNumController.dispose();
    pincodeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
