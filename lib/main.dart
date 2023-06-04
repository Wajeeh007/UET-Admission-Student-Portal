import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:online_admission/screens/admission_form/admission_form_1.dart';
import 'package:online_admission/screens/admission_form/admission_form_2.dart';
import 'package:online_admission/screens/admission_form/admission_form_3.dart';
import 'package:online_admission/screens/admission_form/admission_form_4.dart';
import 'package:online_admission/screens/homepage/base_layout.dart';
import 'package:online_admission/screens/homepage/menu_screens/merit_list.dart';
import 'package:online_admission/screens/loginsignupscreens/choose_login_or_signup.dart';
import 'package:online_admission/screens/loginsignupscreens/login/forgot_password.dart';
import 'package:online_admission/screens/loginsignupscreens/login/login_screen.dart';
import 'package:online_admission/screens/loginsignupscreens/sign_up/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'screens/homepage/menu_screens/complain.dart';

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
  runApp(MyApp(email));
}

class MyApp extends StatelessWidget {
  
  final String? userEmail;
  
  MyApp(this.userEmail);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userEmail == null ? AuthChoose() : BaseLayout(),
      routes: {
        AuthChoose.authChoose: (context) => AuthChoose(),
        LoginScreen.loginscreen: (context) => LoginScreen(),
        signUpScreen.signupscreen: (context) => signUpScreen(),
        ConfirmEmail.confirmEmail: (context) => ConfirmEmail(),
        ComplainScreen.complainScreen: (context) => ComplainScreen(),
        PreviousMeritLists.previousMeritList: (context) => PreviousMeritLists(),
        AdmissionFormScreen1.admissionFormScreen1: (context) => AdmissionFormScreen1(),
        AdmissionFormScreen2.admissionFormScreen2: (context) => AdmissionFormScreen2(),
        AdmissionFormScreen3.admissionFormScreen3: (context) => AdmissionFormScreen3(),
        AdmissionFormScreen4.admissionFormScreen4: (context) => AdmissionFormScreen4()
      },
    );
  }
}

// userEmail == null ? LoginScreen() :