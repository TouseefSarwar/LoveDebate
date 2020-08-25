
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_push_notifications/Utils/Designables/ErrorDialog.dart';

class GFunction{

  static bool validateEmail(String emailAddress ){
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(emailAddress);
  }

  static showError(String msg, BuildContext context){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return ErrorDialog(errorMsg: msg);
        }
    ).then((value){
    });
  }

  static showSuccess(VoidCallback action ,BuildContext context, {String subMsg,String title, bool imageStatus = true} ){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SuccesfullDialog(titleMsg: title,subTitle: subMsg, imageStatus: imageStatus,action: action,);
        }
    ).then((value){
    });
  }

  String validatePassword(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    if(value == ''){
      return 'Password is required';
    }else{
      return null;
    }
  }

}