import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:online_admission/screens/base/base_layout.dart';
import 'package:online_admission/screens/loginsignupscreens/choose_login_or_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDQ99Osjr_CeuAAuGnxb9GXbGqY7SuLG7I",
            appId: "com.example.online_admission",
            messagingSenderId: "1076091619521",
            projectId: "admissionapp-9c884",
            storageBucket: "admissionapp-9c884.appspot.com"
        )
    );
  }
  catch (e){
    showToast('Encountered an error contacting the servers. You won\'t be able to use a few services. Please check your internet connection and try again');
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  formSubmitted = await prefs.getBool('formSubmitted');
  userID = prefs.getString('userID');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((value) => runApp(MyApp(email)));
}

class SplashScreen extends StatefulWidget{

  const SplashScreen({super.key, this.email});

  final String? email;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      if(widget.email == null){
        Get.off(() => const AuthChoose());
      } else{
        Get.off(() => BaseLayout());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xffd0874c),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Stack(
            fit: StackFit.loose,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/uni_logo.png', height: 209, width: 211,),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Uet Admission',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -180,
                right: -180,
                child: Container(
                  width: 350,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Color(0xffd0874c),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.3
                    )
                  ),
                ),
              ),
              Positioned(
                top: -10,
                left: -30,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xffd0874c),
                    border: Border.all(
                      color: Color(0xff707070),
                      width: 1.3
                    )
                  ),
                ),
              ),
              Positioned(
                left: -150,
                top: 140,
                child: Container(
                  width: 200,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Color(0xffd0874c),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.3
                    )
                  ),
                ),
              ),
              Positioned(
                left: -70,
                top: 450,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xffd0874c),
                    border: Border.all(
                      color: Color(0xff707070),
                      width: 1.3
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {

  final String? userEmail;
  
  const MyApp(this.userEmail);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(email: userEmail,),
    );
  }
}