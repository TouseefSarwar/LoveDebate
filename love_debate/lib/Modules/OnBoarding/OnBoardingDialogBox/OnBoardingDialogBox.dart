import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Models/OnBoardingModel.dart';
import 'package:lovedebate/Modules/LoginSignup/Login.dart';
import 'package:lovedebate/Modules/OnBoarding/OnBoardingModels/CheckBoxDataModel.dart';
import 'package:lovedebate/Utils/Constants/WebService.dart';
import 'package:lovedebate/Utils/Controllers/ApiBaseHelper.dart';
import 'package:lovedebate/Utils/Designables/Toast.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';
import 'package:lovedebate/Utils/Designables/CustomButtons.dart';
import 'package:lovedebate/Utils/Controllers/AppExceptions.dart';


var qOptions;



class OnBoardingDialogBox extends StatefulWidget {


  Success Question;
  List<CheckBoxDataModel> questionsCheckBox;

  OnBoardingDialogBox({this.Question,this.questionsCheckBox});

  @override
  _OnBoardingDialogBoxState createState() => _OnBoardingDialogBoxState();
}

class _OnBoardingDialogBoxState extends State<OnBoardingDialogBox> {

  @override
  void dispose() {
    super.dispose();
    this.dispose();
  }

  @override
  void initState() {
    super.initState();

    print(widget.Question.qaId);


//
//    int apiCall = 0;
//    apiItemLenght=0;
//    print(widget.Question.qaOptions);
////
//    if (widget.Question.qaId !=null){
//      qOptions = Autogenerated.fromJson(json.decode('{"MyKey" : ${widget.Question.qaOptions}}'));
//      print(qOptions.myKey.length);
//    }
//    for(int i=0;i<qOptions.myKey.length;i++)
//    {
//      var itm = CheckBoxDataModel(id: widget.Question.qaId,checkboxText: qOptions.myKey[i].text,checkvalue: false,value: qOptions.myKey[i].value);
//      questionsCheckBox.add(itm);
//    }
//
//
//
//    print(questionsCheckBox.length);
//
//    if(qOptions.myKey.first.text=="api"){
//      DialogApi=qOptions.myKey.first.value;
//      callOnBoardingSubOptions(DialogApi);
//    }
//    questionOptionsLenght=questionsCheckBox.length;
  }

  @override
  Widget build(BuildContext context) {

    var totalDialogWidth = (MediaQuery.of(context).size.width - 20)/2.2;
    // var centerBoxWidth = (MediaQuery.of(context).size.width - 80)/ 2.2;
    var totalHeight = totalDialogWidth + 121;

    TextEditingController passwordController = new TextEditingController();

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
          OnBoardingDropDownList(totalDialogWidth,width,widget.Question,qOptions as Autogenerated,widget.questionsCheckBox),

        ],
      ),
    );
  }
  Container OnBoardingDropDownList(double totalDialogWidth ,double width,Success Question,Autogenerated opt,List<CheckBoxDataModel> questionsCheckBox) {
    return Container(
      //height: totalDialogWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 16,),
          Text("Select the Option",style: TextStyle(fontSize: GlobalFont.textFontSize),),
          SizedBox(height: 16,),
          Container(
            height:(((widget.questionsCheckBox.length).toDouble())*55),
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
      margin: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          //SizedBox(width: 16,),
          new Checkbox(
            value: checkList[index].checkvalue ,
            onChanged: (checkBoxValue){
              setState(() {
                if (widget.Question.qaFieldType == "Dropdown"){
                  if(checkList[index].checkvalue==false){
                    for (int i =0; i<widget.questionsCheckBox.length; i++){
                      if(i == index) {
                        checkList[i].checkvalue=true;
                      }else{
                        checkList[i].checkvalue=false;
                      }
                    }
                  } else{
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
            checkColor: GlobalColors.secondColor,
            activeColor: GlobalColors.firstColor,),
          SizedBox(width: 16,),
          Expanded(
            child: Container(
                child: Text((checkList[index].checkboxText) ,style: TextStyle(fontSize: GlobalFont.textFontSize),overflow: TextOverflow.ellipsis,maxLines: 5,)),
          )
        ],
      ),
    );
  }
//  Container OnBoardingCheckBox(String opt,double width,List<CheckBoxDataModel> questionsCheckBox,int index,int apiItemLenght) {
//    return Container(
//      height: 60,
//      // color: Colors.blue,
//      margin: EdgeInsets.all(8),
//      child: Row(
//        children: <Widget>[
//          //SizedBox(width: 16,),
//          new Checkbox(
//            value: widget.questionsCheckBox[index].checkvalue ,
//            //onChanged: _value1Changed,
//            onChanged: (checkBoxValue){
//              setState(() {
//
//                if (widget.Question.qaFieldType == "Dropdown"){
//                  if(widget.questionsCheckBox[index].checkvalue==false){
////                        questionsCheckBox[index].checkvalue=true;
//                    for (int i =0; i<widget.questionsCheckBox.length; i++){
//                      if(i == index) {
//                        widget.questionsCheckBox[i].checkvalue=true;
//                      }else{
//                        widget.questionsCheckBox[i].checkvalue=false;
//                      }
//                    }
//                  }
//                  else{
//                    widget.questionsCheckBox[index].checkvalue=false;
//                  }
//                }else if (widget.Question.qaFieldType == "Checkbox"){
//                  if(widget.questionsCheckBox[index].checkvalue==false) {
//                    widget.questionsCheckBox[index].checkvalue = true;
//                  }else {
//                    widget.questionsCheckBox[index].checkvalue = false;
//                  }
//                }
//
//              });
//            },
//            checkColor: GlobalColors.secondColor,
//            activeColor: GlobalColors.firstColor,),
//          SizedBox(width: 16,),
//          Expanded(
//            child: Container(
//                child: Text((questionsCheckBox[index].checkboxText) ,style: TextStyle(fontSize: GlobalFont.textFontSize),overflow: TextOverflow.ellipsis,maxLines: 5,)),
//          )
//        ],
//      ),
//    );
//  }
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
            String selectedResults=" ";
            widget.questionsCheckBox.forEach((f){
              if(f.checkvalue==true){
                selectedResults=selectedResults+","+f.checkboxText;
              }
            });
            if(text=="Done"){
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

