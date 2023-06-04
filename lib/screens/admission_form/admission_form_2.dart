import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_admission/widgets/admission_form_textformfield_before_text.dart';
import 'package:online_admission/widgets/admission_form_textformfields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'admission_form_3.dart';
import 'models/second_page_details.dart';

class AdmissionFormScreen2 extends StatefulWidget {
  static const admissionFormScreen2 = 'admissionformscreen2';

  @override
  State<AdmissionFormScreen2> createState() => _AdmissionFormScreen2State();
}

class _AdmissionFormScreen2State extends State<AdmissionFormScreen2> {

  TextEditingController presentAddress = TextEditingController();
  TextEditingController permanentAddress = TextEditingController();
  TextEditingController incomeInLetters = TextEditingController();
  TextEditingController nameOfEmployer = TextEditingController();
  TextEditingController addressOfEmployer = TextEditingController();
  TextEditingController obtainedMarks = TextEditingController();
  TextEditingController totalMarks = TextEditingController();
  TextEditingController percentage = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController rollNumber = TextEditingController();
  TextEditingController nameOfBoard = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List incomeSelection=['Father', 'Guardian'];
  List seatType = ['Open', 'Close'];
  List paperSelection=['Annual', 'Supplementary'];

  String? seatTypeSelected;
  String? incomeSelect;
  String? paperSelect;
  bool seatTypeSelectionCheck = false;
  bool incomeSelectionCheck = false;
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
              fontSize: 14,
              fontWeight: FontWeight.w600
          ),
        )
      ],
    );
  }

  getData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var secondPageDetailsInString = await prefs.getString('secondPageDetails');
    if(secondPageDetailsInString == null){
      return;
    }
    else{
      final details = SecondPageDetails.fromJson(jsonDecode(secondPageDetailsInString));
      presentAddress.text = details.presentAddress.toString();
      permanentAddress.text = details.permanentAddress.toString();
      incomeInLetters.text = details.incomeInLetters.toString();
      incomeSelect = details.incomeSource;
      seatTypeSelected = details.seatType;
      nameOfEmployer.text = details.employerName.toString();
      addressOfEmployer.text = details.employerAddress.toString();
      year.text = details.year.toString();
      rollNumber.text = details.rollNumber.toString();
      nameOfBoard.text = details.boardName.toString();
      paperSelect = details.paperType;
      obtainedMarks.text = details.obtainedMarks.toString();
      totalMarks.text = details.totalMarks.toString();
      percentage.text = details.percentage.toString();
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
                                      fieldController: presentAddress,
                                      fieldName: 'Present Address:',
                                      takeWholeWidth: true,
                                    ),
                                    AdmissionFormFields(
                                      fieldName: 'Permanent Address:',
                                      fieldController: permanentAddress,
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
                                        addRadioButton(0, incomeSelection[0], 0, incomeSelect, incomeSelection),
                                        addRadioButton(1, incomeSelection[1], 1, incomeSelect, incomeSelection)
                                      ],
                                    ),
                                    incomeSelectionCheck ? const Padding(
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
                                    AdmissionFormTextFieldBeforeText(
                                      fieldController: incomeInLetters,
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
                                            addRadioButton(0, seatType[0], 0, seatTypeSelected, seatType),
                                            addRadioButton(1, seatType[1], 1, seatTypeSelected, seatType),
                                          ]
                                        ),
                                        seatTypeSelectionCheck ? const Padding(
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
                                      fieldController: nameOfEmployer,
                                      fieldName: 'Name:',
                                      takeWholeWidth: true,
                                      inputFilter: [
                                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]+|\s')),
                                      ],
                                    ),
                                    AdmissionFormFields(
                                      fieldController: addressOfEmployer,
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
                                      fieldController: nameOfBoard,
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
                                          fieldName: 'Marks Obtained',
                                          fieldValidationFunc: (value){
                                            if(value == null || value == ''){
                                              return 'Enter Marks';
                                            }
                                            else if(totalMarks.text == ''){
                                              return null;
                                            }
                                            else if(int.parse(totalMarks.text) < int.parse(obtainedMarks.text)){
                                              return 'Invalid Value';
                                            }
                                            else {
                                              return null;
                                            }
                                          },
                                          fieldController: obtainedMarks,
                                          inputFilter: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                            FilteringTextInputFormatter.digitsOnly,
                                          ],
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
                                          fieldController: totalMarks,
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
                                      fieldController: percentage,
                                      inputFilter: [
                                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    )
                                  ],
                                )
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0, top: 25),
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
                                          //Navigator.pushNamed(context, AdmissionFormScreen2.admissionFormScreen2);
                                          if (formKey.currentState!.validate()) {
                                            if (incomeSelect == null) {
                                              setState(() {
                                                incomeSelectionCheck = true;
                                              });
                                            }
                                            else if (seatTypeSelected == null) {
                                              setState(() {
                                                seatTypeSelectionCheck = true;
                                              });
                                            }
                                            else if(paperSelect == null){
                                              setState(() {
                                                paperSelectionCheck = true;
                                              });
                                            }
                                            else {
                                              SecondPageDetails details = SecondPageDetails(
                                                  presentAddress: presentAddress.text,
                                                permanentAddress: permanentAddress.text,
                                                incomeSource: incomeSelect,
                                                incomeInLetters: incomeInLetters.text,
                                                seatType: seatTypeSelected,
                                                employerName: nameOfEmployer.text,
                                                employerAddress: addressOfEmployer.text,
                                                year: int.parse(year.text),
                                                rollNumber: int.parse(rollNumber.text),
                                                boardName: nameOfBoard.text,
                                                obtainedMarks: int.parse(obtainedMarks.text),
                                                totalMarks: int.parse(totalMarks.text),
                                                paperType: paperSelect,
                                                percentage: int.parse(percentage.text)
                                              );
                                              var jsonConverted = jsonEncode(details);
                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                              await prefs.setString('secondPageDetails', jsonConverted);
                                              Navigator.pushNamed(context, AdmissionFormScreen3.admissionFormScreen3);
                                            }
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
        )
    );
  }
}