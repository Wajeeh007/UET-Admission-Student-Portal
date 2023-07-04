import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online_admission/screens/admission_form/screen_three/screen_three_viewmodel.dart';
import 'package:online_admission/screens/admission_form/screen_two/screen_two_viewmodel.dart';
import 'package:online_admission/widgets/admission_form_textformfield_before_text.dart';
import 'package:online_admission/widgets/admission_form_textformfields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import '../screen_three/screen_three_view.dart';
import 'screen_two_model.dart';

class ScreenTwoView extends StatelessWidget {
  ScreenTwoView({super.key});

  final ScreenTwoViewModel viewModel = Get.find();

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
                                padding: const EdgeInsets.only(
                                    top: 20.0, bottom: 13),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '2/5',
                                    style: TextStyle(
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
                                        AdmissionFormFields(
                                          fieldValidationFunc: (value){
                                            if(value == null || value == ''){
                                              return 'Enter Present Address';
                                            }
                                            else{
                                              return null;
                                            }
                                          },
                                          fieldController: viewModel.presentAddress,
                                          fieldName: 'Present Address:',
                                          takeWholeWidth: true,
                                        ),
                                        AdmissionFormFields(
                                          fieldName: 'Permanent Address:',
                                          fieldController: viewModel.permanentAddress,
                                          fieldValidationFunc: (value){
                                            if(value == null || value == ''){
                                              return 'Enter Permanent Address';
                                            }
                                            else{
                                              return null;
                                            }
                                          },
                                          takeWholeWidth: true,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Income of',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14
                                              ),
                                            ),
                                            addIncomeRadioButton(0, viewModel.incomeSelection[0]),
                                            addIncomeRadioButton(1, viewModel.incomeSelection[1])
                                          ],
                                        ),
                                        Obx(() => viewModel.incomeSelectionCheck.value ? const Padding(
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
                                        AdmissionFormTextFieldBeforeText(
                                          fieldController: viewModel.incomeInLetters,
                                          fieldText: '*Write income in letters',
                                          textStyle: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500
                                          ),
                                          receivedWidth: double.infinity,
                                          arrangeInColumn: true,
                                          inputFilter: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]+|\s')),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 28,
                                        ),
                                        Column(
                                          children: [
                                            const Text(
                                              'Quota/Seat against which admitted',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                addSeatRadioButton(0, viewModel.seatType[0]),
                                                addSeatRadioButton(1, viewModel.seatType[1]),
                                              ]
                                            ),
                                            Obx(() => viewModel.seatTypeSelectionCheck.value ? const Padding(
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
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text(
                                          'Name and Address of employer (if employed)',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        AdmissionFormFields(
                                          fieldController: viewModel.nameOfEmployer,
                                          fieldName: 'Name:',
                                          takeWholeWidth: true,
                                          inputFilter: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]+|\s')),
                                          ],
                                        ),
                                        AdmissionFormFields(
                                          fieldController: viewModel.addressOfEmployer,
                                          fieldName: 'Address:',
                                          takeWholeWidth: true,
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Academic Record',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Text(
                                              '(Must fill all fields)',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Metric or Equivalent Examination',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            AdmissionFormFields(
                                              fieldController: viewModel.year,
                                              fieldName: 'Year',
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
                                            //  receivedWidth: MediaQuery.of(context).size.width/3.3,
                                            ),
                                            AdmissionFormFields(
                                              fieldController: viewModel.rollNumber,
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
                                              //receivedWidth: MediaQuery.of(context).size.width/3.3,
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
                                          fieldController: viewModel.nameOfBoard,
                                        ),
                                        const SizedBox(
                                          height: 17,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            addPaperRadioButton(0, viewModel.paperSelection[0]),
                                            addPaperRadioButton(1, viewModel.paperSelection[1])
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
                                              fieldName: 'Marks Obtained',
                                              fieldValidationFunc: (value){
                                                if(value == null || value == ''){
                                                  return 'Enter Marks';
                                                }
                                                else if(viewModel.totalMarks.text == ''){
                                                  return null;
                                                }
                                                else if(int.parse(viewModel.totalMarks.text) < int.parse(viewModel.obtainedMarks.text)){
                                                  return 'Invalid Value';
                                                }
                                                else {
                                                  return null;
                                                }
                                              },
                                              fieldController: viewModel.obtainedMarks,
                                              inputFilter: [
                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                FilteringTextInputFormatter.digitsOnly,
                                              ],
                                              keyboardType: TextInputType.number,
                                              receivedWidth: MediaQuery.of(context).size.width/5.5,
                                            ),
                                            AdmissionFormFields(
                                              fieldName: 'Total Marks',
                                              fieldValidationFunc: (value){
                                                if(value == null || value == ''){
                                                  return 'Enter Marks';
                                                }
                                                else {
                                                  return null;
                                                }
                                              },
                                              receivedWidth: MediaQuery.of(context).size.width/5.5,
                                              fieldController: viewModel.totalMarks,
                                              inputFilter: [
                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                FilteringTextInputFormatter.digitsOnly,
                                              ],
                                              keyboardType: TextInputType.number,
                                            ),
                                          ],
                                        ),
                                        AdmissionFormFields(
                                          fieldName: 'Percentage',
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
                                          fieldController: viewModel.percentage,
                                          inputFilter: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                            FilteringTextInputFormatter.digitsOnly,
                                          ],
                                          keyboardType: TextInputType.number,
                                        )
                                      ],
                                    )
                                ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0, top: 25),
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
                                    const SizedBox(
                                      width: 18,
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
                                              if (viewModel.incomeSelect.value == '') {
                                                viewModel.loader.value = false;
                                                viewModel.incomeSelectionCheck.value = true;
                                              }
                                              else if (viewModel.seatTypeSelected.value == '') {
                                                viewModel.loader.value = false;
                                                viewModel.seatTypeSelectionCheck.value = true;
                                              }
                                              else if(viewModel.paperSelect.value == ''){
                                                viewModel.loader.value = false;
                                                viewModel.paperSelectionCheck.value = true;
                                              }
                                              else {
                                                SecondPageModel details = SecondPageModel(
                                                    presentAddress: viewModel.presentAddress.text,
                                                  permanentAddress: viewModel.permanentAddress.text,
                                                  incomeSource: viewModel.incomeSelect.value,
                                                  incomeInLetters: viewModel.incomeInLetters.text,
                                                  seatType: viewModel.seatTypeSelected.value,
                                                  employerName: viewModel.nameOfEmployer.text,
                                                  employerAddress: viewModel.addressOfEmployer.text,
                                                  year: viewModel.year.text,
                                                  rollNumber: viewModel.rollNumber.text,
                                                  boardName: viewModel.nameOfBoard.text,
                                                  obtainedMarks: viewModel.obtainedMarks.text,
                                                  totalMarks: viewModel.totalMarks.text,
                                                  paperType: viewModel.paperSelect.value,
                                                  percentage: viewModel.percentage.text
                                                );
                                                var jsonConverted = jsonEncode(details);
                                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                                await prefs.setString('2', jsonConverted);
                                                viewModel.loader.value = false;
                                                Get.put(ScreenThreeViewModel());
                                                Get.to(()=> ScreenThreeView());
                                              }
                                            }else{
                                              viewModel.loader.value = false;
                                            }
                                          }
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]
                        ),
                      )
                  )
              )
          ),
        );
  }

  addIncomeRadioButton(int btnValue, String title) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Radio(
              fillColor: MaterialStateColor.resolveWith((states) => primaryColor),
              activeColor: Theme.of(Get.context!).primaryColor,
              value: viewModel.incomeSelection[btnValue],
              groupValue: viewModel.incomeSelect.value,
              onChanged: (value){
                  viewModel.incomeSelect.value = value;
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

  addSeatRadioButton(int btnValue, String title) {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          fillColor: MaterialStateColor.resolveWith((states) => primaryColor),
          activeColor: Theme.of(Get.context!).primaryColor,
          value: viewModel.seatType[btnValue],
          groupValue: viewModel.seatTypeSelected.value,
          onChanged: (value){
            viewModel.seatTypeSelected.value = value;
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

  addPaperRadioButton(int btnValue, String title) {
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
              fontSize: 14,
              fontWeight: FontWeight.w600
          ),
        )
      ],
    ),
    );
  }
}