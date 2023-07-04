import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_admission/screens/homepage/base_layout_viewmodel.dart';
import 'package:online_admission/constants.dart';

class BaseLayout extends StatelessWidget {

  BaseLayout({super.key});

  final BaseLayoutViewModel viewModel = Get.put(BaseLayoutViewModel());

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: viewModel.bottomNavBarController,
        physics: NeverScrollableScrollPhysics(),
        children: viewModel.pages,
      ),
      bottomNavigationBar: pageIndex == 1 ? null : bottomNavBar(context),
    );
  }

  Padding bottomNavBar(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Container(
          height: 63,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xAAd0874c),
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() =>
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              viewModel.changePage(0);
                            },
                            child: ImageIcon(
                              AssetImage('assets/images/home_icon.png'),
                              size: 30,
                              color: viewModel.pageIndex.value == 0 ? Colors.white : Colors.grey.shade300,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Home', style: TextStyle(
                              color: viewModel.pageIndex.value == 0 ? Colors
                                  .white : Colors.grey.shade300,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                  ),
                  Obx(() =>
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                viewModel.changePage(1);
                              },
                              child: ImageIcon(
                                AssetImage('assets/images/admission_form_icon.png'),
                                size: 30,
                                color: viewModel.pageIndex.value == 1 ? Colors.white : Colors.grey.shade300,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Admission Form', style: TextStyle(
                                color: viewModel.pageIndex.value == 1 ? Colors
                                    .white : Colors.grey.shade300,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),),
                          ]
                      )
                  ),
                  Obx(() =>
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              viewModel.changePage(2);
                            },
                            child: ImageIcon(
                              AssetImage('assets/images/status_icon.png'),
                              size: 30,
                              color: viewModel.pageIndex.value == 2 ? Colors.white : Colors.grey.shade300,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Status', style: TextStyle(
                              color: viewModel.pageIndex.value == 2 ? Colors
                                  .white : Colors.grey.shade300,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),)
                        ],
                      ),
                  ),
                  Obx(() => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              viewModel.changePage(3);
                            },
                            child: ImageIcon(
                              AssetImage('assets/images/notification_icon.png'),
                              size: 30,
                              color: viewModel.pageIndex.value == 3 ? Colors.white : Colors.grey.shade300,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Notification', style: TextStyle(
                              color: viewModel.pageIndex.value == 3 ? Colors
                                  .white : Colors.grey.shade300,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),)
                        ],
                      ),
                  ),
                ]
            ),
          ),
        )
    );
  }
}