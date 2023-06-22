import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online_admission/screens/admission_form/screen_three/screen_three_model.dart';
import 'package:online_admission/screens/admission_form/screen_three/screen_three_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import '../../../widgets/admission_form_textformfields.dart';
import '../screen_four/screen_four_view.dart';
import '../screen_four/screen_four_viewmodel.dart';

class ScreenThreeView extends StatelessWidget {

  ScreenThreeView({super.key});

  final ScreenThreeViewModel viewModel = Get.find();
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  'Admission Form',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '3/5',
                    style: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                    ),
                  ),
                ),
              ),
              centerTitle: true,
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                        child: SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: Column(
                                children: [
                                  const Text(
                                    'Intermediate Or Equivalent Examination',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Form(
                                    key: viewModel.formKey,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            AdmissionFormFields(
                                              fieldController: viewModel.yearController,
                                              fieldName: 'Year:',
                                              fieldValidationFunc: (value){
                                                if(value == null || value == ''){
                                                  return 'Enter Year';
                                                }
                                                else if(value.length != 4){
                                                  return 'Invalid Year';
                                                }
                                                else{
                                                  return null;
                                                }
                                              },
                                              inputFilter: [
                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                FilteringTextInputFormatter.digitsOnly,
                                              ],
                                              keyboardType: TextInputType.number,
                                            ),
                                            AdmissionFormFields(
                                              fieldController: viewModel.rollNumberController,
                                              fieldName: 'Roll Number:',
                                              fieldValidationFunc: (value){
                                                if(value == null || value == ''){
                                                  return 'Enter Roll Number';
                                                }
                                                else{
                                                  return null;
                                                }
                                              },
                                              inputFilter: [
                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                FilteringTextInputFormatter.digitsOnly,
                                              ],
                                              keyboardType: TextInputType.number,
                                            ),
                                          ],
                                        ),
                                        AdmissionFormFields(
                                          fieldValidationFunc: (value){
                                            if(value == null || value == ''){
                                              return 'Enter Board Name';
                                            }
                                            else {
                                              return null;
                                            }
                                          },
                                          inputFilter: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]+|\s')),
                                          ],
                                          keyboardType: TextInputType.text,
                                          fieldName: 'Name of Board:',
                                          takeWholeWidth: true,
                                          fieldController: viewModel.boardNameController,
                                        ),
                                        const SizedBox(
                                          height: 17,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            addPaperSelectionRadioButton(0, viewModel.paperSelection[0]),
                                            addPaperSelectionRadioButton(1, viewModel.paperSelection[1])
                                          ],
                                        ),
                                        Obx(() => viewModel.paperSelectionCheck.value ? const Padding(
                                          padding: EdgeInsets.symmetric(vertical: 6.0),
                                          child: Text(
                                            'Select An Option',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ) : Container(),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            AdmissionFormFields(
                                              fieldName: 'Marks Obtained:',
                                              fieldValidationFunc: (value){
                                                if(value == null || value == ''){
                                                  return 'Enter Marks';
                                                }
                                                else if(viewModel.totalMarksController.text == ''){
                                                  return null;
                                                }
                                                else if(int.parse(viewModel.totalMarksController.text) < int.parse(viewModel.marksObtainedController.text)){
                                                  return 'Invalid Value';
                                                }
                                                else {
                                                  return null;
                                                }
                                              },
                                              fieldController: viewModel.marksObtainedController,
                                              inputFilter: [
                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                FilteringTextInputFormatter.digitsOnly,
                                              ],
                                              receivedWidth: MediaQuery.of(context).size.width/5.5,
                                              keyboardType: TextInputType.number,
                                            ),
                                            AdmissionFormFields(
                                              fieldName: 'Total Marks:',
                                              fieldValidationFunc: (value){
                                                if(value == null || value == ''){
                                                  return 'Enter Marks';
                                                }
                                                else {
                                                  return null;
                                                }
                                              },
                                              fieldController: viewModel.totalMarksController,
                                              inputFilter: [
                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                FilteringTextInputFormatter.digitsOnly,
                                              ],
                                              receivedWidth: MediaQuery.of(context).size.width/5.5,
                                              keyboardType: TextInputType.number,
                                            ),
                                          ],
                                        ),
                                        AdmissionFormFields(
                                          keyboardType: TextInputType.number,
                                          fieldName: 'Percentage:',
                                          fieldValidationFunc: (value){
                                            if(value == null || value == ''){
                                              return 'Enter Percentage';
                                            }
                                            else if(int.parse(value) > 100){
                                              return 'Invalid Value';
                                            }
                                            else{
                                              return null;
                                            }
                                          },
                                          fieldController: viewModel.percentageController,
                                          inputFilter: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                            FilteringTextInputFormatter.digitsOnly,
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ]
                            )
                        )
                    )
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 65,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.0, left: 15, right: 15),
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
                                Get.back();
                              },
                              child: const Text(
                                'Go Back',
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
                                  if(viewModel.paperSelect.value == ''){
                                    viewModel.loader.value = false;
                                    viewModel.paperSelectionCheck.value = true;
                                  }
                                  if (viewModel.formKey.currentState!.validate()) {
                                      ThirdPageModel details = ThirdPageModel(
                                          year: viewModel.yearController.text,
                                          rollNo: viewModel.rollNumberController.text,
                                          boardName: viewModel.boardNameController.text,
                                          obtainedMarks: viewModel.marksObtainedController.text,
                                          totalMarks: viewModel.totalMarksController.text,
                                          percentage: viewModel.percentageController.text,
                                        paperType: viewModel.paperSelect.value
                                      );
                                      var jsonConverted = jsonEncode(details);
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      await prefs.setString('3', jsonConverted);
                                      viewModel.loader.value = false;
                                      Get.put(ScreenFourViewModel());
                                        Get.to(() => ScreenFourView());
                                  } else{
                                    viewModel.loader.value = false;
                                  }
                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
        )
    );
  }

  addPaperSelectionRadioButton(int btnValue, String title) {
    return Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
            fillColor: MaterialStateColor.resolveWith((states) => primaryColor),
            activeColor: Theme.of(Get.context!).primaryColor,
            value: viewModel.paperSelection[btnValue],
            groupValue: viewModel.paperSelect.value,
            onChanged: (value){
              viewModel.paperSelect.value = value;
            },
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600
            ),
          )
        ],
      ),
    );
  }
}