import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  CustomButtonStyle buttonStyle = CustomButtonStyle();
  final double coverHeight = 170.h;
  final double profileHeight = 144.h;

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final pincodeController = TextEditingController();

  @override
  void initState() {
    var updateProfileData = Provider.of<LoginProvider>(context, listen: false);
    super.initState();
    nameController.text = updateProfileData.loginModel.data.org.name;
    mobileController.text = updateProfileData.loginModel.data.user.username;
    emailController.text = updateProfileData.loginModel.data.user.emailid;
    addressController.text =
        updateProfileData.loginModel.data.contactDetails.postalAddress;
    pincodeController.text =
        updateProfileData.loginModel.data.contactDetails.pincode;
  }

  @override
  Widget build(BuildContext context) {
    var updateProfileData = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile "),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildProfileImage(imageHeight: 144.65.h, imageWidth: 149.23.w),
              Text(
                updateProfileData.loginModel.data.org.name,
                style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8.50.h,
              ),
              Text(
                "+91 " + updateProfileData.loginModel.data.user.mobileNo,
                style: TextStyle(fontSize: 18.sp),
              ),
              Column(
                children: [
                  BuildEditProfileField(
                    fieldController: nameController,
                    fieldLabel: 'Name',
                    keyboardType: TextInputType.text,
                  ),
                  BuildEditProfileField(
                    fieldController: mobileController,
                    fieldLabel: 'Mobile Number',
                    keyboardType: TextInputType.phone,
                  ),
                  BuildEditProfileField(
                    fieldController: emailController,
                    fieldLabel: 'Email ID',
                    keyboardType: TextInputType.text,
                  ),
                  BuildEditProfileField(
                    fieldController: addressController,
                    fieldLabel: 'Full Address',
                    keyboardType: TextInputType.text,
                  ),
                  BuildEditProfileField(
                    fieldController: pincodeController,
                    fieldLabel: 'Pin code',
                    keyboardType: TextInputType.number,
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 20.sp),
                child: FilledButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "signUpScreen");
                  },
                  style: buttonStyle.buttonStyle(Size(357.w, 47.h)),
                  child: Text(
                    "Update Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.50.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileImage(
          {required double imageHeight, required double imageWidth}) =>
      Container(
        width: imageWidth,
        height: imageHeight,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage(ProfilePageConstants.profileDummyAvatar),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(70.r)),
          border: Border.all(
            color: Colors.white,
            width: 4.0.w,
          ),
        ),
      );
}
