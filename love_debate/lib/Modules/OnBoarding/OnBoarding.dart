import 'dart:convert';

import 'package:lovedebate/Models/OnBoardingModel.dart';
import 'package:lovedebate/Modules/OnBoarding/OnBoardingDialogBox/OnBoardingDialogBox.dart';
import 'package:lovedebate/Screens/TabBarcontroller.dart';
import 'package:lovedebate/Utils/Constants/WebService.dart';
import 'package:lovedebate/Utils/Controllers/ApiBaseHelper.dart';
import 'package:lovedebate/Utils/Controllers/Loader.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';
import 'package:lovedebate/Widgets/CustomButtons.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Widgets/CustomTextFeilds.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:lovedebate/Utils/Controllers/AppExceptions.dart';
import 'dart:io';


class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}
class _OnBoardingState extends State<OnBoarding> {
  //bool apiCall = false;
  int index=0;
  int apiCall = 0;
  List<Success> _Questions = List<Success>();

  double _value = 0.0;
  void _setvalue(double value) => setState(() => _value = value);

  int _questionType=0;

  FocusNode _focusNode = new FocusNode();



  @override
  void initState() {
    super.initState();
    callOnBoardingQuestions();
    apiCall=1;
  }
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
        title:  Text('OnBoarding',style:TextStyle(color: Colors.white ,fontSize: GlobalFont.navFontSize, fontFamily: 'Satisfy', fontWeight:  FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child:(apiCall==0)? Container(
          height: _height,
          width: _width,
          color: Colors.grey.withOpacity(0.1),
          child: _Questions.length > 0 ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              QuestionsContainer(_height, _width, txtEmailFocusNode, txtEmailController, context,_Questions[index].qaQuestion,_questionType,_Questions[index].qaFieldType),
              QuestionControlBar(_width),
            ],
          ) : Container(),
        ):Center(child: Loading()),
      ),
    );
  }
  Container QuestionControlBar(double _width) {
    return Container(
              height: (20/100)*_width,
              width: _width,
             // color: Colors.cyan,
              child: Row(
               // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 16,),
                 btnOnBoarding("Skip"),
                  Expanded(child: SizedBox(width: 16,)),
                  onBoardingQANo(),
                  Expanded(child: SizedBox(width: 16,)),
                  btnOnBoarding("Next"),
                  SizedBox(width: 16,),
                ],
              ),
            );
  }
  Container QuestionsContainer(double _height, double _width, FocusNode txtEmailFocusNode, TextEditingController txtEmailController, BuildContext context,String questiontext,int _questionType,String fieldtype) {
    return Container(
             // height: (50/100)*_height,
              width: _width,
              //color: Colors.blue,
              child:Card(
                elevation: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 24,),
                    Text(questiontext,style: TextStyle(fontSize: 24),),
                    SizedBox(height: 16,),
                    (fieldtype!="Slider")?Container(
                      height: 120,
                      margin: EdgeInsets.all(16),
                      child: UnderLineTextField(
                        focusNode: _focusNode,
                        txtHint: "Your State and city",
                        isSecure: false,
                       // keyboardType: TextInputType.emailAddress,
                        enableBorderColor: Colors.white,
                        focusBorderColor: Colors.white,
                        textColor: Colors.white,
                        txtController: txtEmailController,


                        onTapFunc: () {
                          setState(() {
                            if(fieldtype!="Slider"){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return OnBoardingDialogBox();
                                  }
                              );
                            }
                          });
                        },
                      ),
                    ):OnBoardingSlider(_width),
                  ],
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
      child:Center(child: Text("${index+1}/25",style: TextStyle(fontSize: 18),)),
    );
  }
  Widget btnOnBoarding(String text) {
    var localIndex = index;
    return SizedBox(
      height: 45,
      child: CustomRaisedButton(
        buttonText:text ,
        cornerRadius: 22.5,
        textColor: Colors.white,
        backgroundColor:GlobalColors.firstColor,
        borderWith: 0,
        action: (){
          if(++localIndex > 24){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TabBarControllerPage()));
          }else {
            setState(() {
              index = localIndex;
            });
          }
        },
      ),
    );
  }

  Container OnBoardingSlider(double width) {
    return Container(
      height: 75,
      width: width,
      child: Column(
        children: <Widget>[
          Slider(value: _value, onChanged: _setvalue,activeColor: GlobalColors.firstColor,),
          Text('Value: ${(_value * 100).round()}',style: TextStyle(fontSize:GlobalFont.textFontSize),),
        ],
      ),
    );
  }

  callOnBoardingQuestions() {
    Map<String, dynamic> body = {

    };
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.get, url: WebService.onboardingApi,body: body,isFormData: true).then(
              (response) {
                var data = List<Success>();
                Map<String, dynamic> responseJson = json.decode(response);
                if(responseJson.containsKey('success')){
                  responseJson['success'].forEach((v) {
                  data.add(Success.fromJson(v));
                });
                setState(() {
                  _Questions = data;
                  apiCall=0;
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
