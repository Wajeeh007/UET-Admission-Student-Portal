import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_admission/screens/admission_form/screen_one/screen_one_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenOneViewModel extends GetxController{

  TextEditingController meritNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController fatherOccupationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController eteaIDController = TextEditingController();

  RxString departmentName = ''.obs;
  RxString campus = ''.obs;
  RxBool departmentNameCheck = false.obs;
  RxBool campusNameCheck = false.obs;
  final formKey = GlobalKey<FormState>();
  List maritalStatus=['Single', 'Married'];
  RxString maritalStatusSelect = 'Single'.obs;
  RxBool loader = false.obs;
  var currentDateTime = DateTime.now();
  var currentYear;
  RxBool campusFieldVisibility = false.obs;
  RxList<DropdownMenuItem> campusList = <DropdownMenuItem>[].obs;
  RxBool formSubmittedCheck = false.obs;
  RxString userID = ''.obs;

  List<DropdownMenuItem> departmentList = [
    const DropdownMenuItem(value: 'Mechanical',child: Text('Mechanical', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),),
    const DropdownMenuItem(value: 'Electrical',child: Text('Electrical', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),),
    const DropdownMenuItem(value: 'Civil',child: Text('Civil', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),),
    const DropdownMenuItem(value: 'Industrial',child: Text('Industrial', textAlign: TextAlign.end, style: TextStyle(color: Colors.black)),),
    const DropdownMenuItem(value: 'Mechatronics',child: Text('Mechatronics', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),),
    const DropdownMenuItem(value: 'Agriculture',child: Text('Agriculture', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),),
    const DropdownMenuItem(value: 'Mining',child: Text('Mining', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),),
    const DropdownMenuItem(value: 'Chemical',child: Text('Chemical', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),),
    const DropdownMenuItem(value: 'Computer Sciences',child: Text('Computer Sciences', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),),
    const DropdownMenuItem(value:'System Engineering',child: Text('System Engieering', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),),
  ];

  @override
  void onInit() async{
    await getData();
    currentYear = DateTime(currentDateTime.year);
    await getCheckFromFirebase();
    super.onInit();
  }

  getCheckFromFirebase()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final formCheckInStrg = await prefs.getBool('formSubmitted');
    if(formCheckInStrg != null && formCheckInStrg != false){
      formSubmittedCheck.value = true;
    }
    if(formSubmittedCheck.value == false){
      var userData = FirebaseFirestore.instance.collection('user_data').doc(userID.value);
      final docCheck = await userData.get();
      final formSubmitted = docCheck.get('application_status');
      if(formSubmitted == false){
        return;
      }
      else{
        await prefs.remove('formSubmitted');
        await prefs.setBool('formSubmitted', true);
      }
    }
  }

  getData()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID.value = await prefs.getString('userID').toString();
    var firstPageDetailsInString = await prefs.getString('1');
    if (firstPageDetailsInString == null) {
      departmentList.insert(0, DropdownMenuItem(value: 'Choose Department',child: Text('Choose Department', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade800, fontSize: 12),),));
      departmentName.value = 'Choose Department';
      campusList.add(DropdownMenuItem(value: 'Choose Campus', child: Text('Choose Campus', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade800, fontSize: 12),)));
      campus.refresh();
      campus.value = 'Choose Campus';
    }
    else {
      final details = FirstPageModel.fromJson(jsonDecode(firstPageDetailsInString));
        eteaIDController.text = details.eteaID.toString();
        meritNumberController.text = details.meritListNo.toString();
        departmentName.value = details.departmentName.toString();
        campus.value = details.campusName.toString();
        campusFieldVisibility.value = true;
        fatherNameController.text = details.fatherName.toString();
        fatherOccupationController.text = details.fatherOccupation.toString();
        dateController.text = details.dateOfBirth.toString();
        religionController.text = details.religion.toString();
        mobileNumberController.text = details.mobileNo.toString();
        cnicController.text = details.cnic.toString();
        nationalityController.text = details.nationality.toString();
        maritalStatusSelect.value = details.maritalStatus.toString();
        nameController.text = details.studentName.toString();
      departmentName.value == 'Mechanical' || departmentName.value == 'Computer Sciences' ||
          departmentName.value == 'Industrial' ? campusList.addAll([
        const DropdownMenuItem(value: 'Peshawar', child: Text('Peshawar', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
        const DropdownMenuItem(value: 'Jalozai', child: Text('Jalozai', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
      ]) : departmentName.value == 'Electrical' ? campusList.addAll([
        const DropdownMenuItem(value: 'Peshawar', child: Text('Peshawar', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
        const DropdownMenuItem(value: 'Jalozai', child: Text('Jalozai', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
        const DropdownMenuItem(value: 'Kohat', child: Text('Kohat', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
        const DropdownMenuItem(value: 'Bannu', child: Text('Bannu', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
      ]) : departmentName.value == 'Civil' ? campusList.addAll([
        const DropdownMenuItem(value: 'Peshawar', child: Text('Peshawar', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
        const DropdownMenuItem(value: 'Jalozai', child: Text('Jalozai', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
        const DropdownMenuItem(value: 'Bannu', child: Text('Bannu', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
      ]) : campusList.add(
        const DropdownMenuItem(value: 'Peshawar', child: Text('Peshawar', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
      );
    }
  }

  changeList(String departmentName){
    campusList.clear();
    campusList.add(DropdownMenuItem(value: 'Choose Campus',
          child: Text('Choose Campus', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade800, fontSize: 12),),)
    );
    if(departmentName == 'Mechanical' || departmentName == 'Computer Sciences' || departmentName == 'Industrial'){
      campusList.addAll([
        const DropdownMenuItem(value: 'Peshawar', child: Text('Peshawar', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
        const DropdownMenuItem(value: 'Jalozai', child: Text('Jalozai', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
      ]);
    } else if(departmentName == 'Electrical') {
      campusList.addAll([
        const DropdownMenuItem(value: 'Peshawar', child: Text('Peshawar', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
        const DropdownMenuItem(value: 'Jalozai', child: Text('Jalozai', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
        const DropdownMenuItem(value: 'Kohat', child: Text('Kohat', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
        const DropdownMenuItem(value: 'Bannu', child: Text('Bannu', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
      ]);
    } else if(departmentName == 'Civil'){
      campusList.addAll([
        const DropdownMenuItem(value: 'Peshawar', child: Text('Peshawar', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
        const DropdownMenuItem(value: 'Jalozai', child: Text('Jalozai', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
        const DropdownMenuItem(value: 'Bannu', child: Text('Bannu', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
      ]);
    } else {
      campusList.add(
        const DropdownMenuItem(value: 'Peshawar', child: Text(
          'Peshawar', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        ),
      );
    }
      campusList.refresh();
      campusFieldVisibility.value = true;
    }
}