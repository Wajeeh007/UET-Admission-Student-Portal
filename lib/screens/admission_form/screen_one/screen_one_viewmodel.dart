import 'dart:convert';
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
  List<DropdownMenuItem> campusList = [];

  @override
  void onInit() async{
    await getData();
    currentYear = DateTime(currentDateTime.year);
    super.onInit();
  }

  getData()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var firstPageDetailsInString = await prefs.getString('1');
    if (firstPageDetailsInString == null) {
      departmentList.insert(0, DropdownMenuItem(child: Text('Choose Department', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade800, fontSize: 12),), value: 'Choose Department',));
      departmentName.value = 'Choose Department';
      campusList.add(DropdownMenuItem(child: Text('Choose Campus', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade800, fontSize: 12),), value: 'Choose Campus'));
      campus.refresh();
      campus.value = 'Choose Campus';
    }
    else {
      final details = FirstPageModel.fromJson(jsonDecode(firstPageDetailsInString));
        eteaIDController.text = details.eteaID.toString();
        meritNumberController.text = details.meritListNo.toString();
        departmentName.value = details.departmentName.toString();
        campus.value = details.campusName.toString();
        fatherNameController.text = details.fatherName.toString();
        fatherOccupationController.text = details.fatherOccupation.toString();
        dateController.text = details.dateOfBirth.toString();
        religionController.text = details.religion.toString();
        mobileNumberController.text = details.mobileNo.toString();
        cnicController.text = details.cnic.toString();
        nationalityController.text = details.nationality.toString();
        maritalStatusSelect.value = details.maritalStatus.toString();
        nameController.text = details.studentName.toString();
    }
    departmentName.value == 'Mechanical' || departmentName.value == 'Computer Sciences' ||
        departmentName.value == 'Industrial' ? campusList.addAll([
      DropdownMenuItem(child: Text('Peshawar', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),), value: 'Peshawar'),
      DropdownMenuItem(child: Text('Jalozai', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),), value: 'Jalozai'),
    ]) : departmentName.value == 'Electrical' ? campusList.addAll([
      DropdownMenuItem(child: Text('Peshawar', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),), value: 'Peshawar'),
      DropdownMenuItem(child: Text('Jalozai', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),), value: 'Jalozai'),
      DropdownMenuItem(child: Text('Kohat', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),), value: 'Kohat'),
      DropdownMenuItem(child: Text('Bannu', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),), value: 'Bannu'),
    ]) : departmentName.value == 'Civil' ? campusList.addAll([
      DropdownMenuItem(child: Text('Peshawar', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),), value: 'Peshawar'),
      DropdownMenuItem(child: Text('Jalozai', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),), value: 'Jalozai'),
      DropdownMenuItem(child: Text('Bannu', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),), value: 'Bannu'),
    ]) : campusList.add(
      DropdownMenuItem(child: Text('Peshawar', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),), value: 'Peshawar'),
    );
  }

  List<DropdownMenuItem> departmentList = [
    const DropdownMenuItem(child: Text('Mechanical', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),), value: 'Mechanical',),
    const DropdownMenuItem(child: Text('Electrical', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),), value: 'Electrical',),
    const DropdownMenuItem(child: Text('Civil', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), value: 'Civil',),
    const DropdownMenuItem(child: Text('Industrial', textAlign: TextAlign.end, style: TextStyle(color: Colors.black)), value: 'Industrial',),
    const DropdownMenuItem(child: Text('Mechatronics', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), value: 'Mechatronics',),
    const DropdownMenuItem(child: Text('Agriculture', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), value: 'Agriculture',),
    const DropdownMenuItem(child: Text('Mining', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), value: 'Mining',),
    const DropdownMenuItem(child: Text('Chemical', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), value: 'Chemical',),
    const DropdownMenuItem(child: Text('Computer Sciences', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), value: 'Computer Sciences',),
    const DropdownMenuItem(child: Text('System Engieering', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), value:'System Engineering',),
  ];
}