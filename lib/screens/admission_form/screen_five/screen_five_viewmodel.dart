import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_admission/constants.dart';
import 'package:online_admission/screens/admission_form/screen_one/screen_one_model.dart';
import 'package:online_admission/screens/base/base_layout_viewmodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'dart:io' as io;
import 'package:pdf/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen_four/screen_four_model.dart';
import '../screen_three/screen_three_model.dart';
import '../screen_two/screen_two_model.dart';
import 'package:barcode_image/barcode_image.dart';
import 'package:image/image.dart' as im;

class ScreenFiveViewModel extends GetxController{

  final pdf = Document().obs;
  RxBool loader = false.obs;
  RxBool fileUploadedCheck = false.obs;
  Map<String, String> downloadLinks = {};
  String feeSlip = '';
  final docsList = <FourthPageModel>[].obs;
  late SharedPreferences prefs;
  RxString userID = ''.obs;
  final ImagePicker _picker = ImagePicker();
  Rx<io.File?> imageFile = io.File('').obs;
  im.Image barcodeImage = im.Image(width: 60, height: 20);
  String barcodePath = '';

  @override
  void onInit() async{
    prefs = await SharedPreferences.getInstance();
    userID.value = (await prefs.getString('userID'))!;
    super.onInit();
  }

  Future<Uint8List> createPDF()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = await prefs.getString('1');
    var jsonData = jsonDecode(data!);
    FirstPageModel details = FirstPageModel.fromJson(jsonData);
    im.fill(barcodeImage, color: im.ColorRgb8(255, 255, 255));
    drawBarcode(barcodeImage, Barcode.code128(), details.eteaID.toString(), font: im.arial14);
    final barcode = io.File('/storage/emulated/0/Documents/barcode.png');
    await barcode.writeAsBytes(im.encodePng(barcodeImage));
    barcodePath = barcode.path;

    var pdf = Document();
    pdf.addPage(
      Page(
          build: (context){
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                feeSlipSection('BANK COPY', details),
                SizedBox(
                  width: 25
                ),
                feeSlipSection('UNIVERSITY COPY', details),
              ]
            ),
            Center(child: Text('..........................................................................................................................')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                feeSlipSection('DEPARTMENT COPY', details),
                SizedBox(
                  width: 25
                ),
                feeSlipSection('STUDENT COPY', details)
              ]
            )
          ]
        );
      })
    );
    final bytes = await pdf.save();
    var externalPath = await getExternalStorageDirectory();
    try {
      int? i = await prefs.getInt('i');
      i ??= 0;
      await io.File('/storage/emulated/0/Download/feeSlip$i.pdf').writeAsBytes(bytes, );
      i++;
      await prefs.setInt('i', i);
    } catch (e){
      int? i = await prefs.getInt('i');
      if(i == null){
        i = 0;
      }
      if(e=='file already exists'){
        io.File('${externalPath?.path}/feeSlip$i.pdf').writeAsBytesSync(bytes);
        // await file.writeAsBytes(bytes);
        i += 1;
        await prefs.setInt('i', i);
      }
    }
     return pdf.save();
  }

  pickFile(ImageSource src)async{
    final pickedFile = await _picker.pickImage(source: src);
    if(pickedFile != null){
      imageFile.value = io.File(pickedFile.path);
      fileUploadedCheck.value = false;
      Get.back();
    }
  }

  Padding feeSlipSection(String copyName, FirstPageModel details){
    final currentDateTime = DateTime.now();
    final currentYear = currentDateTime.year;
    final image = MemoryImage(io.File(barcodePath).readAsBytesSync());
    return Padding(
    padding: const EdgeInsets.symmetric(vertical: 25),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(image),
              SizedBox(height: 8),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('UNIV. OF ENGG & TECH., PESHAWAR')),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 110,
                  decoration: const BoxDecoration(
                    color: PdfColor(0,0,0,1),
                  ),
                  child: Center(child: Text('AccNo.251807658', style: TextStyle(
                      color: const PdfColor(1,1,1,1),
                      fontWeight: FontWeight.bold,
                    fontSize: 11
                  ),
                      textAlign: TextAlign.center),
                  ),
                ),
                SizedBox(
                  width: 11
                ),
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    color: PdfColor(0,0,0,1),
                  ),
                  child: Center(
                    child: Text(copyName, style: TextStyle(
                        color: const PdfColor(1,1,1,1),
                        fontWeight: FontWeight.bold,
                      fontSize: 11
                    ),
                        textAlign: TextAlign.center),),
                ),
              ]
          ),
          SizedBox(
              height: 6
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text('UBL. Univ. Campus Branch'),
          ),
          SizedBox(
              height: 12
          ),
          Container(
              width: 240,
              height: 180,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                  border: Border.all(
                      width: 1,
                      color: const PdfColor(0,0,0,1)
                  )
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                            children: [
                              Text(
                                  'ETEA ID: ${details.eteaID}'),
                              SizedBox(
                                  width: 20
                              ),
                              Text('Term: Fall $currentYear')
                            ]
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child:Text(
                            'Name: ${details.studentName}',
                          ),),
                        SizedBox(
                            height: 4
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child:Text(
                              'S/D/o: ${details.fatherName}',
                            )),
                        SizedBox(
                            height: 4
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child:Text(
                              'Program: ${details.departmentName}',
                            )),
                        SizedBox(
                            height: 10
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child:Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.5, color: const PdfColor(0, 0, 0))
                                    ),
                                    child: Center(child: Text('Amount: 67,777/-', style: TextStyle(fontWeight: FontWeight.bold)))
                                )
                            )
                        ),
                        SizedBox(
                            height: 15
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Invoice No: _________________________'),
                        )
                      ]
                  )
              )
          ),
        ]
    )
    );
  }

  submitForm()async{
    var pageFourDetailsInString = await prefs.getStringList('4');

    pageFourDetailsInString?.forEach((element) {
      var docDetails = FourthPageModel.fromJson(jsonDecode(element));
      docsList.add(docDetails);
      docsList.refresh();
    });
    await getDoc();
  }

  getDoc()async{
    try {
      docsList.forEach((element) async {
        final name = element.fieldName;
        final ref = FirebaseStorage.instance.ref().child('user_docs').child(userID.toString()).child(name!);
        final uploadTask = ref.putFile(io.File(element.file.toString()));
        final snapshot = await uploadTask.whenComplete(() {});
        final downloadURL = await snapshot.ref.getDownloadURL();
        downloadLinks.addAll({
          '${element.fieldName}': downloadURL
        });
        if(element == docsList.last){
          await uploadFeeSlip();
        }
      });
    } catch (e) {
      Get.back();
      showToast(e.toString());
    }
  }

  uploadFeeSlip()async{
    try {
      final ref = FirebaseStorage.instance.ref().child('user_docs').child(userID.toString()).child('Fee Slip');
      final uploadTask = ref.putFile(io.File('${imageFile.value?.path}'));
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadURL = await snapshot.ref.getDownloadURL();
      feeSlip = downloadURL;
      await uploadData();
    } catch (e) {
      Get.back();
      showToast(e.toString());
    }
  }

  uploadData()async{
    var pageOneDetailsInString = await prefs.getString('1');
    var pageTwoDetailsInString = await prefs.getString('2');
    var pageThreeDetailsInString = await prefs.getString('3');
    final pageOneDetails = FirstPageModel.fromJson(jsonDecode(pageOneDetailsInString!));
    final pageTwoDetails = SecondPageModel.fromJson(jsonDecode(pageTwoDetailsInString!));
    final pageThreeDetails = ThirdPageModel.fromJson(jsonDecode(pageThreeDetailsInString!));
    final name = pageOneDetails.studentName;
    await FirebaseFirestore.instance.collection('user_data').doc(userID.toString()).update({
      'student_name': name,
      'firstPageDetails': pageOneDetails.toJson(),
      'secondPageDetails': pageTwoDetails.toJson(),
      'thirdPageDetails': pageThreeDetails.toJson(),
      'fourthPageDetails': downloadLinks,
      'fee_slip': feeSlip,
      'application_status': true,
      'form_details_checked': false,
      'form_details_accepted': false,
      'fee_slip_checked': false,
      'fee_slip_accepted': false,
      'documents_accepted': false,
    });
    // await FirebaseFirestore.instance.collection('notifications').doc().set({
    //   'fromUni': false,
    //   'message': 'Your application has been submitted',
    // });
    await FirebaseFirestore.instance.collection('receipts').doc(userID.value).set({
      'fee_slip': feeSlip
    });
    await prefs.setBool('formSubmitted', true);
    await io.File('storage/emulated/0/Documents/barcode.png').delete();
    int count = 0;
    BaseLayoutViewModel baseLayoutViewModel = Get.find();
    baseLayoutViewModel.changePage(0);
    Get.until((route) => count++ >= 5);

  }
}