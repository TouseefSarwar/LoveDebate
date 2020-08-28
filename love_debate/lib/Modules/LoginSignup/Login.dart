import 'dart:convert';
import 'package:app_push_notifications/Modules/ForgotPassword/forgotPassword.dart';
import 'package:app_push_notifications/Modules/Preferences/PreferencesOnBoarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:app_push_notifications/Models/LoginModel.dart';
import 'package:app_push_notifications/Utils/Constants/SharedPref.dart';
import 'package:app_push_notifications/Utils/Constants/WebService.dart';
import 'package:app_push_notifications/Utils/Controllers/ApiBaseHelper.dart';
import 'package:app_push_notifications/Utils/Controllers/AppExceptions.dart';
import 'package:app_push_notifications/Utils/Controllers/Loader.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:app_push_notifications/Modules/LoginSignup/SignUp.dart';
import 'package:app_push_notifications/Utils/Designables/CustomButtons.dart';
import 'package:app_push_notifications/Utils/Designables/CustomTextFeilds.dart';
import 'package:flutter/material.dart';
import 'package:app_push_notifications/Utils/Globals/GlobalFunctions.dart';
import 'package:app_push_notifications/Utils/Globals/UserSession.dart';
import '../../Utils/Globals/Colors.dart';
import '../../Utils/Globals/Fonts.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  int apiCall = 0;
  SharedPref prf = SharedPref();

  TextEditingController txtEmailController = TextEditingController();
  TextEditingController txtPasswordController = TextEditingController();
  FocusNode txtEmailFocusNode = FocusNode();
  FocusNode txtPasswordFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    double _height=MediaQuery.of(context).size.height - MediaQuery.of(context).padding.vertical;
    double _width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: SingleChildScrollView(
          child: Container(
            height:  _height,
            width: _width,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    topSection(_height),
                    centerSection(_height),
                    bottomSection(_height,_width)
                  ],
                ),
                apiCall == 1 ? Center(child: Loading()) : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container bottomSection(double _height,double _width) {
    return Container(
        height: (30/100)*_height,
        child: Column(
          children: <Widget>[
            Container(
              height: (25/100)*_height,
              width: _width,
              // color: Colors.lightBlue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        // ignore: deprecated_member_use
                        style: Theme.of(context).textTheme.body1.copyWith(fontSize: GlobalFont.textFontSize,),
                        children: <TextSpan>[
                          TextSpan(text: 'SignUp', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                        ],
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => SignUp()));
                      });
                    },
                  ),
                ],
              ),
            ),

          ],
        )
    );
  }

  Container centerSection(double _height) {
    return Container(
      height: (40/100)*_height,
      //color: Colors.blue,
      margin: EdgeInsets.only(left: 16,right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          emailTextField(txtEmailFocusNode,txtEmailController,'Email',false),
          emailTextField(txtPasswordFocusNode, txtPasswordController, "Password",true),
          SizedBox(height: 16,),
          btnContinue(),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => ForgotPasswoprd())),
              child: Text('Forgot Password ?',style: TextStyle(color:Colors.lightBlue,fontSize: 18,),textAlign: TextAlign.center,)),
        ],
      ),
    );
  }

  Container topSection(double _height) {
    return Container(
      height: (30/100)*_height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Center(
            child: Container(
                height: 180,
                width: 180,
                child: Image.asset("images/LoveDebatelogo.png")
            ),
          )

        ],
      ),
    );
  }

  Widget emailTextField( FocusNode focusNode, TextEditingController txtFeild,String text, bool isSecure ) {
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

  Widget btnContinue() {
    return SizedBox(

      height: 45,
      width: double.infinity,
      child: CustomRaisedButton(
        buttonText: 'Login',
        cornerRadius: 5,
        textColor: Colors.white,
        backgroundColor:GlobalColors.firstColor,
        borderWith: 0,
        action: (){
          validateFields();
        },
      ),
    );
  }

  loginUser(){

    Map<String, dynamic> body = {
      'email': txtEmailController.text,
      'password' : txtPasswordController.text,
      "device_token": UserSession.fcmToken,
    };

    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post,authorization: false, url: WebService.login,body: body,isFormData: false).then(
              (response) async {
            var res = response as http.Response;
            if (res.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(res.body);
              print('Responseee======>${responseJson["success"]['user']}');
              if(responseJson.containsKey('success')){
                if( responseJson['success']['user']['onboading_status'].toString() == '0'){
                  UserSession.authToken =  responseJson["success"]["token"] == null? "": "Bearer ${responseJson["success"]["token"]}";
                  // await prf.set(UserSession.authTokenkey,UserSession.authToken);
                  await prf.saveSocketId(socketId: responseJson['success']['user']['soc_id']);
                  await prf.set(UserSession.signUp,true);
                  await prf.set(UserSession.name,responseJson['success']['user']['name'].toString());
                  UserSession.isSignup = await prf.getBy(UserSession.signUp);
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => PreferencesOnBoarding()));

                }else{

                  var loginResponse = LoginModel.fromJson(responseJson["success"]);
                  UserSession.authToken =  loginResponse.token == null? "": "Bearer ${loginResponse.token}";
                  await prf.saveSocketId(socketId: loginResponse.user.socketId);
                  await prf.set(UserSession.authTokenkey,UserSession.authToken);
                  await prf.set(UserSession.name,loginResponse.user.name);
                  await prf.set(UserSession.signUp,false);
                  UserSession.isSignup = await prf.getBy(UserSession.signUp);
                  await prf.remove(UserSession.answers);
                  await prf.remove(UserSession.question);
                  apiCall =0;
                  Navigator.of(context).pushReplacementNamed('/TabBarControllerPage');

                }

              }else{
                apiCall =0;
                setState(() {});
              }
            }else if (res.statusCode == 401){
              apiCall = 0;
              setState(() {});
              GFunction.showError(jsonDecode(res.body)["error"].toString(), context);
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

  //validate functions there
  validateFields(){

    if (txtEmailController.text == "" || txtEmailController.text==null){
      GFunction.showError("Enter Email Address", context);
    }else if (txtPasswordController.text == "" || txtPasswordController.text==null){
      GFunction.showError("Enter Password", context);
    }else{
      apiCall = 1;
      setState(() {
        loginUser();
      });


//      Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));

    }
  }

}

