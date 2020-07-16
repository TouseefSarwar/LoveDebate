
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Utils/Designables/ErrorDialog.dart';

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

  static showSuccess(String msg,VoidCallback action ,BuildContext context){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SuccesfullDialog(sucMsg: msg,action: action,);
        }
    ).then((value){
    });
  }

}