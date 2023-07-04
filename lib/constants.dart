import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';

const Color primaryColor = Color(0x99d0874c);

bool? formSubmitted;
int pageIndex = 0;

showToast(String msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFF1188FF),
      textColor: Colors.white
  );
}

Future<bool> checkConnection()async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
    else{
      return false;
    }
  }
  on SocketException {
    return false;
  }
}

InputDecoration kSignUpAndLogInScreenFieldDecoration = const InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
  hintText: '',
  hintStyle: TextStyle(
      color: Colors.white
  ),
  fillColor: Color(0x99D0874C),
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
        Radius.circular(27.0)
    ),
  ),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: primaryColor,
          width: 1.0),
      borderRadius: BorderRadius.all(
          Radius.circular(27.0))
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: primaryColor,
          width: 3.0
      ),
      borderRadius: BorderRadius.all(Radius.circular(27.0))
  ),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: primaryColor,
          width: 3.0
      ),
      borderRadius: BorderRadius.all(Radius.circular(27.0))
  ),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(27.0)),
      borderSide: BorderSide(
          color: Colors.red,
          width: 3
      )
  ),
  errorStyle: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold
  ),
);