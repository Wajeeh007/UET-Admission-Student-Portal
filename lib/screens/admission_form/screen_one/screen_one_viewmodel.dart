import 'dart:convert';
import 'package:image/image.dart' as im;
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_admission/screens/admission_form/screen_one/screen_one_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../../model/merit_model.dart';
import '../../base/base_layout_viewmodel.dart';

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
  Rx<Uint8List> csvBytes = Uint8List(0).obs;
  var currentYear;
  im.Image barcodeImage = im.Image(width: 60, height: 50);
  RxBool campusFieldVisibility = false.obs;
  RxList<DropdownMenuItem> campusList = <DropdownMenuItem>[].obs;
  RxString userID = ''.obs;
  RxList<String> meritListInString = <String>[].obs;
  RxList<MeritModel> dataList = <MeritModel>[].obs;

  List<DropdownMenuItem> departmentList = [
    const DropdownMenuItem(value: 'Architecture',child: Text('Architecture', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),),
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
    super.onInit();
  }

  checkEligibility(String name)async{
    BaseLayoutViewModel baseLayoutViewModel = Get.find();
    baseLayoutViewModel.overlay.value = true;
    try{
      await FirebaseFirestore.instance.collection('merit_lists').doc(name).get().then((doc) async{
        if(doc.exists){
          final data = doc.data();
          if(data == null){
            showToast('No Merit Lists');
            campusFieldVisibility.value = true;
          } else{
            final downloadLink = data['merit_list'];
            final csvRef = FirebaseStorage.instanceFor(
                bucket: 'admissionapp-9c884.appspot.com').refFromURL(downloadLink);
            await csvRef.getData(104857600).then((value) {
              csvBytes.value = value!;
              final string = String.fromCharCodes(csvBytes.value);
              LineSplitter ls = const LineSplitter();
              meritListInString.value = ls.convert(string);
              meritListInString.forEach((element) {
                List<String> elementSplit = element.split(",");
                dataList.add(MeritModel(eteaNumber: elementSplit[0], meritNumber: elementSplit[1], studentName: elementSplit[2], fatherName: elementSplit[3], aggregate: elementSplit[4], eligibility: elementSplit[5]));
                dataList.refresh();
                if(element == meritListInString.last){
                  final index = dataList.indexWhere((element) => element.eteaNumber == eteaIDController.text);
                  if(index == -1){
                    showToast('You\'re not in the merit list');

                  } else{
                    if(dataList[index].eligibility == 'No'){
                      showToast('You\'re not eligible to apply for $name department');
                    } else{
                      departmentName.value = name;
                      departmentNameCheck.value = false;
                      campusFieldVisibility.value = true;
                    }
                  }
                }
              });
              baseLayoutViewModel.overlay.value = false;
            });
            baseLayoutViewModel.overlay.value = false;
          }
        } else{
          baseLayoutViewModel.overlay.value = false;
          showToast('No Merit list');
          changeList(departmentName.value);
          campusFieldVisibility.value = true;
        }
      });
    } catch (e){
      baseLayoutViewModel.overlay.value = false;
      showToast('Error: $e');
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
      ]) : departmentName.value == 'Architecture' ? campusList.add(const DropdownMenuItem(value: 'Abbottabad', child: Text('Abbottabad', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),)
          : campusList.add(
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