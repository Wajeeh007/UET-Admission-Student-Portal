import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_admission/constants.dart';
import 'package:online_admission/screens/admission_form/models/first_page_details.dart';
import 'package:online_admission/screens/homepage/base_layout.dart';
import 'package:online_admission/widgets/admission_form_textformfields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/admission_form_date_picker.dart';
import 'admission_form_2.dart';

class AdmissionFormScreen1 extends StatefulWidget {

  static const admissionFormScreen1 = 'admissionformscreen1';

  @override
  State<AdmissionFormScreen1> createState() => _AdmissionFormScreen1State();
}

class _AdmissionFormScreen1State extends State<AdmissionFormScreen1> {

  TextEditingController meritNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController fatherOccupationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController eteaIDController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List maritalStatus=['Single', 'Married'];

  String maritalStatusSelect = 'Single';

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          fillColor: MaterialStateColor.resolveWith((states) => primaryColor),
          activeColor: Theme.of(context).primaryColor,
          value: maritalStatus[btnValue],
          groupValue: 'Single',
          onChanged: (value){
            setState(() {
              maritalStatusSelect=value;
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
  late DateTime year;

  getData()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var firstPageDetailsInString = await prefs.getString('firstPageDetails');
    if (firstPageDetailsInString == null) {
      return;
    }
    else {
      final details = FirstPageDetails.fromJson(jsonDecode(firstPageDetailsInString));
      setState(() {
        eteaIDController.text = details.eteaID.toString();
        meritNumberController.text = details.meritListNo.toString();
        departmentName = details.departmentName;
        campus = details.campusName;
        fatherNameController.text = details.fatherName.toString();
        fatherOccupationController.text = details.fatherOccupation.toString();
        dateController.text = details.dateOfBirth.toString();
        religionController.text = details.religion.toString();
        mobileNumberController.text = details.mobileNo.toString();
        cnicController.text = details.cnic.toString();
        nationalityController.text = details.nationality.toString();
        maritalStatusSelect = details.maritalStatus.toString();
        nameController.text = details.studentName.toString();
      });
    }
  }

  @override
  void initState() {
    getData();
    DateTime currentDate = DateTime.now();
    year = DateTime(currentDate.year);
    super.initState();
  }

  String? departmentName;
  String? campus;
  bool departmentNameCheck = false;
  bool campusNameCheck = false;

  List<DropdownMenuItem> departmentList = [
    const DropdownMenuItem(child: Text('Mechanical', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),), value: 'Mechanical',),
    const DropdownMenuItem(child: Text('Electrical', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),), value: 'Electrical',),
    const DropdownMenuItem(child: Text('Civil', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), value: 'Civil',),
    const DropdownMenuItem(child: Text('Industrial', textAlign: TextAlign.end, style: TextStyle(color: Colors.black)), value: 'Industrial',),
    const DropdownMenuItem(child: Text('Mechatronics', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), value: 'Mechatronics',),
    const DropdownMenuItem(child: Text('Agriculture', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), value: 'Agriculture',),
    const DropdownMenuItem(child: Text('Mining', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), value: 'Mining',),
    const DropdownMenuItem(child: Text('Chemical', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), value: 'Chemical',),
    const DropdownMenuItem(child: Text('Computer Sciences', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), value: 'Computer Sciences',),
    const DropdownMenuItem(child: Text('System Engieering', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)), value:'System Engineering',),
  ];

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
                    padding: const EdgeInsets.only(top: 20.0, bottom: 13),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '1/5',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w600,
                          fontSize: 15
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AdmissionFormFields(
                              fieldController: eteaIDController,
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
                                fieldController: meritNumberController,
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
                                color: Colors.grey.shade400,
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
                                color: Colors.black,
                                fontSize: 14,
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
                                  DropdownButtonFormField(
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
                                    items: departmentList,
                                    onChanged: (value){
                                      setState(() {
                                        departmentName = value;
                                        campus = null;
                                        departmentNameCheck = false;
                                      });
                                    },
                                    value: departmentName,
                                  ),
                                  departmentNameCheck == true ? const Padding(
                                    padding: EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      'Choose Department',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14
                                      ),
                                    ),
                                  ) : Container(),
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
                        departmentName != null ? Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width/3.3,
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
                                    items: departmentName == 'Mechanical'
                                        || departmentName == 'Computer Sciences' ||
                                      departmentName == 'Industrial' ? <String>['Peshawar', 'Jalozai'].map<DropdownMenuItem<String>>((String e) {
                                      return DropdownMenuItem<String>(
                                        alignment: Alignment.bottomRight,
                                        value: e,
                                        child: Text(
                                          e,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      );
                                    }).toList() : departmentName == 'Electrical' ? <String>['Peshawar', 'Jalozai', 'Kohat', 'Bannu'].map<DropdownMenuItem<String>>((String e) {
                                      return DropdownMenuItem<String>(
                                        alignment: Alignment.center,
                                        value: e,
                                        child: Text(
                                          e,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      );
                                    }).toList() : departmentName == 'Civil' ? <String>['Peshawar', 'Jalozai', 'Bannu'].map<DropdownMenuItem<String>>((String e) {
                                      return DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      );
                                    }).toList() : <String>['Peshawar'].map<DropdownMenuItem<String>>((String e) {
                                      return DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value){
                                      setState(() {
                                        campus = value;
                                        campusNameCheck = false;
                                      });
                                    },
                                    value: campus,
                                  ),
                                  campusNameCheck == true ? const Padding(
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
                        ) : Container(), 
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AdmissionFormFields(
                              fieldController: nameController,
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
                              fieldController: religionController,
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
                          fieldController: fatherNameController,
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
                          fieldController: fatherOccupationController,
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
                          fieldController: dateController,
                          receivedWidth: MediaQuery.of(context).size.width/3.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AdmissionFormFields(
                              fieldController: mobileNumberController,
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
                              fieldController: cnicController,
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
                          fieldController: nationalityController,
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
                            addRadioButton(0, maritalStatus[0]),
                            addRadioButton(1, maritalStatus[1])
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => BaseLayout()));
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
                                if (formKey.currentState!.validate()) {
                                  if (departmentName == null) {
                                    setState(() {
                                      departmentNameCheck = true;
                                    });
                                  }
                                  else if (campusNameCheck == true) {
                                    setState(() {
                                      campusNameCheck = true;
                                    });
                                  }
                                  else {
                                    FirstPageDetails details = FirstPageDetails(
                                        eteaID: int.parse(eteaIDController.text),
                                        meritListNo: int.parse(meritNumberController.text),
                                        studentName: nameController.text,
                                        fatherOccupation: fatherOccupationController.text,
                                        fatherName: fatherNameController.text,
                                        departmentName: departmentName,
                                        campusName: campus,
                                        nationality: nationalityController.text,
                                        religion: religionController.text,
                                        mobileNo: mobileNumberController.text,
                                        cnic: cnicController.text,
                                        maritalStatus: maritalStatusSelect,
                                      dateOfBirth: dateController.text,
                                    );
                                    var jsonConverted = jsonEncode(details);
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    await prefs.setString('firstPageDetails', jsonConverted);
                                    Navigator.pushNamed(context, AdmissionFormScreen2.admissionFormScreen2);
                                  }
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
}