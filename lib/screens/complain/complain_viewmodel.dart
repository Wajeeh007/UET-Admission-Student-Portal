import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:online_admission/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComplainViewModel extends GetxController{

  TextEditingController complainTitle = TextEditingController();
  TextEditingController complainDescrition = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool overlay = false.obs;

  validateForms(){
    overlay.value = true;
    final form = formKey.currentState;
    if(form!.validate()){
      uploadComplain();
    } else {
      overlay.value = true;
      return null;
    }
  }

  uploadComplain()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userName = await prefs.getString('userName');
    await FirebaseFirestore.instance.collection('complains').doc(userID).set({
      'name': userName.toString(),
      'title': complainTitle.text,
      'description': complainDescrition.text,
    }).then((value) {
      complainTitle.clear();
      complainDescrition.clear();
      overlay.value = false;
      showToast('Complain sent');
    }).catchError((e){
      overlay.value = false;
      showToast('Complain cannot be sent due to $e');
    });
  }
}