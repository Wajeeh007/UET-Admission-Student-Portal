import 'package:flutter/material.dart';
import '../admission_form/screen_one/screen_one_view.dart';
import 'homepage_ui.dart';

class BaseLayout extends StatefulWidget {
  
  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {

  final pages = [
    HomePage(),
    ScreenOneView()
  ];

  int pageIndex = 0;

  Padding bottomNavBar(BuildContext context){
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      enableFeedback: false,
                      onPressed: (){
                        setState(() {
                          pageIndex = 0;
                        });
                      }, icon: Icon(Icons.home_outlined, color: pageIndex == 0 ? Colors.white : Colors.grey.shade300, size: 28,)),
                  Text('Home', style: TextStyle(color: pageIndex == 0 ? Colors.white : Colors.grey.shade300, fontSize: 11, fontWeight: FontWeight.bold),)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      enableFeedback: false,
                      onPressed: (){
                        setState(() {
                          pageIndex = 1;
                        });
                      }, icon: Icon(Icons.description_outlined, size: 28, color: pageIndex == 1 ? Colors.white : Colors.grey.shade300)),

                  Text('Admission Form', style: TextStyle(color: pageIndex == 1 ? Colors.white : Colors.grey.shade300, fontSize: 11, fontWeight: FontWeight.bold),)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: (){
                        setState(() {
                          pageIndex = 2;
                        });
                      },
                      enableFeedback: false,
                      icon: Icon(Icons.list_alt_outlined, color: pageIndex == 2 ? Colors.white : Colors.grey.shade300, size: 28)),
                  Text('Merit List', style: TextStyle(color: pageIndex == 2 ? Colors.white : Colors.grey.shade300, fontSize: 11, fontWeight: FontWeight.bold),)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    enableFeedback: false,
                      onPressed: (){
                        setState(() {
                          pageIndex = 3;
                        });
                      }, icon: Icon(Icons.notifications_none_outlined, color: pageIndex == 3 ? Colors.white : Colors.grey.shade300, size: 28)),
                  Text('Notification', style: TextStyle(color: pageIndex == 3 ? Colors.white : Colors.grey.shade300, fontSize: 11, fontWeight: FontWeight.bold),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[pageIndex],
      bottomNavigationBar: pageIndex == 1 ? null : bottomNavBar(context),
    );
  }
}