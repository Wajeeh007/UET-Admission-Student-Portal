import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:online_admission/screens/status/status_view.dart';
import '../../constants.dart';
import '../admission_form/screen_one/screen_one_view.dart';
import '../notification/notification_view.dart';
import '../homepage/homepage_view.dart';

class BaseLayoutViewModel extends GetxController{

  RxInt pageIndex = 0.obs;
  PageController bottomNavBarController = PageController(initialPage: 0);
  RxBool formSubmitted = false.obs;
  RxBool overlay = false.obs;
  RxBool bottomNavBarVisibility = true.obs;

  @override
  void onInit()async {
    await checkFirebase();
    super.onInit();
  }

  List<Widget> pages = [
    HomePage(),
    ScreenOneView(),
    StatusView(),
    NotificationView()
  ];

  void changePage(int index){
    pageIndex.value = index;
    bottomNavBarController.jumpToPage(index);
  }

  checkFirebase()async{
    var userData = await FirebaseFirestore.instance.collection('user_data').doc(userID);
    final docCheck = await userData.get();
    final data = docCheck.data();
    final submitted = data?['application_status'];
    if(submitted == false){
      return;
    }
    else{
      formSubmitted.value = submitted;
    }
  }
}