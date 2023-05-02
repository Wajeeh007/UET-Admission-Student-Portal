import 'package:flutter/material.dart';
import 'package:online_admission/constants.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class ConfirmEmail extends StatefulWidget {
  static const confirmEmail = 'confirmemail';

  @override
  State<ConfirmEmail> createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {

  final formKey = GlobalKey<FormState>();
  String _email = '';
  bool overlay = false;

  bool validateForm(){
    final form = formKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: overlay,
          color: primaryColor,
          progressIndicator: const CircularProgressIndicator(
            strokeWidth: 6.5,
            color: Colors.white,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    Image.asset('assets/images/uni_logo.png', height: MediaQuery.of(context).size.height/6.2, width: MediaQuery.of(context).size.width/3.8,),
                    const SizedBox(
                      height: 15,
                    ),
                    Text('Enter your registered email to reset your password', style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w600, fontSize: 14.5),),
                    const SizedBox(
                      height: 18,
                    ),
                    Form(
                      key: formKey,
                        child: Column(
                          children: [
                          const Text('Email', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                          TextFormField(
                            onChanged: (value){
                              setState(() {
                                _email = value;
                              });
                            },
                            validator: (value){
                              if(value == null || value == ''){
                                return 'Empty Field';
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
                                fontWeight: FontWeight.bold
                              )
                            ),
                          )
                          ]
                        )
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      height: 38,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(18)),
                        color: primaryColor
                      ),
                      child: MaterialButton(
                          onPressed: ()async{
                            FocusManager.instance.primaryFocus?.unfocus();
                            if(validateForm() == true){
                              setState(() {
                                overlay = true;
                              });
                              final connCheck = await checkConnection();
                              try{
                                if(connCheck == true) {
                                  final methods = await _firebaseAuth.fetchSignInMethodsForEmail(_email);
                                  if (methods.isNotEmpty) {
                                    await _firebaseAuth.sendPasswordResetEmail(email: _email);
                                  }
                                  setState(() {
                                    overlay = false;
                                  });
                                  showToast('A password reset email has been sent');
                                  Navigator.pop(context);
                              }
                              }on FirebaseException {
                                setState(() {
                                  overlay = false;
                                });
                                showToast('Unexpected Error Encountered');
                              }
                            }
                          }
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}