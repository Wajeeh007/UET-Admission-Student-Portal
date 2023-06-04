import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_admission/screens/admission_form/models/third_page_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../widgets/admission_form_textformfields.dart';
import 'admission_form_4.dart';

class AdmissionFormScreen3 extends StatefulWidget {
  static const admissionFormScreen3 = 'admissionformscreen3';

  @override
  State<AdmissionFormScreen3> createState() => _AdmissionFormScreen3State();
}

class _AdmissionFormScreen3State extends State<AdmissionFormScreen3> {

  TextEditingController yearController = TextEditingController();
  TextEditingController rollNumberController = TextEditingController();
  TextEditingController boardNameController = TextEditingController();
  TextEditingController marksObtainedController = TextEditingController();
  TextEditingController totalMarksController = TextEditingController();
  TextEditingController percentageController = TextEditingController();

  List paperSelection=['Annual', 'Supplementary'];
  String? paperSelect;

  final formKey = GlobalKey<FormState>();

  bool paperSelectionCheck = false;

  Row addRadioButton(int btnValue, String title, int givenValue, String? selectedValue, List<dynamic> list) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          fillColor: MaterialStateColor.resolveWith((states) => primaryColor),
          activeColor: Theme.of(context).primaryColor,
          value: list[givenValue],
          groupValue: null,
          onChanged: (value){
            setState(() {
              selectedValue=value;
            });
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
    );
  }

  getData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var thirdPageDetailsInString = await prefs.getString('thirdPageDetails');
    if(thirdPageDetailsInString == null){
      return;
    }
    else{
      var details = ThirdPageDetails.fromJson(jsonDecode(thirdPageDetailsInString));
      yearController.text = details.year.toString();
      rollNumberController.text = details.rollNo.toString();
      boardNameController.text = details.boardName.toString();
      paperSelect = details.paperType;
      marksObtainedController.text = details.obtainedMarks.toString();
      totalMarksController.text = details.totalMarks.toString();
      percentageController.text = details.percentage.toString();
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

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
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            AdmissionFormFields(
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
                                          fieldController: boardNameController,
                                        ),
                                        const SizedBox(
                                          height: 17,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            addRadioButton(0, paperSelection[0], 0, paperSelect, paperSelection),
                                            addRadioButton(1, paperSelection[1], 1, paperSelect, paperSelection)
                                          ],
                                        ),
                                        paperSelectionCheck ? const Padding(
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            AdmissionFormFields(
                                              fieldName: 'Marks Obtained:',
                                              fieldValidationFunc: (value){
                                                if(value == null || value == ''){
                                                  return 'Enter Marks';
                                                }
                                                else if(totalMarksController.text == ''){
                                                  return null;
                                                }
                                                else if(int.parse(totalMarksController.text) < int.parse(marksObtainedController.text)){
                                                  return 'Invalid Value';
                                                }
                                                else {
                                                  return null;
                                                }
                                              },
                                              fieldController: marksObtainedController,
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
                                              fieldController: totalMarksController,
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
                                          fieldController: percentageController,
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
                  child: Container(
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
                                Navigator.pop(context);
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
                                  if(paperSelect == null){
                                    setState(() {
                                      paperSelectionCheck = true;
                                    });
                                  }
                                  if (formKey.currentState!.validate()) {
                                      ThirdPageDetails details = ThirdPageDetails(
                                          year: int.parse(yearController.text),
                                          rollNo: int.parse(rollNumberController.text),
                                          boardName: boardNameController.text,
                                          obtainedMarks: int.parse(marksObtainedController.text),
                                          totalMarks: int.parse(totalMarksController.text),
                                          percentage: int.parse(percentageController.text)
                                      );
                                      var jsonConverted = jsonEncode(details);
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      await prefs.setString('thirdPageDetails', jsonConverted);
                                      Navigator.pushNamed(context, AdmissionFormScreen4.admissionFormScreen4);
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
}