import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:online_admission/screens/status/status_viewmodel.dart';
import 'dart:io';
import '../../constants.dart';

class StatusView extends StatelessWidget {
  StatusView({super.key});

  final StatusViewModel viewModel = Get.put(StatusViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Status',
                style: TextStyle(
                  color: Color(0xff435060),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(() => LoadingOverlay(
            isLoading: viewModel.overlay.value,
            color: Colors.black45,
            progressIndicator: const CircularProgressIndicator(
              strokeWidth: 6.5,
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 18),
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: viewModel.fillStop.value == 0.03 ? Color(0xff707070) : viewModel.fillStop.value == 0.3 ? const Color(0xffd0874c) : const Color(0xff03c55e),
                              width: 0.8
                            ),
                            image: viewModel.fillStop.value == 0.03 ? const DecorationImage(
                                image: AssetImage('assets/images/document_icon_grey.png'),) : viewModel.fillStop.value == 0.3 ? const DecorationImage(
                              image: AssetImage('assets/images/document_icon.png'),
                            ) : null,
                          ),
                          child: viewModel.fillStop.value < 0.4 ? null : const CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xff03c55e),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 11,),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width/5.5,
                          color: viewModel.fillStop.value == 0.03 ? Color(0xffc6c6c6) : viewModel.fillStop.value == 0.3 ? const Color(0xffd0487c) : const Color(0xff03c55e),
                        ),
                        const SizedBox(width: 11,),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: viewModel.fillStop.value <= 0.3  ? Colors.grey : viewModel.fillStop.value == 0.6 ? const Color(0xffd0874c) : const Color(0xff03c55e),
                                  width: 0.8
                              ),
                              image: DecorationImage(
                                image: viewModel.fillStop.value <= 0.3 ? const AssetImage('assets/images/document_icon_grey.png') :
                                    const AssetImage('assets/images/document_icon.png'),
                              )
                          ),
                          child: viewModel.fillStop.value < 0.6 ? null : const CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xff03c55e),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(width: 11,),
                        // Container(
                        //   height: 1,
                        //   width: MediaQuery.of(context).size.width/5.5,
                        //   color: viewModel.fillStop.value > 0.3 ? const Color(0xff03c55e) : Colors.grey,
                        // ),
                        // const SizedBox(width: 11,),
                        // Container(
                        //   width: 30,
                        //   height: 30,
                        //   decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       shape: BoxShape.circle,
                        //       border: Border.all(
                        //           color: viewModel.fillStop.value < 0.6 ? Colors.grey : const Color(0xffd0874c),
                        //           width: 0.8
                        //       ),
                        //       image: DecorationImage(
                        //         image: viewModel.fillStop.value < 0.6 ? const AssetImage('assets/images/interview_call_grey.png') : const AssetImage('assets/images/interview_call_colored.png')
                        //       )
                        //   ),
                        // ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Step 1',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
                                'Admission Form',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11.5
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Container(
                                height: 20,
                                decoration: BoxDecoration(
                                    color: viewModel.fillStop.value == 0.03 ? Colors.white : viewModel.fillStop.value > 0.3 ? const Color(0xff03c55e) : const Color(0xFFFDF1D3),
                                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                                    border: Border.all(
                                      width: viewModel.formSubmitted.value ? 0 : 1.5,
                                      color: viewModel.formSubmitted.value ? const Color(0xFFFDF1D3) : const Color(0xff444443)
                                    )
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      viewModel.formSubmitted.value == false ? 'Pending' : viewModel.fillStop.value > 0.3 ? 'Completed' : 'Under Review',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: viewModel.fillStop.value == 0.6 ? Colors.white : Colors.grey.shade600,
                                          fontSize: 11
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width/10.7,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Step 2',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Fee Slip',
                                style: TextStyle(
                                    color: viewModel.fillStop.value > 0.3 ? const Color(0xff435060) : Colors.grey,
                                    fontSize: 11.5
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  color: viewModel.fillStop.value < 0.6 ? Colors.white : viewModel.fillStop.value == 0.6 ? const Color(0xFFFDF1D3) : viewModel.fillStop.value > 0.6 ? const Color(0xff03c55e) : null,
                                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                                    border: Border.all(
                                      width: viewModel.fillStop.value < 0.6 ? 0 : 1.5,
                                      color: viewModel.fillStop.value < 0.6 ? const Color(0xff444443) : viewModel.fillStop.value == 0.6 ? const Color(0xFFFDF1D3) : const Color(0xff03c55e),
                                    )
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      viewModel.fillStop.value < 0.6 ? 'Pending' : viewModel.fillStop.value > 0.6 ? 'Completed' : 'In Progress',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: viewModel.fillStop.value == 0.6 ? Colors.white : Colors.grey.shade600,
                                          fontSize: 11
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          // SizedBox(
                          //   width: viewModel.fillStop.value == 0.3 ? MediaQuery.of(context).size.width/8.4 : viewModel.fillStop.value == 0.6 ? MediaQuery.of(context).size.width/7.5 : MediaQuery.of(context).size.width/6.1,
                          // ),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     const Text(
                          //       'Step 3',
                          //       style: TextStyle(
                          //         color: Colors.grey,
                          //         fontSize: 10,
                          //       ),
                          //     ),
                          //     const SizedBox(
                          //       height: 3,
                          //     ),
                          //     const Text(
                          //       'Interview Call',
                          //       style: TextStyle(
                          //           color: Colors.grey,
                          //           fontSize: 11.5
                          //       ),
                          //     ),
                          //     const SizedBox(
                          //       height: 3,
                          //     ),
                          //     Container(
                          //       height: 20,
                          //       decoration: BoxDecoration(
                          //           borderRadius: const BorderRadius.all(Radius.circular(15)),
                          //           color: viewModel.fillStop.value < 0.6 ? Colors.white : const Color(0xFFFDF1D3),
                          //           border: Border.all(
                          //             width: viewModel.fillStop.value < 0.6 ? 1.5 : 0,
                          //             color: viewModel.fillStop.value < 0.6 ? const Color(0xff444443) : viewModel.fillStop.value == 0.6 ? const Color(0xFFFDF1D3) : const Color(0xff03c55e),
                          //           )
                          //       ),
                          //       // width: 85,
                          //       child: Center(
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          //           child: Text(
                          //             viewModel.fillStop.value == 0.6 ? 'In Progress' : 'Pending',
                          //             textAlign: TextAlign.center,
                          //             style: TextStyle(
                          //                 color: Colors.grey.shade600,
                          //                 fontSize: 11
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     )
                          //   ],
                          // )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 35.0, bottom: 8),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: const Color(0xffd0874c),
                                  width: 0.8
                              ),
                              image: viewModel.fillStop.value <= 0.6 ? const DecorationImage(
                                image: AssetImage('assets/images/document_icon.png'),
                              ) : null,
                          ),
                          child: viewModel.fillStop.value == 0.9 ? CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xff03c55e),
                            child: Icon(Icons.check, color: Colors.white, size: 15,),
                          ) : null,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                            viewModel.fillStop.value < 0.6 ? 'Step 1' : viewModel.fillStop.value == 0.6 ? 'Step 2' : '',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Obx(() => Text(
                            viewModel.fillStop.value < 0.6 ? 'Admission Form' : viewModel.fillStop.value == 0.6 ? 'Fee Slip' : 'Completed',
                            style: const TextStyle(
                                color: Color(0xff435060),
                                fontSize: 12,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins'
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width/1.2,
                          child: Obx(() => Text(
                              viewModel.fillStop.value == 0.03 ?
                              'Welcome to out UET merit checking and online admission application! Our app makes it easy to check your results and apply for admission to the University of Engineering and Technology.' : viewModel.fillStop.value == 0.3 ? 'Your application is under review. This might take between 1-2 days.' : viewModel.fillStop.value == 0.6 ? 'Download your UET admission fee slip submit in UBL bank and upload in pdf form.' : 'Application accepted. Wait for Interview call date',
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: Container(
                            height: 75,
                            width: MediaQuery.of(context).size.width/1.15,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xffD0874C),
                                  Color(0xff03C55E),
                                ]
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(45)),
                              border: Border.all(
                                // width: 0.01,
                                color: Colors.transparent
                              )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 28.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Process Completion',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontSize: 12
                                        ),
                                      ),
                                      Text(
                                        viewModel.fillStop.value == 0.03 ? '0%' : viewModel.fillStop.value == 0.3 ? '35%' : viewModel.fillStop.value == 0.6 ? "70%" : '99%',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Poppins'
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(13)),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: const [
                                          Colors.red,
                                          Colors.red,
                                          Colors.white,
                                          Colors.white
                                        ],
                                        stops: [
                                          0.0,
                                          viewModel.fillStop.value,
                                          viewModel.fillStop.value,
                                          1.0
                                          ]
                                      )
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Remaining Time',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontSize: 12
                                        ),
                                      ),
                                      Text(
                                        '5 days remaining',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 12
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Obx(() => Visibility(
                            visible: viewModel.dataVisibility.value,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  viewModel.firstOrSecondPageRejection.value ? 'Upload Form Again' : 'Upload Below Documents',
                                  style: const TextStyle(
                                    color: Color.fromRGBO(67, 80, 96, 1),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                const Text(
                                  'Admin Feedback',
                                  style: TextStyle(
                                      color: Color.fromRGBO(67, 80, 96, 1),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Text(
                                    viewModel.feedbackMessage.value,
                                    style: const TextStyle(
                                        color: Color.fromRGBO(68, 68, 67, 1),
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                const SizedBox(
                                  height: 10,
                                ),
                                viewModel.firstOrSecondPageRejection.value ? Center(
                                  child: Text(
                                    viewModel.firstOrSecondPageMessage.value,
                                    style: const TextStyle(
                                        color: Color.fromRGBO(68, 68, 67, 1),
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ) : ListView.builder(
                                    itemCount: viewModel.docsList.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index){
                                      return uploadDocField(fieldName: viewModel.docsList[index].fieldName, index: index);
                                    }
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width/2.2,
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
                                onPressed: ()async{
                                  await viewModel.checkDocs();
                                },
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding uploadDocField({String? fieldName, int? index}) {
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
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                fontFamily: 'Poppins'
              ),
            ),
          ),
          Column(
            children: [
              DottedBorder(
                  dashPattern: const [12, 5],
                  color: viewModel.docsList[index!].showError ? Colors.red : Colors.grey.shade600,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  padding: const EdgeInsets.all(6),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(Get.context!).size.width / 2.2,
                              height: 40,
                              child: Obx(() => viewModel.docsList[index].fieldName == 'Fee Slip' ? viewModel.docsList[index].file == null ? GestureDetector(
                                onTap: () async {
                                  await viewModel.pickFile(index: index);
                                },
                                child: const Center(
                                    child: Text(
                                      'Upload Here',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                ),
                              ) : Stack(
                                fit: StackFit.loose,
                                children: [
                                  Center(child: Image.file(File(viewModel.docsList[index].file.toString()))),
                                  Positioned(
                                    right: 2,
                                    top: 2,
                                    child: InkWell(
                                      onTap: () {
                                        viewModel.docsList[index].file = null;
                                        viewModel.docsList[index].showError = true;
                                        viewModel.docsList.refresh();
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
                                  )
                                ],
                              ) :
                              viewModel.docsList[index].pageImage == null
                                  ? GestureDetector(
                                onTap: () async {
                                  await viewModel.pickFile(index: index);
                                },
                                child: Center(
                                    child: viewModel.docsList[index].showLoader == false ? const Text(
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
                              ) : Image(image: MemoryImage(viewModel.docsList[index].pageImage!),
                                fit: BoxFit.fill,),
                              )
                          ),
                          Obx(() => viewModel.docsList[index].pageImage != null ?
                          Positioned(
                            right: 2,
                            top: 2,
                            child: InkWell(
                              onTap: () {
                                viewModel.docsList[index].file = '';
                                viewModel.docsList[index].pageImage = null;
                                viewModel.docsList[index].showError = true;
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
                    visible: viewModel.docsList[index].showError,
                    child: const Text(
                      'Upload Document',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontFamily: 'Poppins',
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