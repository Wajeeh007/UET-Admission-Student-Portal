import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_admission/constants.dart';

class PreviousMeritListViewModel extends GetxController{

  RxBool overlay = false.obs;
  RxString departmentName = 'Search fields merit here'.obs;
  Map<String, dynamic> downloadLinks = <String, dynamic>{};
  RxMap<String, dynamic> downloadLinks1 = <String, dynamic>{}.obs;
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: 'Search fields merit here',
      child: Text('Search fields merit here', textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),),),
    const DropdownMenuItem(value: 'Mechanical',
      child: Text('Mechanical', textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600),),),
    const DropdownMenuItem(value: 'Electrical',
      child: Text('Electrical', textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600),),),
    const DropdownMenuItem(value: 'Civil',
      child: Text('Civil', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600)),),
    const DropdownMenuItem(value: 'Industrial',
      child: Text('Industrial', textAlign: TextAlign.end,
          style: TextStyle(color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600)),),
    const DropdownMenuItem(value: 'Mechatronics',
      child: Text('Mechatronics', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600)),),
    const DropdownMenuItem(value: 'Agriculture',
      child: Text('Agriculture', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600)),),
    const DropdownMenuItem(value: 'Mining',
      child: Text('Mining', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600)),),
    const DropdownMenuItem(value: 'Chemical',
      child: Text('Chemical', textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600)),),
    const DropdownMenuItem(value: 'Computer Sciences',
      child: Text('Computer Sciences', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600)),),
    const DropdownMenuItem(value: 'System Engineering',
      child: Text('System Engieering', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600)),),
    const DropdownMenuItem(value: 'Architecture',
      child: Text('Architecture', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600)),),
  ];

  getPreviousMerits()async{
    print(departmentName.value);
    downloadLinks.clear();
    overlay.value = true;
    await FirebaseFirestore.instance.collection('merit_lists').doc(departmentName.value).get().then((doc){
      final data = doc.data();
      if(data == null){
        overlay.value = false;
        showToast('No Previous Merit Lists of this department');
      } else{
        downloadLinks.addAll(data['all_list']);
        downloadLinks.forEach((key, value) {
          if(key == '1_merit_list'){
            downloadLinks1.addAll({
              'First Merit': value,
            });
          } else if(key == '2_merit_list'){
            downloadLinks1.addAll({
              'Second Merit': value,
            });
          } else if(key == '3_merit_list'){
            downloadLinks1.addAll({
              'Third Merit': value,
            });
          } else if( key == '4_merit_list'){
            downloadLinks1.addAll({
              'Fourth Merit': value,
            });
          } else {
            downloadLinks1.addAll({
              'Fifth Merit': value,
            });
          }
          downloadLinks1.refresh();
        });
        overlay.value = false;
      }
    });
  }
}