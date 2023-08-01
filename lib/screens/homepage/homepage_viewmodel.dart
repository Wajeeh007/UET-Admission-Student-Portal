import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_admission/model/merit_model.dart';
import 'package:online_admission/screens/admission_form/screen_one/screen_one_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../base/base_layout_viewmodel.dart';

class HomePageViewModel extends GetxController {

  RxString filterEteaId = ''.obs;
  RxBool transformContainer = false.obs;
  RxDouble angle = 0.0.obs;
  RxString fieldName = 'Search fields merit here'.obs;
  Rx<Uint8List> fileBytes = Uint8List(0).obs;
  Rx<Uint8List> csvBytes = Uint8List(0).obs;
  RxString filePath = ''.obs;
  RxList<String> meritListInString = <String>[].obs;
  RxList<MeritModel> filteredList = <MeritModel>[].obs;
  RxList<MeritModel> completeList = <MeritModel>[].obs;
  RxBool meritListVisibilty = false.obs;
  RxString userName = ''.obs;
  TextEditingController meritSearchController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> fields = <DropdownMenuItem<String>>[
    const DropdownMenuItem(value: 'Search fields merit here',
      child: Text('Search fields merit here', textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.grey, fontSize: 17, fontWeight: FontWeight.w400),),),
    const DropdownMenuItem(value: 'Mechanical',
      child: Text('Mechanical', textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600),),),
    const DropdownMenuItem(value: 'Electrical',
      child: Text('Electrical', textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600),),),
    const DropdownMenuItem(value: 'Civil',
      child: Text('Civil', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600)),),
    const DropdownMenuItem(value: 'Industrial',
      child: Text('Industrial', textAlign: TextAlign.end,
          style: TextStyle(color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600)),),
    const DropdownMenuItem(value: 'Mechatronics',
      child: Text('Mechatronics', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600)),),
    const DropdownMenuItem(value: 'Agriculture',
      child: Text('Agriculture', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600)),),
    const DropdownMenuItem(value: 'Mining',
      child: Text('Mining', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600)),),
    const DropdownMenuItem(value: 'Chemical',
      child: Text('Chemical', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600)),),
    const DropdownMenuItem(value: 'Computer Sciences',
      child: Text('Computer Sciences', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600)),),
    const DropdownMenuItem(value: 'System Engineering',
      child: Text('System Engieering', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600)),),
    const DropdownMenuItem(value: 'Architecture',
      child: Text('Architecture', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600)),),
  ];

  @override
  void onInit()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName.value = await prefs.getString('userName').toString();
    getImage();
    super.onInit();
  }

  getImage()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    filePath.value = await prefs.getString('displayImage').toString();
    List<int> list =
    filePath.value.replaceAll('[', '').replaceAll(']', '')
        .split(',')
        .map<int>((e) {
      return int.parse(e); //use tryParse if you are not confirm all content is int or require other handling can also apply it here
    }).toList();
    fileBytes.value = Uint8List.fromList(list);
  }

  getMeritList()async{

    BaseLayoutViewModel baseLayoutViewModel = Get.find();
    baseLayoutViewModel.overlay.value = true;
    try{
      await FirebaseFirestore.instance.collection('merit_lists').doc(fieldName.value).get().then((doc) async{
        if(doc.exists){
          final data = doc.data();
          if(data == null){
            showToast('No Merit Lists');
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
                filteredList.add(MeritModel(eteaNumber: elementSplit[0], meritNumber: elementSplit[1], studentName: elementSplit[2], fatherName: elementSplit[3], aggregate: elementSplit[4], eligibility: elementSplit[5]));
                filteredList.refresh();
                completeList.add(MeritModel(eteaNumber: elementSplit[0], meritNumber: elementSplit[1], studentName: elementSplit[2], fatherName: elementSplit[3], aggregate: elementSplit[4], eligibility: elementSplit[5]));
                completeList.refresh();
                meritListVisibilty.value = true;
              });
              baseLayoutViewModel.overlay.value = false;
            });
          }
        } else{
          baseLayoutViewModel.overlay.value = false;
          showToast('No Merit list');
        }
      });
    } catch (e){
      baseLayoutViewModel.overlay.value = false;
      showToast('Error: $e');
    }
  }

  filterMeritList(String value){
    filteredList.clear();
    if(value == ''){
      completeList.forEach((element) {
        filteredList.add(element);
        filteredList.refresh();
      });
    } else {
      completeList.forEach((element) {
        if (element.eteaNumber!.contains(value)) {
          filteredList.add(element);
          filteredList.refresh();
        }
      });
    }
  }

  checkEligibility()async{

    final index = completeList.indexWhere((element) => element.eteaNumber == filterEteaId.value);
    if(index == -1){
      showToast('Etea ID not in merit list');
    } else{
      if(completeList[index].eligibility == 'No'){
        showToast('Not eligible to apply for ${fieldName.value}');
      } else {
        BaseLayoutViewModel baseLayoutViewModel = Get.find();
        if (baseLayoutViewModel.formSubmitted.value == false) {
          Get.to(() => ScreenOneView(), arguments: [{
            'ETEA ID': filterEteaId.value,
            'Department': fieldName.value,
          }]);
        } else{
          showToast('An admission form has already been submitted with this account');
        }
      }
    }

  }

}