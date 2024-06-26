import 'dart:convert';
import 'package:barcode_image/barcode_image.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as im;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io' as io;
import 'package:online_admission/constants.dart';
import 'package:online_admission/screens/admission_form/screen_one/screen_one_model.dart';
import 'package:online_admission/screens/admission_form/screen_one/screen_one_viewmodel.dart';
import 'package:online_admission/screens/admission_form/screen_two/screen_two_view.dart';
import 'package:online_admission/screens/admission_form/screen_two/screen_two_viewmodel.dart';
import 'package:online_admission/screens/homepage/homepage_viewmodel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widgets/admission_form_date_picker.dart';
import '../../../widgets/admission_form_textformfields.dart';
import '../../base/base_layout_viewmodel.dart';

class ScreenOneView extends StatelessWidget {

  final ScreenOneViewModel viewModel = Get.put(ScreenOneViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              'Admission Form',
              style: TextStyle(
                  color: Color(0xff435060),
                  fontSize: 23,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 13),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '1/5',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w600,
                          fontSize: 15
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: viewModel.formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AdmissionFormFields(
                              fieldController: viewModel.eteaIDController,
                              inputFilter: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              fieldName: 'ETEA ID:',
                              keyboardType: TextInputType.number,
                              fieldValidationFunc: (value){
                                if(value == null || value == ''){
                                  return 'Enter ETEA ID';
                                }
                                else if(value.length != 6){
                                  return 'Invalid ID';
                                }
                                else{
                                  return null;
                                }
                              },
                              takeWholeWidth: false,
                            ),
                            AdmissionFormFields(
                                fieldController: viewModel.meritNumberController,
                              inputFilter: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              fieldName: 'Merit No:',
                                fieldValidationFunc: (value){
                                  if(value == null || value == ''){
                                    return 'Invalid Number';
                                  }
                                  else if(value.length < 3){
                                    return 'Enter Complete Number';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                              takeWholeWidth: false,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text('Application form for enrollment to first semester',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                                color: Color(0xff435060),
                                fontWeight: FontWeight.w700,
                                fontSize: 15
                            ),),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'B.Sc',
                              style: TextStyle(
                                color: Color(0xff435060),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width/1.85,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(() => DropdownButtonFormField(
                                      isExpanded: false,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 31, top: 12),
                                        hintStyle: TextStyle(
                                          overflow: TextOverflow.fade,
                                          color: Colors.grey,
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 1
                                            )
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 1
                                            )
                                        ),
                                      ),
                                      items: viewModel.departmentList,
                                      onChanged: (value)async{
                                        if(viewModel.eteaIDController.text.length != 6){
                                          showToast('Enter valid etea id to choose department');
                                        } else {
                                          if(Get.arguments != null){
                                            viewModel.campusFieldVisibility.value = false;
                                            viewModel.departmentName.value = value;
                                            viewModel.departmentNameCheck.value = false;
                                            viewModel.changeList(value);
                                          } else{
                                            viewModel.departmentName.value = value;
                                            viewModel.departmentNameCheck.value = false;
                                            await viewModel.checkEligibility(value);
                                          }
                                        }
                                          },
                                      value: viewModel.departmentName.value,
                                    ),
                                  ),
                                  Obx(() => viewModel.departmentNameCheck.value == true ? const Padding(
                                    padding: EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      'Choose Department',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14
                                      ),
                                    ),
                                  ) : Container(),
                                  )
                                    ],
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            const Text(
                              'Engineering',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Obx(() => Visibility(
                          visible: viewModel.campusFieldVisibility.value,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/2.8,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      DropdownButtonFormField(
                                          isExpanded: false,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.only(left: 14, top: 10),
                                            hintStyle: TextStyle(
                                              overflow: TextOverflow.fade,
                                              color: Colors.grey,
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1
                                                )
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1
                                                )
                                            ),
                                          ),
                                          items: viewModel.campusList,
                                          onChanged: (value)async{
                                                viewModel.campus.value = value.toString();
                                                viewModel.campusNameCheck.value = false;
                                          },
                                          value: viewModel.campus.value,
                                        ),
                                      Obx(() => viewModel.campusNameCheck.value == true ? const Padding(
                                        padding: EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          'Choose Campus',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ) : Container()
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'Campus',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AdmissionFormFields(
                              fieldController: viewModel.nameController,
                              fieldName: 'Name:',
                              inputFilter: [
                                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]+|\s')),
                              ],
                              fieldValidationFunc: (value){
                              if(value == null || value == ''){
                                return 'Enter Your Name';
                              }
                              else if(value.length < 3){
                                return 'Enter complete name';
                              }
                              else{
                                return null;
                              }
                            },
                              receivedWidth: MediaQuery.of(context).size.width/3.3,
                            ),
                            AdmissionFormFields(
                              fieldController: viewModel.religionController,
                              inputFilter: [
                                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]+|\s')),
                              ],
                              fieldName: 'Religion:',
                              fieldValidationFunc: (value){
                                if(value == null || value == ''){
                                  return 'Enter Religion';
                                }
                                return null;
                              },
                              receivedWidth: MediaQuery.of(context).size.width/4.3,
                            ),
                          ],
                        ),
                        AdmissionFormFields(
                          fieldController: viewModel.fatherNameController,
                          fieldName: 'Father\'s Name:',
                          inputFilter: [
                            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]+|\s')),
                          ],
                          fieldValidationFunc: (value){
                            if(value == null || value == ''){
                              return 'Enter Father\'s Name';
                            }
                            else if(value.length < 3){
                              return 'Enter Complete Name';
                            }
                            else{
                              return null;
                            }
                          },
                          takeWholeWidth: true,
                        ),
                        AdmissionFormFields(
                          fieldController: viewModel.fatherOccupationController,
                          fieldName: 'Father\'s Occupation:',
                          inputFilter: [
                            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z-]+|\s')),
                          ],
                          fieldValidationFunc: (value){
                            if(value == null || value == ''){
                              return 'Enter Occupation';
                            }
                            return null;
                          },
                          takeWholeWidth: true,
                        ),
                        DateOfBirthForm(
                          fieldName: 'Date of Birth:',
                          fieldController: viewModel.dateController,
                          receivedWidth: MediaQuery.of(context).size.width/3.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AdmissionFormFields(
                              fieldController: viewModel.mobileNumberController,
                              fieldValidationFunc: (value){
                                if(value == null || value == ''){
                                  return 'Enter Mobile Number';
                                }
                                else if(value.length != 11){
                                  return 'Invalid Number';
                                }
                                else {
                                  return null;
                                }
                              },
                              fieldName: 'Mobile No:',
                              inputFilter: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              receivedWidth: MediaQuery.of(context).size.width/4,
                              keyboardType: TextInputType.number,
                            ),
                            AdmissionFormFields(
                              fieldName: 'CNIC:',
                              fieldController: viewModel.cnicController,
                              fieldValidationFunc: (value){
                                if(value == '' || value == null){
                                  return 'Enter CNIC';
                                }
                                else if(value.length != 13){
                                  return 'Invalid CNIC';
                                }
                                else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              receivedWidth: MediaQuery.of(context).size.width/4,
                              inputFilter: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            )
                          ],
                        ),
                        AdmissionFormFields(
                          fieldName: 'Nationality',
                          fieldController: viewModel.nationalityController,
                          fieldValidationFunc: (value){
                            if(value == null || value == ''){
                              return 'Enter Nationality';
                            }
                            else{
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: <Widget>[
                            const Text(
                              'Status:',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14
                              ),
                            ),
                          const SizedBox(
                            width: 12,
                          ),
                            addRadioButton(0, viewModel.maritalStatus[0]),
                            addRadioButton(1, viewModel.maritalStatus[1])
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0, top: MediaQuery.of(context).size.height/15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/2.6,
                          height: 46,
                          decoration: BoxDecoration(
                            color: const Color(0x99d0874c),
                            borderRadius: const BorderRadius.all(Radius.circular(29)),
                            border: Border.all(
                              width: 0,
                              color: const Color(0x99d0874c),
                            )
                          ),
                          child: MaterialButton(
                              onPressed: (){
                                BaseLayoutViewModel baseLayoutViewModel = Get.find();
                                baseLayoutViewModel.changePage(0);
                              },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/2.6,
                          height: 46,
                          decoration: BoxDecoration(
                              color: const Color(0xffd0874c),
                              borderRadius: const BorderRadius.all(Radius.circular(29)),
                              border: Border.all(
                                width: 0,
                                color: const Color(0xffd0874c),
                              )
                          ),
                          child: MaterialButton(
                              child: const Text(
                                'Proceed',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: ()async {
                                viewModel.loader.value = true;
                                if (viewModel.formKey.currentState!.validate()) {
                                  if (viewModel.departmentName.value == 'Choose Department') {
                                    viewModel.departmentNameCheck.value = true;
                                    viewModel.loader.value = false;
                                  }
                                  else if (viewModel.campus.value == 'Choose Campus') {
                                    viewModel.campusNameCheck.value = true;
                                    viewModel.loader.value = false;
                                  }
                                  else {
                                    FirstPageModel details = FirstPageModel(
                                        eteaID: viewModel.eteaIDController.text,
                                        meritListNo: viewModel.meritNumberController.text,
                                        studentName: viewModel.nameController.text,
                                        fatherOccupation: viewModel.fatherOccupationController.text,
                                        fatherName: viewModel.fatherNameController.text,
                                        departmentName: viewModel.departmentName.value,
                                        campusName: viewModel.campus.value,
                                        nationality: viewModel.nationalityController.text,
                                        religion: viewModel.religionController.text,
                                        mobileNo: viewModel.mobileNumberController.text,
                                        cnic: viewModel.cnicController.text,
                                        maritalStatus: viewModel.maritalStatusSelect.value,
                                      dateOfBirth: viewModel.dateController.text,
                                    );
                                    var jsonConverted = jsonEncode(details);
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    await prefs.setString('1', jsonConverted);
                                    viewModel.loader.value = false;
                                    im.fill(viewModel.barcodeImage, color: im.ColorRgb8(255, 255, 255));
                                    drawBarcode(viewModel.barcodeImage, Barcode.code128(), viewModel.eteaIDController.text, font: im.arial14);
                                    int? f = prefs.getInt('f');
                                    f ??= 0;
                                    await createFile(f);
                                    }
                                    //   print(barcode.path);
                                    //   await prefs.setString('barcode', barcode.path);
                                    //   await prefs.setInt('f', f);
                                    // print(await prefs.getString('barcode'));
                                    // Get.put(ScreenTwoViewModel());
                                    // Get.to(()=>ScreenTwoView());
                                }else{
                                  viewModel.loader.value = false;
                                }
                              }
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  createFile(int index)async {
    final permissionStatus = await Permission.storage.status;
    if (permissionStatus.isDenied) {
      await Permission.storage.request();
      if (permissionStatus.isDenied) {
        openAppSettings();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      openAppSettings();
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var barcode ;
      // = await DownloadsPathProvider.downloadsDirectory;
      if (barcode != null) {
        try {
          String path = barcode.path;
          path = '$path/barcode$index.png';
          await io.File(path).writeAsBytes(
              im.encodePng(viewModel.barcodeImage));
          await prefs.setString('barcode', path);
          index++;
          await prefs.setInt('f', index);
          await prefs.remove('userName');
          await prefs.setString('userName', viewModel.nameController.text);
          HomePageViewModel homePageViewModel = Get.find();
          homePageViewModel.userName.value = viewModel.nameController.text;
          Get.put(ScreenTwoViewModel());
          Get.to(() => ScreenTwoView());
        } catch (e) {
          print(e);
          createFile(index + 1);
        }
      }
    }
  }

  addRadioButton(int btnValue, String title) {
    return Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
            fillColor: MaterialStateColor.resolveWith((states) => primaryColor),
            activeColor: Theme.of(Get.context!).primaryColor,
            value: viewModel.maritalStatus[btnValue],
            groupValue: viewModel.maritalStatusSelect.value,
            onChanged: (value){
              viewModel.maritalStatusSelect.value=value;
            },
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600
            ),
          )
        ],
      ),
    );
  }
}