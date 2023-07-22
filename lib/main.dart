import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
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
  runApp(MyApp(email));
}

class MyApp extends StatelessWidget {

  final String? userEmail;
  
  const MyApp(this.userEmail);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: userEmail == null ? const AuthChoose() : BaseLayout(),
    );
  }
}