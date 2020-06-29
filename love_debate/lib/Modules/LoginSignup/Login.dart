import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lovedebate/Models/LoginModel.dart';

import 'package:lovedebate/Utils/Constants/WebService.dart';
import 'package:lovedebate/Utils/Controllers/ApiBaseHelper.dart';
import 'package:lovedebate/Utils/Controllers/AppExceptions.dart';
import 'package:lovedebate/Utils/Designables/Toast.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Modules/LoginSignup/SignUp.dart';
import 'package:lovedebate/Screens/TabBarcontroller.dart';
import 'package:lovedebate/Utils/Designables/CustomButtons.dart';
import 'package:lovedebate/Utils/Designables/CustomTextFeilds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import '../../Screens/TabBarcontroller.dart';
import '../../Utils/Globals/Colors.dart';
import '../../Utils/Globals/Fonts.dart';
import '../../Utils/HexColor.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController txtEmailController = TextEditingController();
  TextEditingController txtPasswordController = TextEditingController();
  FocusNode txtEmailFocusNode = FocusNode();
  FocusNode txtPasswordFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    double _height=MediaQuery.of(context).size.height - MediaQuery.of(context).padding.vertical;
    double _width=MediaQuery.of(context).size.width;
    double imageWidth = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child:SingleChildScrollView(
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
          Text('Forgot Password ?',style: TextStyle(color:Colors.lightBlue,fontSize: 18,),textAlign: TextAlign.center,),
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
    };

    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post, url: WebService.login,body: body,isFormData: true).then(
              (response){
            var res = response as http.Response;
            if (res.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(res.body);
              if(responseJson.containsKey('success')){
                var loginResponse = LoginModel.fromJson(responseJson["success"]);
                print(loginResponse.user.email);
              }else{
                print("Oh no response");
              }

            }else if (res.statusCode == 401){
              Toast.show(res.reasonPhrase.toString(), context, duration: Toast.LENGTH_LONG);
            }else{
              Toast.show(res.reasonPhrase.toString(), context, duration: Toast.LENGTH_LONG);
            }
          });

    } on FetchDataException catch(e) {
      setState(() {

      });
    }
  }


  //validate functions there
  validateFields(){

    if (txtEmailController.text == "" || txtEmailController.text==null){
      Toast.show("Empty Email", context, duration: Toast.LENGTH_LONG);
    }else if (txtPasswordController.text == "" || txtPasswordController.text==null){
      Toast.show("Empty Password", context, duration: Toast.LENGTH_LONG);
    }else{

      //LoginUser();
      Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));

    }
  }

}

