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
import 'package:lovedebate/Widgets/CustomButtons.dart';
import 'package:lovedebate/Widgets/CustomTextFeilds.dart';
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

  Color _textcolor = Colors.white;
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
        bottom: false,
        child:DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.white
            // image: DecorationImage(image: AssetImage('images/BackGround.jpeg'), fit: BoxFit.fitHeight),
          ),
          child: Stack(
            children: <Widget>[
              ListView(
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  TopSection(_height),
                  CenterSection(_height),
                  BottomSection(_height)
                ],
              ),
//              Positioned(
//                bottom: 16,
//                child: InkWell(
//                    onTap: (){
//                      setState(() {
//                        Navigator.push(context, CupertinoPageRoute(builder: (context) => LaunchScreen()));
//                      });
//                    },
//                    child: Container(
//                       width: _width,
//                        child: Text('Signup or Create account ?',style: TextStyle(color:Colors.black,fontSize: 18,),textAlign: TextAlign.center,))),
//              ),

              Positioned(
                bottom: 16,
                child: Container(
                  width: _width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: RichText(
                          text: TextSpan(
                            text: 'Dont  Have an account ? ',
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
              ),
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
          // mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            btnContinue(),
            SizedBox(height: 16,),
            Text('Forgot Password ?',style: TextStyle(color:Colors.lightBlue,fontSize: 18,),textAlign: TextAlign.center,),

          ],
        )
    );
  }

  Container CenterSection(double _height) {
    return Container(
      height: (20/100)*_height,
      //color: Colors.blue,
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          emailTextField(txtEmailFocusNode,txtEmailController,'Email',false),
          SizedBox(height: 8,),
          emailTextField(txtPasswordFocusNode, txtPasswordController, "Password",true),
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
          AppBarPic(),
          SizedBox(height: 8,),
          Text('Love Debate',style: TextStyle(fontSize: 38,fontWeight: FontWeight.bold,color:Colors.black),),
          //  Text('Debate',style: TextStyle(fontSize: 45,color:Colors.black),),

          SizedBox(height: 8,)

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
  Container AppBarPic() {
    return Container(
        width: 120,
        height:120,
        margin: EdgeInsets.all(8),
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/BackGround.jpeg",)
            )
        ));
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
          setState(() {

            if (txtEmailController.text == "" || txtEmailController.text==null){
              Toast.show("Empty Email", context, duration: Toast.LENGTH_LONG);
            }else if (txtPasswordController.text == "" || txtPasswordController.text==null){
              Toast.show("Empty Password", context, duration: Toast.LENGTH_LONG);
            }else{

              //LoginUser();
              Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));

            }
          });
//
        },
      ),
    );
  }


  void LoginUser(){
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
                var loginresponse = LoginModel.fromJson(responseJson["success"]);
                print(loginresponse.user.email);
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


}


class QaOptions {
  String text;
  String value;

  QaOptions({this.text, this.value});

  QaOptions.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['value'] = this.value;
    return data;
  }
}