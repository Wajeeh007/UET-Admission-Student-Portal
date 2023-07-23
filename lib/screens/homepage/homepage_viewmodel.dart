import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_admission/model/merit_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../base/base_layout_viewmodel.dart';

class HomePageViewModel extends GetxController {

  RxBool transformContainer = false.obs;
  RxDouble angle = 0.0.obs;
  RxString fieldName = 'Search fields merit here'.obs;
  Rx<Uint8List> fileBytes = Uint8List(0).obs;
  Rx<Uint8List> csvBytes = Uint8List(0).obs;
  RxString filePath = ''.obs;
  RxList<String> meritListInString = <String>[].obs;
  RxList<MeritModel> meritList = <MeritModel>[].obs;
  RxBool meritListVisibilty = false.obs;
  RxString userName = ''.obs;

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
                meritList.add(MeritModel(meritNumber: elementSplit[0], studentName: elementSplit[1], fatherName: elementSplit[2], aggregate: elementSplit[3], eligibility: elementSplit[4]));
                meritList.refresh();
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
}