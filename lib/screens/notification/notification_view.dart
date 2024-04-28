import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_admission/screens/notification/notifications_model.dart';
import 'notification_viewmodel.dart';

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
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Notification',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  fontFamily: 'Poppins'
                ),
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('notifications').snapshots(),
              builder: (context, snapshot){
                viewModel.notificationsList.clear();
                if(!snapshot.hasData){
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 6.5,
                      backgroundColor: Colors.black45,
                      color: Colors.white,
                    ),
                  );
                }
                final notifications = snapshot.data?.docs;
                for(var notification in notifications!){
                  final notificationMsg = notification.get('message');
                  final fromUni = notification.get('fromUni');
                  viewModel.notificationsList.add(
                    NotificationsModel(notificationMessage: notificationMsg, fromUni: fromUni)
                  );
                  viewModel.notificationsList.refresh();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: viewModel.notificationsList.length,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(208, 135, 76, 0.4),
                          borderRadius: const BorderRadius.all(Radius.circular(38)),
                          border: Border.all(
                            width: 0.1,
                            color: const Color.fromRGBO(208, 135, 76, 0.4),
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              viewModel.notificationsList[index].fromUni == true ?
                              Image.asset('assets/images/uni_logo.png', height: 52, width: 49,) : const CircleAvatar(
                                child: Icon(Icons.check, size: 25, color: Colors.white,),
                                backgroundColor: Color.fromRGBO(3, 197, 94, 1),
                                radius: 25,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  viewModel.notificationsList[index].notificationMessage.toString(),
                                  style: const TextStyle(
                                    color: Color.fromRGBO(67, 80, 96, 1),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            )
            ),
          ),
        ),
      );
  }
}