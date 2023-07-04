import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_admission/screens/status/status_viewmodel.dart';

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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Status',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.red,
                        width: 0.5
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/document_icon.png'),
                      )
                    ),
                  ),
                  SizedBox(width: 11,),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width/5.5,
                    color: Colors.red,
                  ),
                  SizedBox(width: 11,),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.grey,
                            width: 0.5
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/document_icon_grey.png'),
                        )
                    ),
                  ),
                  SizedBox(width: 11,),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width/5.5,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 11,),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.grey,
                            width: 0.5
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/interview_call_icon.png'),
                        )
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Step 1',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Admission Form',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 11.5
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          height: 16,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Under Review',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 11
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xFFFDF1D3),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              border: Border.all(
                                width: 0,
                                color: Color(0xFFFDF1D3),
                              )
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Step 2',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Fee Slip',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11.5
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          height: 16,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Pending',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 11
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              // color: Color(0xFFFDF1D3),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              border: Border.all(
                                width: 0,
                                // color: Color(0xFFFDF1D3),
                              )
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Step 3',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Interview Call',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11.5
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          height: 16,
                          // width: 85,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Pending',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 11
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              border: Border.all(
                                width: 0,
                              )
                          ),
                        )
                      ],
                    )
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
                            color: Colors.grey,
                            width: 0.5
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/document_icon.png'),
                        )
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Step 1',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Admission Form',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 11.5
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/1.2,
                    child: Text(
                      'Welcome to out UET merit checking and online admission application! Our app makes it easy to check your results and apply for admission to the University of Engineering and Technology.',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Container(
                      height: 85,
                      width: MediaQuery.of(context).size.width/1.15,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff03C55E),
                            Color(0xffD0874C)
                          ]
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all(
                          width: 0.1
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Process Completion',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12
                                  ),
                                ),
                                Text(
                                  '0%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(13)),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
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
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Remaining Time',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12
                                  ),
                                ),
                                Text(
                                  '5 days remaining',
                                  style: TextStyle(
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}