//import 'dart:convert';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:lovedebate/Modules/OnBoarding/PreferencesOnBoarding.dart';
//import 'package:lovedebate/Modules/Profile/MyPreferences.dart';
//import 'package:lovedebate/Utils/Designables/Toast.dart';
//import 'package:lovedebate/Utils/Globals/Colors.dart';
//import 'package:lovedebate/Utils/Globals/CustomAppBar.dart';
//import 'package:lovedebate/Utils/Globals/Fonts.dart';
//import 'package:lovedebate/Utils/Globals/GlobalFunctions.dart';
//import 'package:lovedebate/Utils/Designables/CustomTextFeilds.dart';
//import 'package:lovedebate/Utils/Globals/SignUpGlobal.dart';
//import '../../Utils/Constants/WebService.dart';
//import '../../Utils/Controllers/ApiBaseHelper.dart';
//import '../../Utils/Controllers/AppExceptions.dart';
//import '../OnBoarding/OnBoarding.dart';
//
//class SUAcountInfo extends StatefulWidget {
//
//
//  @override
//  _SUAcountInfoState createState() => _SUAcountInfoState();
//}
//
//enum Gender { male, female}
//class _SUAcountInfoState extends State<SUAcountInfo> {
//
//  //New
//
//  int index1=1;
//  int index2=2;
//  int selectedradio=0;
//
//  //end
//
//
//  TextEditingController emailTF = TextEditingController();
//  TextEditingController passTF = TextEditingController();
//  TextEditingController confirmTF = TextEditingController();
//
//  FocusNode passFN = FocusNode();
//  FocusNode confirmFN = FocusNode();
//  FocusNode emailFN = FocusNode();
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    print(SignUpGlobal.f_name);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    double _height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
//    double _width=MediaQuery.of(context).size.width;
//
//    return Scaffold(
//      appBar: CustomAppbar.setNavigation(""),
//      body: SafeArea(
//        top: true,
//        child: Container(
//          height: _height,
//          width: _width,
//          color: Colors.white,
////          margin: EdgeInsets.all(16),
//          child: ListView(
//            children: <Widget>[
//              SizedBox(height: 32,),
//              Center(
//                child: Text(
//                  "Account Info",
//                  style: TextStyle(
//                      fontSize: GlobalFont.navFontSize,
//                      fontWeight: FontWeight.w500,
//                      color: Colors.grey
//                  ),
//                ),
//              ),
//              SizedBox(height: 0,),
//              emailTextField(emailFN,emailTF,'Email Address',false),
//              SizedBox(height: 0,),
//              emailTextField(passFN,passTF,'Password', true),
//              SizedBox(height: 0,),
//              emailTextField(confirmFN,confirmTF,'Confirm Password',true),
//              SizedBox(height: 64,),
//              btnSignUp(),
//
//              Padding(
//                padding: const EdgeInsets.all(16.0),
//                child: RichText(
//                  text: TextSpan(
//                    text: 'By clicking sign up, you agree to our ',
//                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: GlobalFont.textFontSize),
//                    children: <TextSpan>[
//                      TextSpan(text: 'Terms of Service', style: TextStyle(fontSize:  GlobalFont.textFontSize,fontWeight: FontWeight.w500, color: Colors.blue)),
//                      TextSpan(text: ' and '),
//                      TextSpan(text: 'Privacy Policy', style: TextStyle(fontSize:  GlobalFont.textFontSize,fontWeight: FontWeight.w500, color: Colors.blue)),
//                    ],
//                  ),
//                ),
//              ),
//              SizedBox(height: 16,),
//            ],
//
//          ),
//        ),
//      ),
//    );
//  }
//
//  Widget emailTextField( FocusNode focusNode, TextEditingController txtFeild,String text ,bool isSecure ) {
//    return Padding(
//      padding: const EdgeInsets.all(16.0),
//      child: UnderLineTextField(
//        focusNode: focusNode,
//        txtHint: text,
//        isSecure: isSecure,
//        keyboardType: TextInputType.emailAddress,
////      enableBorderColor: Colors.white,
//        focusBorderColor: Colors.grey,
//        textColor: Colors.black,
//        txtController: txtFeild,
//        onTapFunc: () {
//          setState(() {
//            FocusScope.of(context).requestFocus(focusNode);
//          });
//        },
//      ),
//    );
//  }
//
//  Widget btnSignUp() {
//    return SizedBox(
//      height: 60,
//      child: FloatingActionButton(
//        backgroundColor: GlobalColors.firstColor,
//        onPressed: () => {
//          setState(() {
//            ValidateFields();
//          })
//        },
//        tooltip: 'Increment',
//        child: Icon(Icons.arrow_forward),
//      ),
//    );
//  }
//
//
//  void SignUpUser(){
//    var gnd = "";
////    if ( _genderValue  == Gender.male){
////      gnd = "1";
////    }else{
////      gnd = "2";
////    }
//    Map<String, dynamic> body = {
////      'f_name': fnameTF.text,
////      'l_name': lnameTF.text,
//      'email': emailTF.text,
//      'password' : passTF.text,
//      'c_password' : confirmTF.text,
//      'gender': gnd,
////      'dob' : dobTF.text,
//    };
//    print(body);
//    try {
//      ApiBaseHelper().fetchService(method: HttpMethod.post, url: WebService.login,body: body,isFormData: true).then(
//              (response){
//            Map<String, dynamic> responseJson = json.decode(response);
//            if(responseJson.containsKey('success')){
//
//            }else{
//              print(responseJson);
//            }
//          });
//
//    } on FetchDataException catch(e) {
//      setState(() {
//
//      });
//    }
//  }
//
//  void ValidateFields(){
//    if (emailTF.text != "" && emailTF.text != null){
//      if (GFunction.validateEmail(emailTF.text)){
//        //SignUpUser();
//        if (passTF.text != "" && passTF.text != null){
//          if (confirmTF.text != "" && confirmTF.text != null){
//            if (passTF.text == confirmTF.text){
//              SignUpGlobal.email = emailTF.text;
//              SignUpGlobal.password = passTF.text;
//              SignUpGlobal.c_password = confirmTF.text;
//              print(SignUpGlobal.f_name+SignUpGlobal.l_name+SignUpGlobal.dob+SignUpGlobal.gender+SignUpGlobal.personHeight+SignUpGlobal.email+SignUpGlobal.password+SignUpGlobal.c_password);
////              Navigator.push(context, CupertinoPageRoute(builder: (context) => PreferencesOnBoarding()));
//            }else{
//              Toast.show("Password and Confirm Password should be same", context, duration: Toast.LENGTH_LONG);
//            }
//          }else{
//            Toast.show("Enter Confirm Password", context, duration: Toast.LENGTH_LONG);
//          }
//        }else{
//          Toast.show("Enter Password", context, duration: Toast.LENGTH_LONG);
//        }
//      }else{
//        Toast.show("Invalid Email Formate", context, duration: Toast.LENGTH_LONG);
//      }
//    }else{
//      Toast.show("Enter Email Address", context, duration: Toast.LENGTH_LONG);
//    }
//
//  }
//
//  Widget customRadioButton(int value, int groupedValue, String text,BuildContext context, ValueChanged _onChange) {
//    return InkWell(
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.start,
//        children: <Widget>[
//          Radio(value: value, groupValue: groupedValue, onChanged: _onChange,activeColor: GlobalColors.firstColor,),
//          Text(text,style: TextStyle(fontSize: 18),),
//        ],
//      ),
//    );
//  }
//
//
//
//}



import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Modules/OnBoarding/PreferencesOnBoarding.dart';
import 'package:lovedebate/Modules/Profile/MyPreferences.dart';
import 'package:lovedebate/Utils/Designables/Toast.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/CustomAppBar.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';
import 'package:lovedebate/Utils/Globals/GlobalFunctions.dart';
import 'package:lovedebate/Utils/Designables/CustomTextFeilds.dart';
import 'package:lovedebate/Utils/Globals/SignUpGlobal.dart';
import '../../Utils/Constants/WebService.dart';
import '../../Utils/Controllers/ApiBaseHelper.dart';
import '../../Utils/Controllers/AppExceptions.dart';
import '../OnBoarding/OnBoarding.dart';

class SUAcountInfo extends StatefulWidget {


  @override
  _SUAcountInfoState createState() => _SUAcountInfoState();
}

enum Gender { male, female}
class _SUAcountInfoState extends State<SUAcountInfo> {

  //New

  int index1=1;
  int index2=2;
  int selectedradio=0;

  //end


  TextEditingController emailTF = TextEditingController();
  TextEditingController passTF = TextEditingController();
  TextEditingController confirmTF = TextEditingController();

  FocusNode passFN = FocusNode();
  FocusNode confirmFN = FocusNode();
  FocusNode emailFN = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(SignUpGlobal.f_name);
  }

  @override
  Widget build(BuildContext context) {

    double _height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double _width=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppbar.setNavigation(""),
      body: SafeArea(
        top: true,
        child: Container(
          height: _height,
          width: _width,
          color: Colors.white,
//          margin: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 32,),
                Container(
                  height: (70/100)*_height,
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Account Info",
                          style: TextStyle(
                              fontSize: GlobalFont.navFontSize,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey
                          ),
                        ),
                      ),

                      emailTextField(emailFN,emailTF,'Email Address',false),

                      emailTextField(passFN,passTF,'Password', true),

                      emailTextField(confirmFN,confirmTF,'Confirm Password',true),
                      SizedBox(height: 64,),
                      btnSignUp(),
                    ],
                  ),
                ),

                Container(
                  height: (20/100)*_height,
                  width: _width,
                  // color: Colors.green,
                  margin: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RichText(
                        textDirection: TextDirection.ltr,
                        maxLines: 3,
                        text: TextSpan(
                          text: 'By clicking sign up, you agree to our ',
                          style: Theme.of(context).textTheme.body1.copyWith(fontSize: GlobalFont.textFontSize,),
                          children: <TextSpan>[
                            TextSpan(text: 'Terms of Service', style: TextStyle(fontSize:  GlobalFont.textFontSize,fontWeight: FontWeight.w500, color: Colors.blue)),
                            TextSpan(text: ' and '),
                            TextSpan(text: 'Privacy Policy', style: TextStyle(fontSize:  GlobalFont.textFontSize,fontWeight: FontWeight.w500, color: Colors.blue)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],

            ),
          ),
        ),
      ),
    );
  }

  Widget emailTextField( FocusNode focusNode, TextEditingController txtFeild,String text ,bool isSecure ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: UnderLineTextField(
        focusNode: focusNode,
        txtHint: text,
        isSecure: isSecure,
        keyboardType: TextInputType.emailAddress,
//      enableBorderColor: Colors.white,
        focusBorderColor: Colors.grey,
        textColor: Colors.black,
        txtController: txtFeild,
        onTapFunc: () {
          setState(() {
            FocusScope.of(context).requestFocus(focusNode);
          });
        },
      ),
    );
  }

  Widget btnSignUp() {
    return SizedBox(
      height: 60,
      child: FloatingActionButton(
        backgroundColor: GlobalColors.firstColor,
        onPressed: () => {
          setState(() {
            ValidateFields();
          })
        },
        tooltip: 'Increment',
        child: Icon(Icons.arrow_forward),
      ),
    );
  }


  void SignUpUser(){
    var gnd = "";
//    if ( _genderValue  == Gender.male){
//      gnd = "1";
//    }else{
//      gnd = "2";
//    }
    Map<String, dynamic> body = {
//      'f_name': fnameTF.text,
//      'l_name': lnameTF.text,
      'email': emailTF.text,
      'password' : passTF.text,
      'c_password' : confirmTF.text,
      'gender': gnd,
//      'dob' : dobTF.text,
    };
    print(body);
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post, url: WebService.login,body: body,isFormData: true).then(
              (response){
            Map<String, dynamic> responseJson = json.decode(response);
            if(responseJson.containsKey('success')){

            }else{
              print(responseJson);
            }
          });

    } on FetchDataException catch(e) {
      setState(() {

      });
    }
  }

  void ValidateFields(){
    if (emailTF.text != "" && emailTF.text != null){
      if (GFunction.validateEmail(emailTF.text)){
        //SignUpUser();
        if (passTF.text != "" && passTF.text != null){
          if (confirmTF.text != "" && confirmTF.text != null){
            if (passTF.text == confirmTF.text){
              Navigator.push(context, CupertinoPageRoute(builder: (context) => PreferencesOnBoarding()));
            }else{
              Toast.show("Password and Confirm Password should be same", context, duration: Toast.LENGTH_LONG);
            }
          }else{
            Toast.show("Enter Confirm Password", context, duration: Toast.LENGTH_LONG);
          }
        }else{
          Toast.show("Enter Password", context, duration: Toast.LENGTH_LONG);
        }
      }else{
        Toast.show("Invalid Email Formate", context, duration: Toast.LENGTH_LONG);
      }
    }else{
      Toast.show("Enter Email Address", context, duration: Toast.LENGTH_LONG);
    }

  }

  Widget customRadioButton(int value, int groupedValue, String text,BuildContext context, ValueChanged _onChange) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(value: value, groupValue: groupedValue, onChanged: _onChange,activeColor: GlobalColors.firstColor,),
          Text(text,style: TextStyle(fontSize: 18),),
        ],
      ),
    );
  }



}