import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:lovedebate/Models/OnBoardingModel.dart';
import 'package:lovedebate/Modules/OnBoarding/OnBoardingDialogBox/OnBoardingDialogBox.dart';
import 'package:lovedebate/Utils/Constants/WebService.dart';
import 'package:lovedebate/Utils/Controllers/ApiBaseHelper.dart';
import 'package:lovedebate/Utils/Controllers/Loader.dart';
import 'package:lovedebate/Utils/Designables/Toast.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';
import 'package:lovedebate/Utils/Controllers/AppExceptions.dart';
import 'package:lovedebate/Widgets/CustomTextFeilds.dart';

class PreferencesOnBoarding extends StatefulWidget {
  @override
  _PreferencesOnBoardingState createState() => _PreferencesOnBoardingState();
}

class _PreferencesOnBoardingState extends State<PreferencesOnBoarding> {


  int index=0;
  int apiCall = 0;
  List<Success> _Questions = List<Success>();
  List<String> answers = List<String>();
  String answer=" ";

  double _value = 0.0;
  void _setvalue(double value) => setState(() => _value = value);

  int _questionType=0;
  FocusNode _focusNode = new FocusNode();

  TextEditingController txtAnswerController = TextEditingController();

  FocusNode txtEmailFocusNode = FocusNode();

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
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: GlobalColors.firstColor,
        backgroundColorEnd: GlobalColors.secondColor,
        title:  Text('OnBoarding',style:TextStyle(color: Colors.white ,fontSize: GlobalFont.navFontSize, fontFamily: 'Satisfy', fontWeight:  FontWeight.bold)),
        centerTitle: true,
      ),body: SafeArea(
      child: (apiCall==0)?ListView.separated(
//        separatorBuilder: (BuildContext context, int index) => Padding(
//          padding: const EdgeInsets.only(left: 8,right: 8,top: 12,bottom: 12),
//          child: Container(height: 1,width: _width,color:GlobalColors.firstColor,),
//        ),
        separatorBuilder: (BuildContext context, int index) => Divider(thickness:2,),
        itemCount: _Questions.length,
        itemBuilder: (BuildContext context,int index){
         return QuestionsContainer(_height, _width, txtEmailFocusNode, txtAnswerController, context,_Questions[index].qaQuestion,_questionType,_Questions[index].qaFieldType,_Questions[index],);
         },
      ):Center(child: Loading(),),
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
            if (response.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(response.body);
              if(responseJson.containsKey('success')) {
                responseJson['success'].forEach((v) {
                  data.add(Success.fromJson(v));

                });
                setState(() {
                  _Questions=data;
                  apiCall=0;
                });
              } else{
                print("Oh no response");
              }

            }else if (response.statusCode == 401){
              Toast.show(response.reasonPhrase.toString(), context, duration: Toast.LENGTH_LONG);
            }else{
              Toast.show(response.reasonPhrase.toString(), context, duration: Toast.LENGTH_LONG);
            }
          });

    } on FetchDataException catch(e) {
      setState(() {

      });
    }
  }
  Container QuestionsContainer(double _height, double _width, FocusNode txtEmailFocusNode, TextEditingController txtAnswerController, BuildContext context,String questiontext,int _questionType,String fieldtype,Success QuestionObj,) {
    return Container(
      // height: (50/100)*_height,
      width: _width,
      //color: Colors.blue,
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: _width,
            margin: EdgeInsets.all(24),
              child: Text(questiontext,style: TextStyle(fontSize: GlobalFont.textFontSize,),textAlign: TextAlign.justify,)),
          (fieldtype!="Slider")?Container(
           // height: 120,
            margin: EdgeInsets.all(4),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  (fieldtype=="Dropdown"||fieldtype=="Checkbox")? AnswerContainer(_width,"Enter Required value",QuestionObj):
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16),
                    child: NumberTextFeildContainer(txtAnswerController, fieldtype, context, QuestionObj),
                  ),
                ],
              ),
            ),
          ):OnBoardingSlider(_width),
        ],
      ) ,
    );
  }
  UnderLineTextField NumberTextFeildContainer(TextEditingController txtAnswerController, String fieldtype, BuildContext context, Success QuestionObj) {
    return UnderLineTextField(
      focusNode: _focusNode,
      txtHint: "Your State and city",
      isSecure: false,
      keyboardType: TextInputType.emailAddress,
      enableBorderColor: Colors.white,
      focusBorderColor: Colors.white,
      textColor: Colors.grey,
      txtController: txtAnswerController,
    );
  }

  InkWell AnswerContainer(double _width,String answerText,Success QuestionObj,) {
    return InkWell(
      onTap: (){
        setState(() {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return OnBoardingDialogBox(Question: QuestionObj,txtAnswerController: txtAnswerController,);
              }
          ).then((value){
            setState(() {
              answer=value;
            });

          });

        });
      }, child:
    //   Row(
    //      children: <Widget>[
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text((answer==" ")?answerText:answer,style: TextStyle(fontSize: GlobalFont.textFontSize),  textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,maxLines: 2,),
        ),
        SizedBox(height: 8,),
        Container(height: 2,width:_width-50 ,color:Colors.grey,),
      ],
    ),
      //       SizedBox(width:8,),
      //       ],
      //       ),
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
}

