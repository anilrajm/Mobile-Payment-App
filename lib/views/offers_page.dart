import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';
class OffersPage extends StatelessWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title:const Text('Offers') ,
      ),
      body:   Center(
        child: Text('No offers available at this time',style:TextStyle(
          fontSize: 16.sp,fontStyle: FontStyle.italic,
        ),),
      ),
    );
  }
}
