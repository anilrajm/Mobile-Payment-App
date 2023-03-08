import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';
class BuildNotificationIcon extends StatelessWidget {
  const BuildNotificationIcon({
    super.key, required this.count,
  });
  final String count;
  @override
  Widget build(BuildContext context) {
    return Badge(
      label:   Text(count),
      child: IconButton(
          onPressed: () {Navigator.pushNamed(context, '/notifications');},
          icon: Icon(
            Icons.notifications_none_outlined,
            size: 30.w,
            color: Colors.white,
          )),
    );
  }
}
