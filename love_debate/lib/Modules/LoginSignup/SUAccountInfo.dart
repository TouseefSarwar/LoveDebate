import 'dart:convert';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_push_notifications/Modules/Preferences/PreferencesOnBoarding.dart';
import 'package:app_push_notifications/Utils/Constants/SharedPref.dart';
import 'package:app_push_notifications/Utils/Controllers/Loader.dart';
import 'package:app_push_notifications/Utils/Globals/UserSession.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:app_push_notifications/Utils/Designables/CustomAppBar.dart';
import 'package:app_push_notifications/Utils/Globals/Fonts.dart';
import 'package:app_push_notifications/Utils/Globals/GlobalFunctions.dart';
import 'package:app_push_notifications/Utils/Designables/CustomTextFeilds.dart';
import 'package:app_push_notifications/Utils/Globals/SignUpGlobal.dart';
import '../../Utils/Constants/WebService.dart';
import '../../Utils/Controllers/ApiBaseHelper.dart';
import '../../Utils/Controllers/AppExceptions.dart';


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
  int apiCall = 0 ;

  //end


  TextEditingController emailTF = TextEditingController();
  TextEditingController passTF = TextEditingController();
  TextEditingController confirmTF = TextEditingController();

  FocusNode passFN = FocusNode();
  FocusNode confirmFN = FocusNode();
  FocusNode emailFN = FocusNode();
  String _password ="";
  bool showTooltip = false;

  SharedPref prf = SharedPref();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double _height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double _width=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppbar.setNavigation(""),
      body: (apiCall == 0)? SafeArea(
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

                      passwordTextField(passFN,passTF),

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
      ) : Center(child: Loading(),),
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


  Widget passwordTextField(FocusNode focusNode,TextEditingController txtFeild) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              PasswordTextField(txtHint: "Password",
                keyboardType: TextInputType.text,
                txtIsSecure: true,
                txtController:txtFeild ,
                onSaved: (String value){
                  _password = value;
                },
                onChanged: (String value){
                  setState(() {
                    _password = value;
                  });
                },
              ),
              (_password != '') ? FlutterPasswordStrength(password:_password, height: 4) : Container(),
            ],
          ),
          Positioned(
            right: 4,
            child: InkWell(
              onTap: (){
                setState(() {
                  showTooltip = showTooltip ? false : true;
                });
              },
              child: Container(height: 30,width: 50),
              //child: Icon(Icons.help_outline, color: Colors.black, size: 20,)
            ),
          )
        ],
      ),
    );
  }


  void SignUpUser(){
    Map<String, dynamic> body = {
      'first_name': SignUpGlobal.f_name.toString(),
      'last_name': SignUpGlobal.l_name.toString(),
      'email': emailTF.text.toString(),
      'password' : passTF.text.toString(),
      'c_password' : confirmTF.text.toString(),
      'gender': SignUpGlobal.gender.toString(),
      'dob':SignUpGlobal.dob.toString(),
      'height':SignUpGlobal.personHeight.toString(),
    };
    print(body);
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post,authorization: true, url: WebService.registerUser,body: body,isFormData: false).then(
              (response) async{

            var res = response as http.Response;
            if (res.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(res.body);
              if(responseJson.containsKey('success')){
                UserSession.authToken =  responseJson["success"]["token"] == null? "": "Bearer ${responseJson["success"]["token"]}";
                print(UserSession.authToken);
                await prf.set(UserSession.authTokenkey,UserSession.authToken);
                await prf.set(UserSession.signUp,true);
                await prf.set(UserSession.name,SignUpGlobal.f_name+" "+SignUpGlobal.l_name);
                UserSession.isSignup = await prf.getBy(UserSession.signUp);
                apiCall = 0;
                SignUpGlobal.f_name = null;
                SignUpGlobal.l_name = null;
                SignUpGlobal.email = null;
                SignUpGlobal.password= null;
                SignUpGlobal.c_password = null;
                SignUpGlobal.gender =null;
                SignUpGlobal.personHeight =null;
                SignUpGlobal.dob=null;

                GFunction.showSuccess( () {
                  Navigator.push(context, CupertinoPageRoute(fullscreenDialog: true,builder: (context) => PreferencesOnBoarding()) );
                }, context);

              }else{
                apiCall = 0;
                setState(() {});
                print("Oh no response");
              }
            }else if (res.statusCode == 401){
              apiCall = 0;
              setState(() {});
              Map<String, dynamic> err = json.decode(res.body);
              GFunction.showError(err.toString(), context);
            }else{
              apiCall = 0;
              setState(() {});
              GFunction.showError(res.reasonPhrase.toString(), context);
            }
          });
    } on FetchDataException catch(e) {
      apiCall = 0;
      setState(() {});
      GFunction.showError(e.toString(), context);
    }
  }

  void ValidateFields(){
    if (emailTF.text != "" && emailTF.text != null){
      if (GFunction.validateEmail(emailTF.text)){
        if (passTF.text != "" && passTF.text != null){
          if (confirmTF.text != "" && confirmTF.text != null){
            if (passTF.text == confirmTF.text){
//              if(SignUpGlobal.password.length >7){
                apiCall = 1;
                setState(() {
                  SignUpUser();
                });
//              }else{
//                GFunction.showError("Minimum 8 characters.", context);
//              }
            }else{
              GFunction.showError("Password and Confirm Password should be same", context);
            }
          }else{
            GFunction.showError("Enter Confirm Password", context);
          }
        }else{
          GFunction.showError("Enter Password", context);
        }
      }else{
        GFunction.showError("Invalid Email Formate", context);
      }
    }else{
      GFunction.showError("Enter Email Address", context);
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