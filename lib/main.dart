import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:online_admission/screens/loginsignupscreens/login/forgot_password.dart';
import 'package:online_admission/screens/loginsignupscreens/login/login_screen.dart';
import 'package:online_admission/screens/loginsignupscreens/sign_up/signup_screen.dart';
import 'constants.dart';
import 'screens/loginsignupscreens/choose_login_or_signup.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDm8tLexf9_4qrFZEPgRO78w3dQgSud9s0",
            appId: "com.example.car_parking",
            messagingSenderId: "41441340795",
            projectId: "car-parking-8cc27",
            storageBucket: "car-parking-8cc27.appspot.com"
        )
    );
  }
  catch (e){
    showToast('Encountered an error contacting the servers. You won\'t be able to use a few services. Please check your internet connection and try again');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: authChoose(),
      routes: {
        LoginScreen.loginscreen: (context) => LoginScreen(),
        signUpScreen.signupscreen: (context) => signUpScreen(),
        ConfirmEmail.confirmEmail: (context) => ConfirmEmail()
      },
    );
  }
}