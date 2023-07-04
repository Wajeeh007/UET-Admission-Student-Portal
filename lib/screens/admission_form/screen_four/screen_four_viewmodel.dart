import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:online_admission/screens/admission_form/screen_four/screen_four_model.dart';
import 'dart:io';
import 'package:pdfx/pdfx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenFourViewModel extends GetxController{

  RxList<FourthPageModel> fieldList = <FourthPageModel>[
    FourthPageModel(fieldName: 'CNIC or Form-B'),
    FourthPageModel(fieldName: 'Domicile'),
    FourthPageModel(fieldName: 'Father or Mother CNIC'),
    FourthPageModel(fieldName: 'Passport Size Picture'),
    FourthPageModel(fieldName: 'SSC DMC'),
    FourthPageModel(fieldName: 'SSC Provisional Certificate'),
    FourthPageModel(fieldName: 'HSSC DMC'),
    FourthPageModel(fieldName: 'HSSC Provisional Certificate'),
    FourthPageModel(fieldName: 'College to University Certificate')
  ].obs;

  RxBool proceed = true.obs;
  RxBool loader = false.obs;

  @override
  void onInit() async{
    await getData();
    super.onInit();
  }

  getData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var docsList = await prefs.getStringList('4');
    if(docsList == null){
      return;
    } else{
      int index = 0;
      int i = 0;
      docsList.forEach((element) {
        var elmnt = FourthPageModel.fromJson(jsonDecode(element));
        fieldList[i] = elmnt;
        i++;
      });
      fieldList.forEach((element) {
        element.showLoader = true;
        if(element.file == null || element.file == ''){
          element.showLoader = false;
          return;
        } else {
          _renderImage(index);
          index++;
        }
      });
    }
  }

  pickFile(int index)async{
    final pickedFile = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['csv']);
    if(pickedFile != null){
      final file = File(pickedFile.files.single.path.toString());
      fieldList[index].file = file.path;
      await _renderImage(index);
    }
  }

  _renderImage(int index) async {
    final document = await PdfDocument.openFile(fieldList[index].file.toString());
    final page = await document.getPage(1);
    final pageRender = await page.render(width: page.width, height: page.height);
    fieldList[index].pageImage = pageRender!.bytes;
    await page.close();
    fieldList[index].showError = false;
    proceed.value = true;
    fieldList[index].showLoader = false;
    fieldList.refresh();
  }
}