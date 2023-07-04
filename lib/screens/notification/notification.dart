import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_admission/screens/notification/notification_viewmodel.dart';

class NotificationView extends StatelessWidget {
  NotificationView({super.key});

  final NotificationViewModel viewModel = Get.put(NotificationViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Notification',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                ),
              ),
            ),
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}
