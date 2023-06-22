import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_admission/screens/admission_form/screen_one/screen_one_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenFiveViewModel extends GetxController{

  final pdf = Document().obs;
  RxBool loader = false.obs;
  RxBool fileUploadedCheck = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  Future<Uint8List> createPDF()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = await prefs.getString('1');
    var jsonData = jsonDecode(data!);
    var pdf = Document();
    FirstPageModel details = FirstPageModel.fromJson(jsonData);
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
    var externalPath = await getExternalStorageDirectory();
    try {
      int? i = await prefs.getInt('i');
      if(i == null){
        i = 0;
      }
      File file = File('${externalPath?.path}/feeSlip$i.pdf');
      await file.writeAsBytes(await pdf.save());
      i++;
      await prefs.setInt('i', i);
    } catch (e){
      int? i = await prefs.getInt('i');
      if(i == null){
        i = 0;
      }
      if(e=='file already exists'){
        File file = File('${externalPath?.path}/feeSlip$i');
        await file.writeAsBytes(await pdf.save());
        i += 1;
        await prefs.setInt('i', i);
      }
    }
     return pdf.save();
  }

  final ImagePicker _picker = ImagePicker();
  Rx<File?> imageFile = File('').obs;

  pickFile(ImageSource src)async{
    final pickedFile = await _picker.pickImage(source: src);
    if(pickedFile != null){
      imageFile.value = File(pickedFile.path);
      fileUploadedCheck.value = false;
      Get.back();
    }
  }

  Padding feeSlipSection(String copyName, FirstPageModel details){
    final currentDateTime = DateTime.now();
    final currentYear = currentDateTime.year;
    return Padding(
    padding: const EdgeInsets.symmetric(vertical: 25),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text('UNIV. OF ENGG & TECH., PESHAWAR')),
          SizedBox(
              height: 10
          ),
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
              height: 20
          ),
          Container(
              width: 240,
              height: 200,
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
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child:Text(
                            'Name: ${details.studentName}',
                          ),),
                        SizedBox(
                            height: 10
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child:Text(
                              'S/D/o: ${details.fatherName}',
                            )),
                        SizedBox(
                            height: 10
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
                            height: 20
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
}