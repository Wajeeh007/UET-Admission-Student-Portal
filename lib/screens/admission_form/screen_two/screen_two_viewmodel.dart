import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:online_admission/screens/admission_form/screen_two/screen_two_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenTwoViewModel extends GetxController{

  TextEditingController presentAddress = TextEditingController();
  TextEditingController permanentAddress = TextEditingController();
  TextEditingController incomeInLetters = TextEditingController();
  TextEditingController nameOfEmployer = TextEditingController();
  TextEditingController addressOfEmployer = TextEditingController();
  TextEditingController obtainedMarks = TextEditingController();
  TextEditingController totalMarks = TextEditingController();
  TextEditingController percentage = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController rollNumber = TextEditingController();
  TextEditingController nameOfBoard = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List incomeSelection=['Father', 'Guardian'];
  List seatType = ['Open', 'Close'];
  List paperSelection=['Annual', 'Supplementary'];

  RxBool loader = false.obs;
  RxString seatTypeSelected = ''.obs;
  RxString incomeSelect = ''.obs;
  RxString paperSelect = ''.obs;
  RxBool seatTypeSelectionCheck = false.obs;
  RxBool incomeSelectionCheck = false.obs;
  RxBool paperSelectionCheck = false.obs;

  @override
  void onInit() async{
    await getData();
    super.onInit();
  }

  getData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var secondPageDetailsInString = await prefs.getString('2');
    if(secondPageDetailsInString == null){
      return;
    }
    else{
      final details = SecondPageModel.fromJson(jsonDecode(secondPageDetailsInString));
      presentAddress.text = details.presentAddress.toString();
      permanentAddress.text = details.permanentAddress.toString();
      incomeInLetters.text = details.incomeInLetters.toString();
      incomeSelect.value = details.incomeSource.toString();
      seatTypeSelected.value = details.seatType.toString();
      nameOfEmployer.text = details.employerName.toString();
      addressOfEmployer.text = details.employerAddress.toString();
      year.text = details.year.toString();
      rollNumber.text = details.rollNumber.toString();
      nameOfBoard.text = details.boardName.toString();
      paperSelect.value = details.paperType.toString();
      obtainedMarks.text = details.obtainedMarks.toString();
      totalMarks.text = details.totalMarks.toString();
      percentage.text = details.percentage.toString();
    }
  }
}