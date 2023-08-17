import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_admission/constants.dart';
import 'package:online_admission/screens/admission_form/screen_four/screen_four_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen_five/screen_five_view.dart';
import '../screen_five/screen_five_viewmodel.dart';

class ScreenFourView extends StatelessWidget {

  final ScreenFourViewModel viewModel = Get.put(ScreenFourViewModel());

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
                '4/5',
                style: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                ),
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                const Text(
                  'Upload Documents',
                  style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text('(Original Documents, PDF only)',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Obx(() => ListView.builder(
                  physics: const ScrollPhysics(),
                    itemCount: viewModel.fieldList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index){
                      if(index == 0){
                        return uploadDocField(fieldName: 'CNIC/Form-B', context: context, index: index);
                      }
                      else if(index == 2){
                        return uploadDocField(fieldName: 'Father/Mother CNIC', context: context, index: index);
                      }
                      else {
                        return uploadDocField(
                            fieldName: viewModel.fieldList[index].fieldName,
                            context: context,
                            index: index);
                      }
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
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
                            // viewModel.loader.value = true;
                            viewModel.fieldList.forEach((element) {
                              if (element.file == '' || element.file == null) {
                                viewModel.proceed.value = false;
                                element.showError = true;
                                viewModel.loader.value = false;
                              }
                            });
                            viewModel.fieldList.refresh();
                            if (viewModel.proceed.isTrue) {
                              List<String> list = [];
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              viewModel.fieldList.forEach((element) {
                                var json = jsonEncode(element);
                                list.add(json);
                              });
                              await prefs.setStringList('4', list);
                              viewModel.loader.value = false;
                              Get.put(ScreenFiveViewModel());
                              Get.to(() => ScreenFiveView());
                            } else{
                              viewModel.loader.value = false;
                            }
                          }
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding uploadDocField({String? fieldName, BuildContext? context, int? index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            // height: 45,
            child: Text(
              fieldName.toString(),
              maxLines: 3,
              style: const TextStyle(
                fontFamily: 'Poppins',
                  color: Color(0xff435060),
                  fontWeight: FontWeight.w600,
                  fontSize: 13
              ),
            ),
          ),
          Column(
            children: [
              DottedBorder(
                  dashPattern: const [12, 5],
                  color: viewModel.fieldList[index!].showError ? Colors.red : Colors.grey.shade600,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  padding: const EdgeInsets.all(6),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context!).size.width / 2.2,
                              height: 40,
                              child: Obx(() =>
                              viewModel.fieldList[index].pageImage == null
                                  ? GestureDetector(
                                onTap: () async {
                                  await viewModel.pickFile(index);
                                },
                                child: Center(
                                  child: viewModel.fieldList[index].showLoader == false ? const Text(
                                    'Upload Here',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ) : CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                    color: Colors.grey.shade800,
                                  )
                                ),
                              ) : Image(image: MemoryImage(viewModel.fieldList[index].pageImage!),
                                fit: BoxFit.fill,),
                              )
                          ),
                          Obx(() => viewModel.fieldList[index].pageImage != null ?
                          Positioned(
                            right: 2,
                            top: 2,
                            child: InkWell(
                              onTap: () {
                                viewModel.fieldList[index].file = '';
                                viewModel.fieldList[index].pageImage = null;
                                viewModel.fieldList[index].showError = true;
                              },
                              child: Container(
                                width: 17,
                                height: 17,
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close_outlined, color: Colors.white, size: 15,),
                              ),),
                          ) : Container(),
                          )
                        ],
                      )
                  )
              ),
              const SizedBox(
                height: 4,
              ),
              Obx(() =>
                  Visibility(
                    visible: viewModel.fieldList[index].showError,
                    child: const Text(
                      'Upload Document',
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}