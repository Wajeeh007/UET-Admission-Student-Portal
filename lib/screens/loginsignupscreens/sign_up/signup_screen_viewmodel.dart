import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:online_admission/constants.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpModel extends ChangeNotifier {

  String _name = '';
  bool overlay = false;
  bool proceed = false;
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool passwd1Visibility = false;
  bool passwd2Visibility = false;
  Icon password1FieldIcon = const Icon(Icons.visibility_off, color: Colors.grey,);
  Icon password2FieldIcon = const Icon(Icons.visibility_off, color: Colors.grey,);

  changeValue(){
    overlay = !overlay;
    notifyListeners();
  }

  password1VisibilityFunc() {
    if (passwd1Visibility == true) {
        passwd1Visibility = false;
        password1FieldIcon = const Icon(Icons.visibility_outlined, color: Colors.grey,);
        notifyListeners();
    }
    else {
        passwd1Visibility = true;
        password1FieldIcon =
        const Icon(Icons.visibility_off, color: Colors.grey,);
      notifyListeners();
    }
  }

  password2VisibilityFunc() {
    if (passwd2Visibility == true) {
        passwd2Visibility = false;
        password2FieldIcon = const Icon(Icons.visibility_outlined, color: Colors.grey,);
      notifyListeners();
    }
    else {
        passwd2Visibility = true;
        password2FieldIcon =
        const Icon(Icons.visibility_off, color: Colors.grey,);
      notifyListeners();
    }
  }

  bool validateAndSave() {
    // Validate if entries in form are according to the validators
    changeValue();
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    else {
      changeValue();
      return false;
    }
  }

  dynamic validateAndSubmit() async {
    // Validate the entered data and move towards Signing In the user
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (validateAndSave() == true) {
      try {
        final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        if (newUser != null) {
          final userName = _name;
          final userEmail = email;
          final userID = newUser.user!.uid;
          await prefs.setString('userName', userName.toString());
          await prefs.setString('email', userEmail.toString());
          await prefs.setString('userID', userID);
          overlay = false;
          proceed = true;
          notifyListeners();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-already-exists') {
          overlay = false;
          notifyListeners();
          showToast('User already exists');
        }
        else if (e.code == 'session-cookie-expired') {
          overlay = false;
          notifyListeners();
          showToast('Failed to Sign Up.\nTry Again');
        }
        else if (e.code == 'network-request-failed') {
          overlay = false;
          notifyListeners();
          showToast('Servers cannot be reached at the moment due to Network Error.\nCheck your Internet connection and try again');
        }
        else {
          overlay = false;
          notifyListeners();
          showToast('Cannot Sign Up.\nTry again in a while');
        }
      }
    }
  }
}