import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:online_admission/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class LoginViewModel extends GetxController{

  RxBool overlay = false.obs;
  RxBool proceed = false.obs;
  RxList<Uint8List> documentBytes = <Uint8List>[].obs;
  final formKey = GlobalKey<FormState>();
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxBool passwdVisibility = false.obs;
  var passwordFieldIcon = const Icon(Icons.visibility_off_outlined, color: Colors.white,).obs;

  passwordVisibilityFunc(){
    if(passwdVisibility.value == true){
      passwdVisibility.value = false;
      passwordFieldIcon.value = const Icon(Icons.visibility_off_outlined, color: Colors.white,);
    }
    else{
      passwdVisibility.value = true;
      passwordFieldIcon.value = const Icon(Icons.visibility_outlined, color: Colors.white,);
    }
  }

  bool validateAndSave(){
    // Validate if entries in form are according to the validators
    final form = formKey.currentState;
    if (form!.validate()){
      form.save();
      return true;
    }
    else{
      overlay.value = false;
      return false;
    }
  }

  dynamic validateAndSubmit() async {
    // Validate the entered data and move towards Signing In the user
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(validateAndSave() == true) {
      try {
        final newUser = await _auth.signInWithEmailAndPassword(email: email.value, password: password.value);
        if (newUser.runtimeType == UserCredential) {
          final userId = _auth.currentUser!.uid;
          final doc = await FirebaseFirestore.instance.collection('user_data').doc(userId);
          final docCheck = await doc.get();
          final userName = docCheck.get('name');
          final downloadLink = docCheck.get('display_image');
          List<Uint8List> documentBytes = <Uint8List>[];
          final pdfRef = FirebaseStorage.instanceFor(
              bucket: 'admissionapp-9c884.appspot.com')
              .refFromURL(downloadLink);
          await pdfRef.getData(104857600).then((value) {
            documentBytes.add(value!);
          });
          await prefs.setString('displayImage', documentBytes[0].toString());
          await prefs.setString("userID", userId.toString());
          await prefs.setString('email', email.value);
          await prefs.setString('userName', userName.toString());
          userID = _auth.currentUser!.uid;
          proceed.value = true;
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          overlay.value = false;
          showToast('Incorrect Password');
        }
        else if (e.code == 'user-not-found') {
          overlay.value = false;
          showToast('User does not exist.\nSign Up');
        }
        else if (e.code == 'session-cookie-expired') {
          overlay.value = false;
          showToast('Failed to Log In.\nTry again.');
        }
        else if (e.code == 'network-request-failed') {
          overlay.value = false;
          showToast('Servers cannot be reached at the moment due to Network Error.\nCheck your Internet connection and try again',);
        }
        else {
          overlay.value = false;
          showToast('Cannot log in.\nTry again in a while');
        }
      }
    }
    overlay.value = false;
  }
}