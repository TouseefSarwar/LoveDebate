import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:lovedebate/Utils/Designables/Toast.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/GlobalFunctions.dart';
import 'package:lovedebate/Widgets/CustomButtons.dart';
import 'package:lovedebate/Widgets/CustomTextFeilds.dart';

import '../../Utils/Constants/WebService.dart';
import '../../Utils/Controllers/ApiBaseHelper.dart';
import '../../Utils/Controllers/AppExceptions.dart';
import '../OnBoarding/OnBoarding.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  TextEditingController nameTF = TextEditingController();
  TextEditingController passTF = TextEditingController();
  TextEditingController confirmTF = TextEditingController();
  TextEditingController emailTF = TextEditingController();
  TextEditingController dobTF = TextEditingController();

  FocusNode nameFN = FocusNode();
  FocusNode passFN = FocusNode();
  FocusNode confirmFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode dobFN = FocusNode();

  TextEditingController txtOpenTime = TextEditingController();


  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    localizations.formatTimeOfDay(picked, alwaysUse24HourFormat: true);
    setState(() {

      dobTF.text = localizations.formatTimeOfDay(picked, alwaysUse24HourFormat: true);
//      if(no=='open'){
//        txtOpenTime.text = localizations.formatTimeOfDay(picked, alwaysUse24HourFormat: true);}
//      else{
//        txtCloseTime.text = localizations.formatTimeOfDay(picked, alwaysUse24HourFormat: true);
//      }
    });
  }

  Widget _selectTimeIos(){
    return CupertinoDatePicker(
      initialDateTime: DateTime.now(),
      onDateTimeChanged: (DateTime date){
        //txtCloseTime.text=TimeOfDay.now().toString();
      },
      use24hFormat: true,
    );
  }

  @override
  Widget build(BuildContext context) {

    double _height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double _width=MediaQuery.of(context).size.width;
    double _itemheight=(10/100)*_height;

    return Scaffold(
      appBar: GradientAppBar(
        centerTitle: true,
        title: Text('SignUp',style:TextStyle(color: Colors.white ,fontSize: 30, fontFamily: 'Satisfy', fontWeight:  FontWeight.bold)),
        backgroundColorStart: GlobalColors.firstColor,
        backgroundColorEnd: GlobalColors.secondColor,
      ),
      body: SafeArea(
        top: true,
        child: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              emailTextField(nameFN,nameTF,'Name',false),
              SizedBox(height: 16,),
              emailTextField(passFN,passTF,'Password', true),
              SizedBox(height: 16,),
              emailTextField(confirmFN,confirmTF,'Confirm Password',true),
              SizedBox(height: 16,),
              emailTextField(emailFN,emailTF,'Email Address',false),
              SizedBox(height: 16,),
              dateTime(dobFN,dobTF,'Date of Birth'),
              SizedBox(height: 16,),
              btnSignUp(),


            ],

          ),
        ),
      ),
    );
  }
  Widget emailTextField( FocusNode focusNode, TextEditingController txtFeild,String text ,bool isSecure ) {
    return UnderLineTextField(
      focusNode: focusNode,
      txtHint: text,
      isSecure: isSecure,
      keyboardType: TextInputType.emailAddress,
      enableBorderColor: Colors.white,
      focusBorderColor: Colors.grey,
      textColor: Colors.black,
      txtController: txtFeild,
      onTapFunc: () {
        setState(() {
          FocusScope.of(context).requestFocus(focusNode);
        });
      },
    );
  }
  Widget dateTime( FocusNode focusNode, TextEditingController txtFeild,String text) {
    return UnderLineTextField(
      focusNode: focusNode,
      txtHint: text,
      isSecure: false,
      keyboardType: TextInputType.emailAddress,
      enableBorderColor: Colors.white,
      focusBorderColor: Colors.white,
      textColor: Colors.black,
      txtController: txtFeild,
      onTapFunc: () {
        setState(() {
          if (Theme.of(context).platform == TargetPlatform.iOS){
            showModalBottomSheet(
                context: context,
                builder: (BuildContext builder) {
                  return Container(
                      height:
                      MediaQuery.of(context).copyWith().size.height / 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 50,
                            color: Theme.of(context).primaryColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: SizedBox(
                                    height: 35,
                                    width: 85,
                                    child: RaisedButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      color: Colors.white,
                                      child: Text("Cancel", style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0)
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: SizedBox(
                                    height: 35,
                                    width: 85,
                                    child: RaisedButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      color: Colors.blueAccent,
                                      child: Text("Done", style: TextStyle(fontSize: 16, color: Colors.white),),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0)
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(child: _selectTimeIos())
                        ],
                      )
                  );
                });
          }else{
            _selectTime(context);
          }
        });
      },
    );
  }
  Widget btnSignUp() {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: CustomRaisedButton(
        buttonText: 'Sign Up',
        cornerRadius: 5,
        textColor: Colors.white,
        backgroundColor:GlobalColors.firstColor,
        borderWith: 0,
        action: (){
          setState(() {
            ValidateFields();
          });
        },
      ),
    );
  }


  void SignUpUser(){
    Map<String, dynamic> body = {
      'name': nameTF.text,
      'email': emailTF.text,
      'password' : passTF.text,
      'c_password' : passTF.text,
      'gender': emailTF.text,
      'dob' : passTF.text,
    };
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post, url: WebService.login,body: body,isFormData: true).then(
              (response){
            Map<String, dynamic> responseJson = json.decode(response);
            if(responseJson.containsKey('success')){
              print("hereee");
//                responseJson['success'].forEach((v) {
//                  data.add(Success.fromJson(v));
//                });
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
    print("This"+nameTF.text+"is");
    if (nameTF.text != "" && nameTF.text!=null){
      if (passTF.text != "" && passTF.text != null){
        if (confirmTF.text != "" && confirmTF.text != null){
          if (passTF.text == confirmTF.text){
            if (emailTF.text != "" && emailTF.text != null){
              if (GFunction.validateEmail(emailTF.text)){
//                if (dobTF.text != "" && dobTF.text != null){
//                  print("Your validations are succeeded");
//
//                }else{
//                  Toast.show("Select DOB", context, duration: Toast.LENGTH_LONG);
//                }
                Navigator.push(context, CupertinoPageRoute(builder: (context) => OnBoarding()));
              }else{
                Toast.show("Invalid Email Formate", context, duration: Toast.LENGTH_LONG);
              }
            }else{
              Toast.show("Enter Email Address", context, duration: Toast.LENGTH_LONG);
            }
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
      Toast.show("Enter Name", context, duration: Toast.LENGTH_LONG);
    }
  }

}
