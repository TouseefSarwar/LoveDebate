import 'dart:convert';

import 'package:lovedebate/Models/OnBoardingModel.dart';
import 'package:lovedebate/Utils/Constants/WebService.dart';
import 'package:lovedebate/Utils/Controllers/ApiBaseHelper.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';
import 'package:lovedebate/Widgets/CustomButtons.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Widgets/CustomTextFeilds.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:lovedebate/Utils/Controllers/AppExceptions.dart';
import 'dart:io';


int index=0;

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  //bool apiCall = false;

  @override
  void initState() {

    callOnBoardingQuestions();
  }
  List<Success> _Questions = List<Success>();

  @override
  Widget build(BuildContext context) {

    double _height=(MediaQuery.of(context).size.height)-AppBar().preferredSize.height;
    double _width=MediaQuery.of(context).size.width;
    //MediaQuery.of(context).padding.vertical

    TextEditingController txtEmailController = TextEditingController();
    FocusNode txtEmailFocusNode = FocusNode();

    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: GlobalColors.firstColor,
        backgroundColorEnd: GlobalColors.secondColor,
        title:  Text('OnBaording',style:TextStyle(color: Colors.white ,fontSize: GlobalFont.navFontSize, fontFamily: 'Satisfy', fontWeight:  FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: _height,
          width: _width,
          color: Colors.grey.withOpacity(0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              QuestionsContainer(_height, _width, txtEmailFocusNode, txtEmailController, context,_Questions[index].qaQuestion),
              QuestionControlBar(_width,index),
            ],
          ),
        ),
      ),
    );
  }

  Container QuestionControlBar(double _width,int index) {
    return Container(
              height: (20/100)*_width,
              width: _width,
             // color: Colors.cyan,
              child: Row(
               // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 16,),
                 btnOnBoarding("Skip",index),
                  Expanded(child: SizedBox(width: 16,)),
                  onBoardingQANo(),
                  Expanded(child: SizedBox(width: 16,)),
                  btnOnBoarding("Next",index),
                  SizedBox(width: 16,),
                ],
              ),
            );
  }

  Container QuestionsContainer(double _height, double _width, FocusNode txtEmailFocusNode, TextEditingController txtEmailController, BuildContext context,String questiontext) {
    return Container(
              height: (50/100)*_height,
              width: _width,
              //color: Colors.blue,
              child:Card(
                elevation: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                     // SizedBox(height: 16,),
                      Text(questiontext,style: TextStyle(fontSize: 24),),
                      //SizedBox(height: 16,),
                      Container(
                        height: 50,
                        margin: EdgeInsets.all(16),
                        child: UnderLineTextField(
                          focusNode: txtEmailFocusNode,
                          txtHint: "Your Height",
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
                        ),
                      ),
                    ],
                  ),
                ),
              ) ,
            );
  }

  Container onBoardingQANo() {
    return Container(
      height: 45,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.all(Radius.circular(22.5))
      ),
      child:Center(child: Text("$index/25",style: TextStyle(fontSize: 18),)),
    );
  }
  Widget btnOnBoarding(String text,index) {
    return SizedBox(
      height: 45,
      //width: double.infinity,
      child: CustomRaisedButton(
        buttonText:text ,
        cornerRadius: 22.5,
        textColor: Colors.white,
        backgroundColor:GlobalColors.firstColor,
        borderWith: 0,
        action: (){
          setState(() {
   //         Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
            index=index+1;
          });
//
        },
      ),
    );
  }

  callOnBoardingQuestions() {
    Map<String, dynamic> body = {

    };
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.get, url: WebService.onboardingApi,body: body,isFormData: true).then(
              (response) {
                Map<String, dynamic> responseJson = json.decode(response);
                if(responseJson.containsKey('success')){

                  responseJson['success'].forEach((v) {
                  _Questions.add(Success.fromJson(v));
                });

               // print(_Questions.first);

                }else{
                  print("response['error'] ");
                }
          });

    } on FetchDataException catch(e) {
      setState(() {

      });
    }
  }
}
