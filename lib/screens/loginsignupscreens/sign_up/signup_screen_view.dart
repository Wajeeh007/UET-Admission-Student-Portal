import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:online_admission/screens/base/base_layout.dart';
import 'package:online_admission/screens/loginsignupscreens/login/login_screen.dart';
import 'signup_screen_viewmodel.dart';
import 'package:online_admission/constants.dart';
import 'package:flutter/services.dart';
import 'package:online_admission/functions/google_and_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatelessWidget {

  SignUpScreen({super.key});

  final SignUpViewModel viewModel = Get.put(SignUpViewModel());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
              child: Obx(() => LoadingOverlay(
                  color: Colors.black54,
                  progressIndicator: const CircularProgressIndicator(
                          strokeWidth: 6,
                          color: Colors.white,
                        ),
                  isLoading: viewModel.overlay.value,
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                              children: [
                                Stack(
                                  fit: StackFit.loose,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: const Color(0xffededed),
                                      radius: 75,
                                      backgroundImage: viewModel.imageFile.value?.path == '' ? null : FileImage(File(viewModel.imageFile.value!.path)),
                                      child: Center(
                                        child: viewModel.imageFile.value?.path == '' ? const Icon(Icons.person, color: Color(0xff707070), size: 80,) : null,
                                      ),
                                    ),
                                    Positioned(
                                      right: 25,
                                      bottom: 0,
                                      child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffd9ad89),
                                        shape: BoxShape.circle,
                                      ),
                                        child: Center(child: GestureDetector(onTap: ()async{
                                          showModalBottomSheet(context: context, builder: (context) {
                                            return Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                                    child: IconButton(
                                                        onPressed: ()async {
                                                          await viewModel.pickImage(ImageSource.camera);
                                                        },
                                                        icon: const Icon(
                                                          Icons.camera_alt_outlined,
                                                          size: 40.0, color: Colors.blue,)),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                                    child: IconButton(
                                                        onPressed: () async{
                                                          await viewModel.pickImage(ImageSource.gallery);
                                                        },
                                                        icon: const Icon(
                                                          Icons.folder_copy_outlined,
                                                          size: 40.0, color: Colors.red,)),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                        }, child: const Icon(Icons.camera_alt, color: Colors.white, size: 15,))),
                                    ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Obx(() => Visibility(
                                    visible: viewModel.imageUploadError.value,
                                    child: const Text(
                                      'Upload Image to Sign Up',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13
                                      ),
                                  ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                Center(
                                    child: Text(
                                      'Welcome, please register yourself to access your UET merit list and admission application',
                                      style: TextStyle(
                                          color: Color(0xff444443),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.5,
                                        fontFamily: 'Poppins'
                                      ),
                                    ),
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                Form(
                                  key: viewModel.formKey,
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 15.0),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Email',
                                              style: TextStyle(
                                                  color: Color(0xff444443),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins'
                                              ),
                                            ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      TextFormField(
                                        onChanged: (value) {
                                            viewModel.email.value = value;
                                        },
                                        validator: (value) {
                                          if (value == null || value == '') {
                                            return 'Field Cannot Be Empty';
                                          }
                                          else if (!RegExp(r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$").hasMatch(value)) {
                                            return 'Enter a valid Email Address';
                                          }
                                          else {
                                            return null;
                                          }
                                        },
                                        decoration: kSignUpAndLogInScreenFieldDecoration.copyWith(
                                          hintText: 'Enter your email',
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                                          errorStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 13.0,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 15.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Password',
                                            style: TextStyle(
                                                color: Color(0xff444443),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins'
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      TextFormField(
                                        onChanged: (value) {
                                          viewModel.password.value = value;
                                        },
                                        validator: (value) {
                                          if (value == null || value == '') {
                                            return 'Field Cannot Be Empty';
                                          }
                                          else if (value.length < 8) {
                                            return 'Password must be 8 characters long';
                                          }
                                          else {
                                            return null;
                                          }
                                        },
                                        obscureText: viewModel.passwd1Visibility.value,
                                        decoration: kSignUpAndLogInScreenFieldDecoration.copyWith(
                                          errorStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                                          hintText: 'Enter your password',
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                viewModel.password1VisibilityFunc();
                                              },
                                              icon: viewModel.password1FieldIcon.value
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 13,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 15.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Confirm Password',
                                            style: TextStyle(
                                                color: Color(0xff444443),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins'
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      TextFormField(
                                        validator: (value) {
                                          if (value == null || value == '') {
                                            return 'Field Cannot Be Empty';
                                          }
                                          else if (value != viewModel.password.value) {
                                            return 'Passwords don\'t match';
                                          }
                                          else {
                                            return null;
                                          }
                                        },
                                        obscureText: viewModel.passwd2Visibility.value,
                                        decoration: kSignUpAndLogInScreenFieldDecoration.copyWith(
                                          errorStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          hintText: 'Confirm your password',
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                viewModel.password2VisibilityFunc();
                                              },
                                              icon: viewModel.password2FieldIcon.value
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: primaryColor,
                                  ),
                                  child: MaterialButton(
                                    onPressed: () async {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
                                      if(viewModel.imageFile.value?.path == ''){
                                        viewModel.imageUploadError.value = true;
                                      }else {
                                        final connCheck = await checkConnection();
                                        if (connCheck == true) {
                                          viewModel.overlay.value = true;
                                          if (viewModel.formKey.currentState!
                                              .validate() == true) {
                                            await viewModel.validateAndSubmit();
                                            if (viewModel.proceed.value ==
                                                true) {
                                              viewModel.overlay.value = false;
                                              Get.off(() => BaseLayout());
                                            } else{
                                              viewModel.overlay.value = false;
                                            }
                                          } else{
                                            viewModel.overlay.value = false;
                                          }
                                        } else {
                                          viewModel.overlay.value = false;
                                          showToast('No Internet Connection');
                                        }
                                      }
                                    },
                                    child: const Text(
                                        'Sign Up',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          fontFamily: 'Poppins'
                                        ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                const Text(
                                  'Or',
                                  style: TextStyle(
                                      color: Color(0xff444443),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                  fontFamily: 'Poppins',
                                  ),
                                ),
                                const SizedBox(
                                  height: 17,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(image: AssetImage('assets/images/google_icon.png'), fit: BoxFit.fill)
                                      ),
                                      child: GestureDetector(
                                        onTap: ()async{
                                          viewModel.overlay.value = true;
                                          dynamic user = await GoogleSignUp().signInWithGoogle();
                                          if (user.runtimeType == UserCredential) {
                                            viewModel.overlay.value = false;
                                            Get.off(() => BaseLayout());
                                          }
                                          else {
                                            viewModel.overlay.value = false;
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    // Container(
                                    //   width: 43,
                                    //   height: 40,
                                    //   decoration: const BoxDecoration(
                                    //     shape: BoxShape.circle,
                                    //       image: DecorationImage(image: AssetImage('assets/images/fb_logo.png'), fit: BoxFit.fill)
                                    //   ),
                                    //   child: GestureDetector(
                                    //     onTap: ()async{
                                    //       Model.changeValue();
                                    //       dynamic user = await FacebookLogin().signInWithFaceBook();
                                    //       if (user.runtimeType == UserCredential) {
                                    //         Model.changeValue();
                                    //         //return Navigator.pushReplacementNamed(context, HomeScreen.homeScreen);
                                    //       }
                                    //       else {
                                    //         Model.changeValue();
                                    //       }
                                    //     },
                                    //   ),
                                    // )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Already have an account?',
                                      style: TextStyle(
                                        color: Color(0xff444443),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: (){
                                          Get.off(() => LoginScreen());
                                        },
                                        child: const Text(
                                          'Log In',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              Shadow(
                                                  color: primaryColor,
                                                  offset: Offset(0.0, -0.8)
                                              ),
                                            ],
                                            color: Colors.transparent,
                                            decorationThickness: 2,
                                            decoration: TextDecoration.underline,
                                            decorationColor: primaryColor,
                                          ),
                                        )
                                    )
                                  ],
                                ),
                    ]
                    ),
                    ),
                  ),
                ),
              )
            )),
      );
  }
}