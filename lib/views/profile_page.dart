import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  LoginPageState login = LoginPageState();
  final double coverHeight = 170.h;
  final double profileHeight = 144.h;

  @override
  Widget build(BuildContext context) {
    var profileData = Provider.of<LoginProvider>(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTop(),
          Text(
            profileData.loginModel.data.org.name,
            style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            profileData.loginModel.data.user.mobileNo,
            style: TextStyle(fontSize: 18.sp),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ProfilePageConstants.profilePageOptions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: InkWell(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Navigator.pushNamed(context, 'myQRScreen');
                          break;
                        case 1:
                          Navigator.pushNamed(context, 'statementScreen');
                          break;
                        // case 2:
                        //   Navigator.pushNamed(context, 'myEarningScreen');
                        //   break;
                        case 2:
                          Navigator.pushNamed(context, '/serviceRequest');
                          break;
                        case 3:
                          Navigator.pushNamed(context, 'helpScreen');
                          break;
                        case 4:
                          login.onLogout();
                          Navigator.pushNamed(context, 'loginScreen');
                          break;
                      }
                    },
                    child: Card(
                      child: ListTile(
                        leading:  ProfilePageConstants.profilePageIcons[index],
                        title: Text(
                          ProfilePageConstants.profilePageOptions[index],
                          style: TextStyle(fontSize: 17.sp),
                        ),
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }

  Widget buildTop() {

    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          buildCoverImage(),
          Positioned(
            child: buildProfileImage(),
          )
        ]);
  }

  Widget buildCoverImage() =>
      SizedBox(width: double.infinity, height: coverHeight);

  Widget buildProfileImage() => Container(
        width: 130.0.w,
        height: 130.0.h,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage(ProfilePageConstants.profileDummyAvatar),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(62.6.r)),
        ),
      );
}
