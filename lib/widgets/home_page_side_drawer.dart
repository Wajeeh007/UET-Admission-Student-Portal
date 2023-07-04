import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_admission/screens/homepage/menu_screens/merit_list.dart';
import 'package:online_admission/screens/homepage/menu_screens/complain.dart';

class sideDrawer extends StatelessWidget {
  const sideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        color: const Color(0xFFf7b280),
        width: MediaQuery.of(context).size.width/1.3,
        child: ListView(
          children: [
            SizedBox(
              height: 210,
              child: DrawerHeader(
                  padding: EdgeInsets.zero,
                  child: Container(
                    padding: EdgeInsets.zero,
                    height: double.infinity,
                    width: double.infinity,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 36,
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                Icons.account_circle_outlined,
                                size: 45,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Text('Zia Ullah', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),)
                          ],
                        ),
                      ),
                    ),
                  )
              ),
            ),
            ListTile(
              leading: const Icon(Icons.contact_support_outlined, color: Colors.white, size: 25,),
              title: const Text('Complaints', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              onTap: (){
                Get.to(() => const ComplainScreen());
              },
            ),
            ListTile(
              leading: const Icon(Icons.history, color: Colors.white, size: 25,),
              title: const Text('Merit History', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              onTap: (){
                Get.to(() => const PreviousMeritLists());
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined, color: Colors.white, size: 25,),
              title: const Text('Logout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              onTap: (){},
            ),
            const SizedBox(
              height: 60,
            ),
            ListTile(
              leading: const Icon(Icons.arrow_back, color: Colors.white, size: 25,),
              title: const Text('Back', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              onTap: (){
                // Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}