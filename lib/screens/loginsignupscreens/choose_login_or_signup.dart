import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:online_admission/constants.dart';
import 'package:online_admission/screens/loginsignupscreens/login/login_screen.dart';
import 'package:online_admission/screens/loginsignupscreens/sign_up/signup_screen.dart';

class AuthChoose extends StatelessWidget {
  static const authChoose = 'authchoose';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Welcome to UET Admission', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),),
                const SizedBox(
                  height: 20,
                ),
                Image.asset('assets/images/uni_logo.png', height: 150, width: 170, fit: BoxFit.fill,),
                const SizedBox(
                  height: 16,
                ),
                Text('Welcome to our UET merit checking and online admission application. Our app makes it easy to check your results and apply for admission to the University of Engineering and Technology. With a user-friendly interface and streamlined process, we are committed to providing you with the best experience possible', style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w600, fontSize: 13),),
                const SizedBox(
                  height: 23,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 140,
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(18))
                      ),
                      child: MaterialButton(
                          onPressed: (){
                            Get.off(() => LoginScreen());
                          },
                        child: const Text('Log In', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 140,
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(18))
                      ),
                      child: MaterialButton(
                          onPressed: (){
                            Get.off(() => SignUpScreen());
                          },
                        child: const Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                )
              ]
                ),
            ),
          ),
        ),
      );
  }
}
