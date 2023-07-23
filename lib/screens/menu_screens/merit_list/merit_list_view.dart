import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:online_admission/constants.dart';
import 'package:online_admission/screens/menu_screens/merit_list/merit_list_viewmodel.dart';

class MeritListView extends StatelessWidget {
  MeritListView({super.key});

  final MeritListViewModel viewModel = Get.put(MeritListViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Obx(() => LoadingOverlay(
          isLoading: viewModel.overlay.value,
          color: Colors.black54,
          progressIndicator: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 6.5,
          ),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/1.5,
                  width: MediaQuery.of(context).size.width * 1.2,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xffd1d3da),
                        width: 1.5,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12))
                  ),
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Color(0xffd1d3da),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    meritListHeading('ETEA Id'),
                                    meritListHeading('Name'),
                                    meritListHeading('F/Name'),
                                    meritListHeading('Aggregate'),
                                    meritListHeading('Eligibility'),
                                  ],
                                )
                            ),
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: viewModel.meritList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          meritListText(viewModel.meritList[index].meritNumber.toString(), 40),
                                          meritListText(viewModel.meritList[index].studentName.toString(), 60),
                                          meritListText(viewModel.meritList[index].fatherName.toString(), 60),
                                          meritListText(viewModel.meritList[index].aggregate.toString(), 40),
                                          meritListText(viewModel.meritList[index].eligibility.toString(), 35),
                                        ],
                                      ),
                                      const Divider(
                                        color: Color(0xffd1d3da),
                                        thickness: 1.5,
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width/4.6,
                        child: Container(
                          color: const Color(0xffd1d3da),
                          width: 1.5,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width/2.1,
                        child: Container(
                          color: const Color(0xffd1d3da),
                          width: 1.5,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),
                      Positioned(
                        right: MediaQuery.of(context).size.width/2.09,
                        child: Container(
                          color: const Color(0xffd1d3da),
                          width: 1.5,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),
                      Positioned(
                        right: MediaQuery.of(context).size.width/4.3,
                        child: Container(
                          color: const Color(0xffd1d3da),
                          width: 1.5,
                          height: MediaQuery.of(context).size.height,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 55,
                  width: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(28)),
                    border: Border.all(
                      width: 1,
                      color: primaryColor
                    ),
                    color: primaryColor
                  ),
                  child: TextButton(
                      onPressed: (){
                        Get.back();
                      }, child: Text(
                    'Done',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        fontFamily: 'Poppins'
                    ),
                  )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  meritListHeading(String heading){
    return SizedBox(
      width: 70,
      child: Center(
        child: Text(
          heading,
          style: const TextStyle(
              color: Color(0xff435060),
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
              fontSize: 12
          ),
        ),
      ),
    );
  }

  meritListText(String text, double width){
    return SizedBox(
      width: width,
      child: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.fade,
        style: const TextStyle(
            color: Color(0xff435060),
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
            fontSize: 10
        ),
      ),
    );
  }

}
