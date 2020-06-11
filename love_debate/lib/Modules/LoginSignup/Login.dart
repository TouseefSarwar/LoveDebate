import 'dart:convert';

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

  @override
  Widget build(BuildContext context) {
    double _height=MediaQuery.of(context).size.height;
    double _width=MediaQuery.of(context).size.width;
    TextEditingController txtEmailController = TextEditingController();
    FocusNode txtEmailFocusNode = FocusNode();
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
                  CenterSection(_height, txtEmailFocusNode, txtEmailController),
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

  Container CenterSection(double _height, FocusNode txtEmailFocusNode, TextEditingController txtEmailController) {
    return Container(
      height: (15/100)*_height,
      //color: Colors.blue,
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          emailTextField(txtEmailFocusNode,txtEmailController,'Email'),
          SizedBox(height: 9,),
          emailTextField(txtEmailFocusNode,txtEmailController,'Password'),
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

  Widget emailTextField( FocusNode txtEmailFocusNode, TextEditingController txtEmailController,String text) {
    return UnderLineTextField(
      focusNode: txtEmailFocusNode,
      txtHint: text,
      isSecure: false,
      keyboardType: TextInputType.emailAddress,
      enableBorderColor: Colors.white,
      focusBorderColor: Colors.white,
      textColor: Colors.white,
      txtController: txtEmailController,
      onTapFunc: () {
        setState(() {
          FocusScope.of(context).requestFocus(txtEmailFocusNode);
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

            String jsonString = '{"success" :  {"array": [1,2,3]}}';
            Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
            if(jsonResponse.containsKey('success')){
              print('Success');
            }else{
              print('error');
            }

//            Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
          });
//
        },
      ),
    );
  }

}
