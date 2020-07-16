import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Models/AnswersModel.dart';
import 'package:lovedebate/Models/OnBoardingModel.dart';
import 'package:lovedebate/Modules/Preferences/PreferencesModel/CheckBoxDataModel.dart';
import 'package:lovedebate/Utils/Constants/SharedPref.dart';
import 'package:lovedebate/Utils/Constants/WebService.dart';
import 'package:lovedebate/Utils/Controllers/ApiBaseHelper.dart';
import 'package:lovedebate/Utils/Controllers/AppExceptions.dart';
import 'package:lovedebate/Utils/Designables/Toast.dart';
import 'package:lovedebate/Utils/Globals/AnswersGlobals.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';
import 'package:lovedebate/Utils/Designables/CustomButtons.dart';
import 'package:lovedebate/Utils/Globals/GlobalFunctions.dart';
import 'package:lovedebate/Utils/Globals/SignUpGlobal.dart';
import 'package:lovedebate/Utils/Globals/UserSession.dart';


class OnBoardingDialogBox extends StatefulWidget {

  Success Question;
  List<CheckBoxDataModel> questionsCheckBox;
  OnBoardingDialogBox({this.Question,this.questionsCheckBox});
  @override
  _OnBoardingDialogBoxState createState() => _OnBoardingDialogBoxState();
}

class _OnBoardingDialogBoxState extends State<OnBoardingDialogBox> {
  SharedPref prf = SharedPref();

  @override
  void dispose() {
    super.dispose();
    this.dispose();
  }

  @override
  void initState() {
    super.initState();

//    print(AnswersGlobal.questionIndex);
//    print(widget.questionsCheckBox);
    if (widget.Question.qaAns != null){
      print("Hereee");
    }
    if (widget.Question.qaAns != null && widget.Question.qaAns != ""){
      ///If you want to send
//      print(widget.Question.qaAns);
//      List<String> qv = widget.Question.qaAns.split(',');
//      for(int i=0; i<widget.questionsCheckBox.length ; i++){
//        for (int j=0; j<qv.length;j++){
//          if (qv[j] == widget.questionsCheckBox[i].value){
//            widget.questionsCheckBox[i].checkvalue = true;
//            break;
//          }
//        }
//      }
//      List<String> qv = widget.Question.qaAns.split(',');
      for(int i=0; i<widget.questionsCheckBox.length ; i++){
        for (int j=0; j<widget.Question.qaAns.length;j++){
          if (widget.Question.qaAns[j] == widget.questionsCheckBox[i].value){
            widget.questionsCheckBox[i].checkvalue = true;
            break;
          }
        }
      }
    }


  }

  @override
  Widget build(BuildContext context) {

    var totalDialogWidth = (MediaQuery.of(context).size.width - 20)/2.2;
    var width=MediaQuery.of(context).size.width;


    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(22.5))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // OnBoardingSlider(width),
          // OnBoardingCheckBox(),
          OnBoardingDropDownList(totalDialogWidth,width,widget.Question ,widget.questionsCheckBox),

        ],
      ),
    );
  }
  Container OnBoardingDropDownList(double totalDialogWidth ,double width,Success Question,List<CheckBoxDataModel> questionsCheckBox) {
    return Container(
      //height: totalDialogWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 16,),
          Text("Select the Option",style: TextStyle(fontSize: GlobalFont.textFontSize),),
          SizedBox(height: 16,),
          Container(
            height:((widget.questionsCheckBox.length)<7)?((widget.questionsCheckBox.length).toDouble())*60:(7*60).toDouble(),
            //height: (((questionsCheckBox.length)+1).toDouble())*60,
            child: ListView.builder(
//              physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: (widget.questionsCheckBox.length),
                itemBuilder: (BuildContext context,int index,){
//                  String itm = opt.myKey[index].text.toString();
//                  return OnBoardingCheckBox(widget.questionsCheckBox[index].checkboxText,totalDialogWidth,widget.questionsCheckBox,index,widget.questionsCheckBox.length);
                  return OnBoardingCheckBox(widget.questionsCheckBox,index);
                }),
          ),
          Container(
            //height: 100,
            width: width,
            //color: Colors.blue,
            margin: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child: OnBoardingDialogBoxBtn("Cancel",Colors.grey,Colors.black)),
                SizedBox(width: 16,),
                Expanded(child: OnBoardingDialogBoxBtn("Done",GlobalColors.firstColor,Colors.white)),
              ],
            ),
          )
        ],
      ),
    );
  }
  Container OnBoardingCheckBox(List<CheckBoxDataModel> checkList,int index,) {
    return Container(
      height: 60,
      // color: Colors.blue,
      margin: EdgeInsets.only(left: 8),
      child: Row(
        children: <Widget>[
          //SizedBox(width: 16,),
          new Checkbox(
            value: checkList[index].checkvalue,

            onChanged: (checkBoxValue){
              setState(() {
//                print(widget.Question.qaName);
                if (widget.Question.qaFieldType == "Dropdown"){
                  if(checkList[index].checkvalue==false){
                    for (int i =0; i<widget.questionsCheckBox.length; i++){
                      if(i == index) {
                        checkList[i].checkvalue=true;
                      }else{
                        checkList[i].checkvalue=false;
                      }
                    }
                  }else{
                    checkList[index].checkvalue=false;
                  }
                }else if (widget.Question.qaFieldType == "Checkbox"){
                  if(checkList[index].checkvalue==false) {
                    checkList[index].checkvalue = true;
                  }else {
                    checkList[index].checkvalue = false;
                  }
                }

              });
            },
            checkColor: Colors.white,
            activeColor: GlobalColors.firstColor,),
          SizedBox(width: 8,),
          Expanded(
            child: Container(
                child: Text((checkList[index].checkboxText) ,style: TextStyle(fontSize: GlobalFont.textFontSize),textAlign: TextAlign.left,overflow: TextOverflow.ellipsis,maxLines: 5,)),
          )
        ],
      ),
    );
  }

  Widget OnBoardingDialogBoxBtn(String text,Color color,Color textColor) {
    return SizedBox(
      height: 45,
      //width: width,
      child: CustomRaisedButton(
        buttonText: text,
        cornerRadius: 22.5,
        textColor: textColor,
        backgroundColor:color,
        borderWith: 0,
        action: (){
          setState(() {
            String selectedResults="";
            widget.questionsCheckBox.forEach((f){
              if(f.checkvalue==true){
                selectedResults=f.value+">"+ selectedResults;
              }
            });
            List<String> val = selectedResults.split(">");
            val.removeLast();
            if(text=="Done"){
              if (widget.Question.qaFieldType == "Checkbox"){
                AnswersGlobal.answers.removeWhere((element){
                  if (element.qId== widget.Question.qaId){
                    print("deleted");
                    return true;
                  } else{
                    print("not found");
                    return false;
                  }
                });
                AnswersModel v = AnswersModel(qId: widget.Question.qaId,qSlug: widget.Question.qaSlug, answers: val);
                if (UserSession.isSignup){
                  AnswersGlobal.answers.add(v);
                  AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns = val;
                }else{
                  print("no signup");
                  List<AnswersModel> lst = List<AnswersModel>();
                  lst.add(v);
                  AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns = val;
                  saveSingleAnswers(lst, val);
                }
//                AnswersGlobal.answers.add(v);
              }else{
                AnswersGlobal.answers.removeWhere((element){
                  if (element.qId== widget.Question.qaId){
                    print("deleted");
                    return true;
                  } else{
                    print("not found");
                    return false;
                  }
                });
                AnswersModel v = AnswersModel(qId: widget.Question.qaId,qSlug: widget.Question.qaSlug, answers: val.first);
                  if (UserSession.isSignup){
                    AnswersGlobal.answers.add(v);
                    AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns = val;
                  }else{
                    print("no signup");
                    List<AnswersModel> lst = List<AnswersModel>();
                    lst.add(v);
                    AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns = val;
                    saveSingleAnswers(lst, val);
                  }

              }

              ///Need to change: Use Answers Array for answers to show instead of Questions for all.
//              AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns = val;

              Navigator.pop(context, selectedResults,);
            }
            else if(text=="Cancel"){
              Navigator.pop(context);
            }
          });
//
        },
      ),
    );
  }


  ///Save Answers.
  saveSingleAnswers(List<AnswersModel> ans, List<String> val) {
    Map<String, dynamic> body = {
      "answers" : ans,
    };
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post,authorization: true, url: WebService.answers,body: body,isFormData: false).then(
              (response) async {
            if (response.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(response.body);
              print("Your Api Response ;${responseJson}");
              if(responseJson.containsKey('success')) {
                print("Inserted Successfully");
                AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns = val;
                await prf.remove(UserSession.question);
                Map<String, dynamic> resp = {
                  'success': AnswersGlobal.questions,
                };
                await prf.set(UserSession.question, json.encode(resp));

              } else{
                print("Oh No....! response");
              }
            }else if (response.statusCode == 401){
              setState(() {});
              GFunction.showError(response.body["error"].toString(), context);

            }else{
              GFunction.showError(response.reasonPhrase.toString(), context);
            }
          });
    } on FetchDataException catch(e) {
      setState(() {
        GFunction.showError(e.toString(), context);
      });
    }
  }



}

class Autogenerated {
  List<MyKey> myKey;

  Autogenerated({this.myKey});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    if (json['MyKey'] != null) {
      myKey = new List<MyKey>();
      json['MyKey'].forEach((v) {
        myKey.add(new MyKey.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myKey != null) {
      data['MyKey'] = this.myKey.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyKey {
  String text;
  String value;

  MyKey({this.text, this.value});

  MyKey.fromJson(Map<String, dynamic> json) {
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


