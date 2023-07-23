import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:online_admission/constants.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpViewModel extends GetxController {

  RxString name = ''.obs;
  RxBool overlay = false.obs;
  RxBool proceed = false.obs;
  final formKey = GlobalKey<FormState>();
  Rx<io.File?> imageFile = io.File('').obs;
  final ImagePicker _picker = ImagePicker();
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxBool imageUploadError = false.obs;
  RxBool passwd1Visibility = true.obs;
  RxBool passwd2Visibility = true.obs;
  var password1FieldIcon = const Icon(Icons.visibility_off, color: Colors.white,).obs;
  var password2FieldIcon = const Icon(Icons.visibility_off, color: Colors.white,).obs;

  password1VisibilityFunc() {
    if (passwd1Visibility.value == true) {
        passwd1Visibility.value = false;
        password1FieldIcon.value = const Icon(Icons.visibility_outlined, color: Colors.white,);
    }
    else {
        passwd1Visibility.value = true;
        password1FieldIcon.value = const Icon(Icons.visibility_off, color: Colors.white,);
    }
  }

  password2VisibilityFunc() {
    if (passwd2Visibility.value == true) {
        passwd2Visibility.value = false;
        password2FieldIcon.value = const Icon(Icons.visibility_outlined, color: Colors.white,);
    }
    else {
        passwd2Visibility.value = true;
        password2FieldIcon.value = const Icon(Icons.visibility_off, color: Colors.white,);
    }
  }

  bool validateAndSave() {
    // Validate if entries in form are according to the validators
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    else {
      return false;
    }
  }

  dynamic validateAndSubmit() async {
    // Validate the entered data and move towards Signing In the user
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (validateAndSave() == true) {
      try {
        final methods = await _auth.fetchSignInMethodsForEmail(email.value);
        if(methods.isEmpty) {
          final newUser = await _auth.createUserWithEmailAndPassword(
              email: email.value, password: password.value);
          if (newUser.runtimeType == UserCredential) {
            final ref = FirebaseStorage.instance.ref().child('user_docs').child(newUser.user!.uid).child('DP');
            final uploadFile = ref.putFile(io.File(imageFile.value!.path));
            final snapshot = await uploadFile.whenComplete(() {});
            final downloadURL = await snapshot.ref.getDownloadURL();
            await FirebaseFirestore.instance.collection('user_data').doc(newUser.user!.uid).set({
              'admin': false,
              'email': email.value,
              'application_status': false,
              'user_id': newUser.user?.uid,
              'documents_accepted': false,
              'display_image': downloadURL,
              'name': 'abc'
            });
            final userEmail = email.value;
            final userName = newUser.user?.displayName;
            final userId = newUser.user?.uid;
            Uint8List imageBytes = await io.File(imageFile.value!.path).readAsBytes();
            await prefs.setString('userName', userName.toString());
            await prefs.setString('email', userEmail.toString());
            await prefs.setString('userID', userId.toString());
            await prefs.setString('displayImage', imageBytes.toString());
            userID = userId;
            overlay.value = false;
            proceed.value = true;
          }
        } else{
          overlay.value = false;
          showToast('User already exists');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-already-exists') {
          overlay.value = false;
          showToast('User already exists');
        }
        else if (e.code == 'session-cookie-expired') {
          overlay.value = false;
          showToast('Failed to Sign Up.\nTry Again');
        }
        else if (e.code == 'network-request-failed') {
          overlay.value = false;
          showToast('Servers cannot be reached at the moment due to Network Error.\nCheck your Internet connection and try again');
        }
        else {
          overlay.value = false;
          showToast('Cannot Sign Up.\nTry again in a while');
        }
      }
    }
  }

  pickImage(ImageSource src)async{
    final pickedFile = await _picker.pickImage(source: src);
    if(pickedFile != null){
      imageFile.value = io.File(pickedFile.path);
      imageUploadError.value = false;
      Get.back();
    }
  }

}