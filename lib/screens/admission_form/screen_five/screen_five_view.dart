
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:online_admission/constants.dart';
import 'package:online_admission/screens/admission_form/screen_five/screen_five_viewmodel.dart';
import 'package:online_admission/screens/admission_form/screen_four/screen_four_model.dart';
import 'package:online_admission/screens/admission_form/screen_three/screen_three_model.dart';
import 'package:online_admission/screens/admission_form/screen_two/screen_two_model.dart';
import 'package:printing/src/preview/pdf_preview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../screen_one/screen_one_model.dart';

class ScreenFiveView extends StatelessWidget {
  ScreenFiveView({super.key});

  static const screenFiveView = 'screenfiveview';

  final ScreenFiveViewModel viewModel = Get.put(ScreenFiveViewModel());

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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '5/5',
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
        body: Obx(() => LoadingOverlay(
            isLoading: viewModel.loader.value,
            progressIndicator: const CircularProgressIndicator(
              strokeWidth: 6.5,
              color: Colors.white,
            ),
            color: Colors.black54,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Center(
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 45,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/1.3,
                        height: MediaQuery.of(context).size.height/4.1,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade600
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(18))
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: PdfPreview(
                            padding: EdgeInsets.zero,
                            // maxPageWidth: double.infinity,
                            useActions: false,
                            build: (context) => viewModel.createPDF(),
                          ),
                        ),
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        height: 45,
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(22))
                        ),
                        child: MaterialButton(
                          onPressed: (){
                            showToast('File downloaded');
                          },
                          child: const Text(
                            'Download Fee Slip',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/1.3,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Must upload submitted fee slip',
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height/4,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(18)),
                                border: Border.all(
                                  color: Colors.grey.shade600
                                )
                              ),
                              child: Center(
                                child: Obx(() => viewModel.imageFile.value!.path == '' ? GestureDetector(
                                  onTap: ()async{
                                    showModalBottomSheet(context: context, builder: (context) {
                                      return Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                              child: IconButton(
                                                  onPressed: ()async {
                                                    await viewModel.pickFile(ImageSource.camera);
                                                  },
                                                  icon: const Icon(
                                                    Icons.camera_alt_outlined,
                                                    size: 40.0, color: Colors.blue,)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                              child: IconButton(
                                                  onPressed: () async{
                                                    await viewModel.pickFile(ImageSource.gallery);
                                                  },
                                                  icon: const Icon(
                                                    Icons.folder_copy_outlined,
                                                    size: 40.0, color: Colors.red,)),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                                    // await viewModel.pickFile(src)
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.upload_file_outlined,
                                        size: 65,
                                        color: Colors.grey.shade600,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Upload your submitted fee slip photo here',
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ) : Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                        child: Image.file(
                                          viewModel.imageFile.value!, fit: BoxFit.fill,)),
                                    Positioned(
                                      top: 3,
                                        right: 5,
                                        child: Container(
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            color: primaryColor.withOpacity(1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: GestureDetector(
                                            onTap: (){
                                              viewModel.fileUploadedCheck.value = true;
                                              viewModel.imageFile.value = File('');
                                            },
                                            child: const Icon(
                                              Icons.close_outlined,
                                              color: Colors.white,
                                              size: 17,
                                            ),
                                          )
                                        )
                                    )
                                  ],
                                )
                              ),
                              )
                            ),
                            Obx(() => Visibility(
                              visible: viewModel.fileUploadedCheck.value,
                              child: const Text(
                                'Upload Document to Submit Form',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width/2.8,
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
                              width: MediaQuery.of(context).size.width/2.8,
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
                                    'Submit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  onPressed: ()async {
                                    if (viewModel.imageFile.value?.path == '') {
                                      viewModel.fileUploadedCheck.value = true;
                                    } else {
                                      bool checkConn = await checkConnection();
                                      if (checkConn == true) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                  'Submit Form',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                content: Text(
                                                  'Are you sure, you want to submit the form?\nThis action cannot be undone.',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      // fontWeight: FontWeight.w600,
                                                      fontSize: 15
                                                  ),
                                                ),
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: Text(
                                                            'No',
                                                          style: TextStyle(
                                                            color: Colors.black
                                                          ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                          onPressed: () async {
                                                            viewModel.loader.value = true;
                                                            var prefs = await SharedPreferences.getInstance();
                                                            Map<String, String> downloadLinks = {};
                                                            Map<String, String> feeSlip = {};
                                                            var pageOneDetailsInString = await prefs.getString('1');
                                                            var pageTwoDetailsInString = await prefs.getString('2');
                                                            var pageThreeDetailsInString = await prefs.getString('3');
                                                            var pageFourDetailsInString = await prefs.getStringList('4');

                                                            final pageOneDetails = FirstPageModel.fromJson(jsonDecode(pageOneDetailsInString!));
                                                            final pageTwoDetails = SecondPageModel.fromJson(jsonDecode(pageTwoDetailsInString!));
                                                            final pageThreeDetails = ThirdPageModel.fromJson(jsonDecode(pageThreeDetailsInString!));
                                                            final docsList = <FourthPageModel>[];

                                                            pageFourDetailsInString?.forEach((element) {
                                                              var docDetails = FourthPageModel.fromJson(jsonDecode(element));
                                                              docsList.add(docDetails);
                                                            });
                                                            final userID = await prefs.get('userID');
                                                            try {
                                                              docsList.forEach((element) async {
                                                                final name = element.fieldName;
                                                                final ref = FirebaseStorage.instance.ref().child('user_docs').child(userID.toString()).child(name!);
                                                                final uploadTask = ref.putFile(File(element.file.toString()));
                                                                final snapshot = await uploadTask.whenComplete(() {});
                                                                final downloadURL = await snapshot.ref.getDownloadURL();
                                                                downloadLinks.addAll({
                                                                  '${element.fieldName}': downloadURL
                                                                });
                                                              });
                                                            } catch (e) {
                                                              viewModel.loader.value = false;
                                                              print(e);
                                                            }
                                                            try {
                                                              final ref = FirebaseStorage.instance.ref().child('user_docs').child(userID.toString()).child('feeSlip');
                                                              final uploadTask = ref.putFile(
                                                                  File('${viewModel.imageFile.value}')
                                                              );
                                                              final snapshot = await uploadTask.whenComplete(() {});
                                                              final downloadURL = await snapshot.ref.getDownloadURL();
                                                              feeSlip.addAll({
                                                                'feeSlip': downloadURL
                                                              });
                                                            } catch (e) {
                                                              viewModel.loader.value = false;
                                                              print(e);
                                                            }
                                                            await FirebaseFirestore.instance.collection('user_data').doc(userID.toString()).update({
                                                              'firstPageDetails': pageOneDetails.toJson(),
                                                              'secondPageDetails': pageTwoDetails.toJson(),
                                                              'thirdPageDetails': pageThreeDetails.toJson(),
                                                              'fourthPageDetails': downloadLinks,
                                                              'fifthPageDetails': feeSlip,
                                                            });
                                                            viewModel.loader.value = false;
                                                          },
                                                          child: Text(
                                                              'Yes',
                                                            style: TextStyle(
                                                              color: Colors.black
                                                            ),
                                                          )
                                                      )
                                                    ],
                                                  )
                                                ],
                                              );
                                            });
                                      } else{
                                        viewModel.loader.value = false;
                                        showToast('No Internet Connection');
                                      }
                                    }
                                  }
                                  ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}