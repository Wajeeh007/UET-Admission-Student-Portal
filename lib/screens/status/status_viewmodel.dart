import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_admission/constants.dart';
import 'package:online_admission/screens/admission_form/screen_four/screen_four_model.dart';
import 'package:online_admission/screens/base/base_layout_viewmodel.dart';
import 'dart:io';
import 'package:pdfx/pdfx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusViewModel extends GetxController{

  RxDouble fillStop = 0.03.obs;
  RxString feedbackMessage = ''.obs;
  RxString firstOrSecondPageMessage = ''.obs;
  RxBool firstOrSecondPageRejection = false.obs;
  RxList<FourthPageModel> docsList = <FourthPageModel>[].obs;
  RxBool dataVisibility = false.obs;
  final ImagePicker _picker = ImagePicker();
  RxBool overlay = false.obs;
  RxBool proceed = false.obs;
  RxBool formSubmitted = false.obs;
  RxMap<String, dynamic> downloadLinks = <String, dynamic>{}.obs;

  @override
  void onInit() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final check = await prefs.getBool('formSubmitted');
    if(check == null){}
    else{
      fillStop.value = 0.3;
      formSubmitted.value = check;
    }
    getApplicationStatus();
    super.onInit();
  }

  getApplicationStatus()async{
    await FirebaseFirestore.instance.collection('user_data').doc(userID).get().then((doc) async{
        final data = doc.data();
        if(data == null){
          return;
        } else {
          if(data['application_status'] == true){
            fillStop.value = 0.3;
          }
          else if (data['documents_accepted'] == true) {
            fillStop.value = 0.9;
          } else {
            if (data.containsKey('form_details_checked')) {
              if (data['fee_slip_checked'] == false &&
                  data['form_details_checked'] == false) {
                return;
              } else {
                await getRejectedData();
              }
            }
          }
        }
    });
  }

  getRejectedData()async{
    await FirebaseFirestore.instance.collection('upload_doc_again').doc(userID).get().then((doc) {
      final data = doc.data();
      dataVisibility.value = true;
      if(data == null){
        return;
      }else {
        feedbackMessage.value = data['feedback_message'];
        if (data.containsKey('first_page_details')) {
          firstOrSecondPageRejection.value = true;
          firstOrSecondPageMessage.value =
          'Your personal details are not correct. Enter correct data and complete details in the fields and submit the form again.';
        } else if (data.containsKey('second_page_details')) {
          firstOrSecondPageRejection.value = true;
          firstOrSecondPageMessage.value =
          'Your academic details are not correct. Enter correct data and complete details in the fields and submit the form again.';
        } else {
          data.forEach((key, value) {
            if (key == 'feedback_message') {
              null;
            } else {
              if (key == 'Father or Mother CNIC') {
                docsList.add(FourthPageModel(fieldName: 'Father/Mother CNIC'));
                docsList.refresh();
              } else if (key == 'CNIC or Form-B') {
                docsList.add(FourthPageModel(fieldName: 'CNIC/Form-B'));
                docsList.refresh();
              } else {
                docsList.add(FourthPageModel(fieldName: key));
                docsList.refresh();
              }
            }
            if(key == data.entries.elementAt(data.length-1).key){
              if(docsList.length == 1){
                if(docsList[0].fieldName == 'Fee Slip'){
                  fillStop.value = 0.3;
                }
              }
            }
          });
        }
      }
    });
  }

  pickImage(int index, ImageSource src)async{
    docsList[index].showLoader = true;
    docsList.refresh();
    final pickedFile = await _picker.pickImage(source: src);
    if(pickedFile != null){
      docsList[index].file = pickedFile.path;
      docsList[index].showError = false;
      docsList.refresh();
      Get.back();
    }
  }

  pickFile({int index = 0})async{
    if(docsList[index].fieldName == 'Fee Slip'){
      showModalBottomSheet(context: Get.context!, builder: (context) {
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: IconButton(
                    onPressed: ()async {
                      await pickImage(index, ImageSource.camera);
                    },
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 40.0, color: Colors.blue,)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: IconButton(
                    onPressed: () async{
                      await pickImage(index, ImageSource.gallery);
                    },
                    icon: const Icon(
                      Icons.folder_copy_outlined,
                      size: 40.0, color: Colors.red,)),
              ),
            ],
          ),
        );
      });
    } else {
      final pickedFile = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      if (pickedFile != null) {
        docsList[index].showLoader = true;
        docsList.refresh();
        final file = File(pickedFile.files.single.path.toString());
        docsList[index].file = file.path;
        await _renderImage(index);
      }
    }
  }

  _renderImage(int index) async {
    final document = await PdfDocument.openFile(docsList[index].file.toString());
    final page = await document.getPage(1);
    final pageRender = await page.render(width: page.width, height: page.height);
    docsList[index].pageImage = pageRender!.bytes;
    await page.close();
    docsList[index].showError = false;
    docsList.refresh();
  }

  checkDocs()async{
    proceed.value = true;
    for (var element in docsList) {
      if(element.file == null || element.file == ''){
        element.showError = true;
        docsList.refresh();
        proceed.value = false;
      }
    }
    overlay.value = true;
    if(proceed.value == true) {
      await FirebaseFirestore.instance.collection('user_data').doc(userID).get().then((doc)async {
        final data = doc.data();
        if(data == null){
          return;
        }else{
          downloadLinks.addAll(data['fourthPageDetails']);
          downloadLinks.forEach((key, value) {
            if(key == 'Mother or Father CNIC'){
              key = 'Mother/Father CNIC';
              downloadLinks.refresh();
            } else if(key == 'CNIC or Form-B'){
              key = 'CNIC/Form-B';
              downloadLinks.refresh();
            }
          });
        }
      });
      docsList.forEach((element)async {
        if(element.fieldName == 'Father/Mother CNIC'){
          element.fieldName = 'Father or Mother CNIC';
        } else if(element.fieldName == 'CNIC/Form-B'){
          element.fieldName = 'CNIC or Form-B';
        } else if(element.fieldName == 'Fee Slip'){
          await uploadFeeSlip(element.file.toString());
          return;
        }
        await FirebaseStorage.instance.ref().child('user_docs').child(userID.toString()).child(element.fieldName.toString()).delete();
        final ref = FirebaseStorage.instance.ref().child('user_docs').child(userID.toString()).child(element.fieldName.toString());
        final uploadTask = ref.putFile(File(element.file.toString()));
        final snapshot = await uploadTask.whenComplete(() {});
        final downloadURL = await snapshot.ref.getDownloadURL();
        downloadLinks.remove(element.fieldName.toString());
        downloadLinks.addAll({
          element.fieldName.toString() : downloadURL
        });
        if(element == docsList.last){
          await FirebaseFirestore.instance.collection('user_data').doc(userID).update({
            'fourthPageDetails':downloadLinks,
            'application_status': true,
            'form_details_checked': false,
            'form_details_accepted': false,
            'fee_slip_checked': false,
            'fee_slip_accepted': false,
          });
          await FirebaseFirestore.instance.collection('upload_doc_again').doc(userID).delete();
          overlay.value = false;
          showToast('Uploaded documents.');
          downloadLinks.clear();
          docsList.clear();
          dataVisibility.value = false;
          getApplicationStatus();
          BaseLayoutViewModel baseLayoutViewModel = Get.find();
          baseLayoutViewModel.changePage(0);
        }
      });
    } else{
      overlay.value = false;
      showToast('Upload documents to proceed');
    }
  }

  uploadFeeSlip(String filePath)async{
    await FirebaseStorage.instance.ref().child('user_docs').child(userID.toString()).child('Fee Slip').delete();
    final ref = FirebaseStorage.instance.ref().child('user_docs').child(userID.toString()).child('Fee Slip');
    final uploadTask = ref.putFile(File(filePath));
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadURL = await snapshot.ref.getDownloadURL();
    await FirebaseFirestore.instance.collection('user_data').doc(userID).update({
      'fee_slip': downloadURL,
    });
  }

}