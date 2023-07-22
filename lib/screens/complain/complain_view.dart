import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:online_admission/constants.dart';
import 'package:online_admission/screens/complain/complain_viewmodel.dart';

class ComplainScreen extends StatelessWidget {

  ComplainScreen({super.key});

  final ComplainViewModel viewModel = Get.put(ComplainViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const Padding(
            padding: EdgeInsets.only(top: 26.0),
            child: Text(
              'Complain',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: IconButton(
              onPressed: ()=>Get.back(),
              icon: const Icon(Icons.arrow_back_rounded, size: 36, color: Colors.black,),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: viewModel.overlay.value,
        color: Colors.black54,
        progressIndicator: const CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 6.5,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
          child: Center(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  Form(
                    key: viewModel.formKey,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 23.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Issue Title',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          TextFormField(
                            cursorColor: Colors.white,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 19
                            ),
                            controller: viewModel.complainTitle,
                            validator: (value){
                              if(value == null || value == ''){
                                return 'Field cannot be empty';
                              }
                              else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                              errorStyle: const TextStyle(
                                fontWeight: FontWeight.w600
                              ),
                              filled: true,
                              fillColor: primaryColor,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 0,
                                  color: primaryColor
                                ),
                                borderRadius: BorderRadius.circular(28)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2,
                                  color: primaryColor
                                ),
                                borderRadius: BorderRadius.circular(28)
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 23.0, top: 25),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Description',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          TextFormField(
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w600
                            ),
                            cursorColor: Colors.white,
                            maxLines: 13,
                            controller: viewModel.complainDescrition,
                            validator: (value){
                              if(value == null || value == ''){
                                return 'Field cannot be empty';
                              }
                              else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 18),
                              errorStyle: const TextStyle(
                                fontWeight: FontWeight.w600
                              ),
                              filled: true,
                              fillColor: primaryColor,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 0,
                                  color: primaryColor
                                ),
                                borderRadius: BorderRadius.circular(28)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2,
                                    color: primaryColor
                                ),
                                borderRadius: BorderRadius.circular(28)
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xDDd0874c),
                      borderRadius: const BorderRadius.all(Radius.circular(21)),
                      border: Border.all(
                        width: 0,
                      ),
                    ),
                    child: MaterialButton(
                      onPressed: (){
                        viewModel.validateForms();
                      },
                      child: const Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}