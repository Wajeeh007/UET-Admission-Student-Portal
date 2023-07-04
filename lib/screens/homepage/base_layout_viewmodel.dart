import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:online_admission/screens/status/status_view.dart';
import '../admission_form/screen_one/screen_one_view.dart';
import '../notification/notification.dart';
import 'homepage_ui.dart';

class BaseLayoutViewModel extends GetxController{

  RxInt pageIndex = 0.obs;
  PageController bottomNavBarController = PageController(initialPage: 0);

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

}