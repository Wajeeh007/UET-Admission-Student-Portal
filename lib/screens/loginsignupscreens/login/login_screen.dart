import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:online_admission/screens/base/base_layout.dart';
import 'package:online_admission/screens/loginsignupscreens/sign_up/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_admission/constants.dart';
import 'package:flutter/services.dart';
import 'package:online_admission/functions/google_and_facebook_auth.dart';
import 'login_screen_viewmodel.dart';

class LoginScreen extends StatelessWidget {

  LoginScreen({super.key});

  final LoginViewModel viewModel = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => LoadingOverlay(
            isLoading: viewModel.overlay.value,
            color: Colors.black54,
            progressIndicator: const CircularProgressIndicator(
              strokeWidth: 6.5,
              color: Colors.white,
            ),
            child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Center(child: Image.asset('assets/images/uni_logo.png', height: 150, width: 150,)),
                          const SizedBox(
                            height: 18,
                          ),
                          Center(child: Text('Welcome Back, please login to access your UET merit list and admission application', style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w600, fontSize: 14.5),)),
                        const SizedBox(
                          height: 16,
                        ),
                          Form(
                        key: viewModel.formKey,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Align(alignment: Alignment.centerLeft,child: Text('Email', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),)),
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
                                errorStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 15)
                              ),
                            ),
                          ],
                        ),
                      ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Align(alignment: Alignment.centerLeft, child: Text('Password', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),)),
                          ),
                          const SizedBox(
                            height: 10,
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
                            obscureText: !viewModel.passwdVisibility.value,
                            decoration: kSignUpAndLogInScreenFieldDecoration.copyWith(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                              errorStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              hintText: 'Enter your password',
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    viewModel.passwordVisibilityFunc();
                                  },
                                  icon: viewModel.passwordFieldIcon.value
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: (){},
                                child: const Text('Forgot Password ?', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, shadows: [
                                  Shadow(
                                      color: primaryColor,
                                      offset: Offset(0.0, -0.8)
                                  ),
                                ],
                                  color: Colors.transparent,
                                  decorationThickness: 2,
                                  decoration: TextDecoration.underline,
                                  decorationColor: primaryColor,),)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: primaryColor,
                            ),
                            child: MaterialButton(
                              elevation: 10,
                              onPressed: () async {
                                viewModel.overlay.value = true;
                                FocusManager.instance.primaryFocus?.unfocus();
                                SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
                                final connCheck = await checkConnection();
                                if (connCheck == true) {
                                  await viewModel.validateAndSubmit();
                                  if (viewModel.proceed.value == true) {
                                    // Model.changeValue();
                                    viewModel.overlay.value = false;
                                    Get.off(() => BaseLayout());
                                  }
                                }
                                else {
                                  viewModel.overlay.value = false;
                                  showToast('No Internet Connection');
                                }
                              },
                              child: const Text('Log In',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.0
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Or', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),),
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
                                    dynamic user = await GoogleLogIn().signInWithGoogle();
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
                              //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BaseLayout()));
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
                                'Don\'t have an account?',
                                style: TextStyle(
                                    color: Colors.black,
                                ),
                              ),
                              TextButton(
                                  onPressed: (){
                                    Get.off(() => SignUpScreen());
                                    },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
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
                          )
                        ],
                      ),
                    ),
                  ),
                )
            ),
          ),
        ),
      );
  }
}