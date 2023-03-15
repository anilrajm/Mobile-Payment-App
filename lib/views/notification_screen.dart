import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:recharge_app_mega/views/views.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
     final List _notifications = [
    'You have received Rs. 500',
    'Your payment of Rs. 1000 has been processed',
    'Your transaction of Rs. 2000 has been successful',
    'You have received Rs. 1000',
    'Your payment of Rs. 500 has been processed',
    'Your transaction of Rs. 3000 has been successful',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          return Slidable(
            endActionPane: ActionPane(
              motion: const BehindMotion(),
              children: [
                SlidableAction(
                    label: 'Delete',
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                    onPressed: (context) => _onDismissed(index))
              ],
            ),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              child: Container(
                decoration: const BoxDecoration(),
                child: ListTile(
                  leading: const Icon(
                    Icons.notifications_none,
                    color: Colors.grey,
                  ),
                  title: Text(
                    _notifications[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: const Text(
                    'Today',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.more_vert_rounded,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }_onDismissed(int index) {

  setState(()=> _notifications.removeAt(index));}

}

