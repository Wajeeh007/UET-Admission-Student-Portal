import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:online_admission/screens/admission_form/screen_three/screen_three_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenThreeViewModel extends GetxController{

  TextEditingController yearController = TextEditingController();
  TextEditingController rollNumberController = TextEditingController();
  TextEditingController boardNameController = TextEditingController();
  TextEditingController marksObtainedController = TextEditingController();
  TextEditingController totalMarksController = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  RxString paperSelect = ''.obs;
  RxBool paperSelectionCheck = false.obs;
  RxBool loader = false.obs;

  List paperSelection=['Annual', 'Supplementary'];

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var thirdPageDetailsInString = await prefs.getString('3');
    if(thirdPageDetailsInString == null){
      return;
    }
    else{
      var details = ThirdPageModel.fromJson(jsonDecode(thirdPageDetailsInString));
      yearController.text = details.year.toString();
      rollNumberController.text = details.rollNo.toString();
      boardNameController.text = details.boardName.toString();
      paperSelect.value = details.paperType.toString();
      marksObtainedController.text = details.obtainedMarks.toString();
      totalMarksController.text = details.totalMarks.toString();
      percentageController.text = details.percentage.toString();
    }
  }
}