import 'dart:convert';

import 'package:lovedebate/Utils/Constants/WebService.dart';
import 'package:lovedebate/Utils/Controllers/ApiBaseHelper.dart';
import 'package:lovedebate/Utils/Controllers/AppExceptions.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Modules/LoginSignup/SignUp.dart';
import 'package:lovedebate/Screens/TabBarcontroller.dart';
import 'package:lovedebate/Widgets/CustomButtons.dart';
import 'package:lovedebate/Widgets/CustomTextFeilds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import '../../Utils/HexColor.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  Color _textcolor=Colors.white;
  TextEditingController txtEmailController = TextEditingController();
  TextEditingController txtPasswordController = TextEditingController();
  FocusNode txtEmailFocusNode = FocusNode();
  FocusNode txtPasswordFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    double _height=MediaQuery.of(context).size.height;
    double _width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        top: false,
        child:DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/BackGround.jpeg'), fit: BoxFit.fill),
          ),
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  TopSection(_height),
                  CenterSection(_height),
                  BottomSection(_height)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container BottomSection(double _height) {
    return Container(
        height: (50/100)*_height,
        // color: Colors.greenAccent,
        margin: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            btnContinue(),
            SizedBox(height: 16,),
            InkWell(
                onTap: (){
                  setState(() {
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => LaunchScreen()));

                  });
                },
                child: Text('Signup or Create account',style: TextStyle(color: _textcolor,fontSize: 18),)),
          ],
        )
    );
  }

  Container CenterSection(double _height) {
    return Container(
      height: (15/100)*_height,
      //color: Colors.blue,
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          emailTextField(txtEmailFocusNode,txtEmailController,'Email'),
          SizedBox(height: 9,),
          emailTextField(txtPasswordFocusNode, txtPasswordController, "Password"),
          SizedBox(height: 8,),

        ],
      ),
    );
  }

  Container TopSection(double _height) {
    return Container(
      height: (40/100)*_height,
      //color: Colors.greenAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text('Love',style: TextStyle(fontSize: 45,color: _textcolor),),
          Text('Debate',style: TextStyle(fontSize: 45,color: _textcolor),),

          SizedBox(height: 8,)

        ],
      ),
    );
  }

  Widget emailTextField( FocusNode focusNode, TextEditingController txtFeild,String text) {
    return UnderLineTextField(
      focusNode: focusNode,
      txtHint: text,
      isSecure: false,
      keyboardType: TextInputType.emailAddress,
      enableBorderColor: Colors.white,
      focusBorderColor: Colors.white,
      textColor: Colors.white,
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
        cornerRadius: 22.5,
        textColor: Colors.white,
        backgroundColor:GlobalColors.firstColor,
        borderWith: 0,
        action: (){
          setState(() {

            Map<String, dynamic> body = {
              'email': txtEmailController.text,
              'password' : txtPasswordController.text,
            };
            try {
              ApiBaseHelper().fetchService(method: HttpMethod.post, url: WebService.login,body: body,isFormData: true).then(
                  (response) => {
                   if (response is String){

                   }
              });

            } on FetchDataException catch(e) {
              setState(() {

              });
            }


          });
//
        },
      ),
    );
  }

}