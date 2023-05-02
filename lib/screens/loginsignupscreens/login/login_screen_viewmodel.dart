import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_admission/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class loginModel with ChangeNotifier{

  bool overlay = false;
  bool proceed = false;
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool passwdVisibility = false;
  Icon passwordFieldIcon = const Icon(Icons.visibility_off_outlined, color: Colors.grey,);

  passwordVisibilityFunc(){
    if(passwdVisibility == true){
      passwdVisibility = false;
      passwordFieldIcon = const Icon(Icons.visibility_outlined, color: Colors.grey,);
      notifyListeners();
    }
    else{
      passwdVisibility = true;
      passwordFieldIcon = const Icon(Icons.visibility_off_outlined, color: Colors.grey,);
      notifyListeners();
    }
  }

  changeValue(){
    overlay = !overlay;
    notifyListeners();
  }

  bool validateAndSave(){
    // Validate if entries in form are according to the validators
    changeValue();
    final form = formKey.currentState;
    if (form!.validate()){
      form.save();
      return true;
    }
    else{
      changeValue();
      return false;
    }
  }

  dynamic validateAndSubmit() async {
    // Validate the entered data and move towards Signing In the user
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(validateAndSave() == true) {
      try {
        final newUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
        if (newUser == UserCredential) {
          final userID = _auth.currentUser!.uid;
          final doc = await FirebaseFirestore.instance.collection('user_data').doc(userID);
          final docCheck = await doc.get();
          final userName = docCheck.get('name');
          await prefs.setString("userID", userID.toString());
          await prefs.setString('email', email);
          await prefs.setString('userName', userName.toString());
          proceed = true;
          notifyListeners();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          changeValue();
          showToast('Incorrect Password');
        }
        else if (e.code == 'user-not-found') {
          changeValue();
          showToast('User does not exist.\nSign Up');
        }
        else if (e.code == 'session-cookie-expired') {
          changeValue();
          showToast('Failed to Log In.\nTry again.');
        }
        else if (e.code == 'network-request-failed') {
          changeValue();
          showToast('Servers cannot be reached at the moment due to Network Error.\nCheck your Internet connection and try again',);
        }
        else {
          changeValue();
          showToast('Cannot log in.\nTry again in a while');
        }
      }
    }
    changeValue();
  }
}