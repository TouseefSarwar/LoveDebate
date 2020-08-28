import 'dart:convert';
import 'package:app_push_notifications/Models/QaOptions.dart';
import 'package:app_push_notifications/Utils/Controllers/Loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_push_notifications/Models/AnswersModel.dart';
import 'package:app_push_notifications/Models/OnBoardingModel.dart';
import 'package:app_push_notifications/Modules/Preferences/PreferencesModel/CheckBoxDataModel.dart';
import 'package:app_push_notifications/Utils/Constants/SharedPref.dart';
import 'package:app_push_notifications/Utils/Constants/WebService.dart';
import 'package:app_push_notifications/Utils/Controllers/ApiBaseHelper.dart';
import 'package:app_push_notifications/Utils/Controllers/AppExceptions.dart';
import 'package:app_push_notifications/Utils/Globals/AnswersGlobals.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:app_push_notifications/Utils/Globals/Fonts.dart';
import 'package:app_push_notifications/Utils/Designables/CustomButtons.dart';
import 'package:app_push_notifications/Utils/Globals/GlobalFunctions.dart';
import 'package:app_push_notifications/Utils/Globals/UserSession.dart';


class OnBoardingDialogBox extends StatefulWidget {

  OnBoardingDataModel Question;
  List<CheckBoxDataModel> questionsCheckBox;
  String api;
  OnBoardingDialogBox({this.Question,this.questionsCheckBox, this.api});
  @override
  _OnBoardingDialogBoxState createState() => _OnBoardingDialogBoxState();
}

class _OnBoardingDialogBoxState extends State<OnBoardingDialogBox> {
  SharedPref prf = SharedPref();
  int apiCall = 0;

  @override
  void initState() {
    if (widget.api != null){
      print("here....");
      apiCall =1;
      setState(()  {
          callOnBoardingSubOptions(widget.api, widget.Question);
      });

    }else if(widget.Question.qaAns != null && widget.Question.qaAns != ""){
      ///If you want to send
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


    return apiCall == 0 ? Dialog(
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
      )
    ): Center(child: Loading());
  }
  Container OnBoardingDropDownList(double totalDialogWidth ,double width,OnBoardingDataModel Question,List<CheckBoxDataModel> questionsCheckBox) {
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
                child: InkWell(
                  onTap: (){
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
                    child: Text(
                      (checkList[index].checkboxText) ,style: TextStyle(fontSize: GlobalFont.textFontSize),textAlign: TextAlign.left,overflow: TextOverflow.ellipsis,maxLines: 5,)
                )
            ),
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
              }else{
                  if (widget.Question.qaSlug == "avg_income"){
                    for(int i=0; i<widget.questionsCheckBox.length;i++){
                      if(widget.questionsCheckBox[i].checkvalue==true){
                        if (i == 0){
                          selectedResults = "" +">"+ widget.questionsCheckBox[i].value +">"+ widget.questionsCheckBox[i+1].value;
                        }else if (i == widget.questionsCheckBox.last){
                          selectedResults = widget.questionsCheckBox[i-1].value +">"+ widget.questionsCheckBox[i].value +">"+ "";
                        }else{
                          selectedResults = widget.questionsCheckBox[i-1].value +">"+ widget.questionsCheckBox[i].value +">"+ widget.questionsCheckBox[i+1].value;
                        }
                      }
                    }
                    List<String> vl = selectedResults.split(">");

                    AnswersGlobal.answers.removeWhere((element){
                      if (element.qId== widget.Question.qaId){
                        print("deleted");
                        return true;
                      } else{
                        print("not found");
                        return false;
                      }
                    });
                    List<String> fv =List<String>();
                    AnswersModel v = AnswersModel(qId: widget.Question.qaId,qSlug: widget.Question.qaSlug, answers: vl);
                    if (UserSession.isSignup){
                      AnswersGlobal.answers.add(v);
                      fv.add(vl[1]);
                      AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns = fv;
                    }else{
                      List<AnswersModel> lst = List<AnswersModel>();
                      lst.add(v);
                      fv.add(vl[1]);
                      AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns = fv;
                      saveSingleAnswers(lst, vl);
                    }
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
                      List<AnswersModel> lst = List<AnswersModel>();
                      lst.add(v);
                      AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns = val;
                      saveSingleAnswers(lst, val);
                    }
                  }
              }
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
                if(widget.Question.qaSlug == "avg_income"){
                  List<String> fv =List<String>();
                  fv.add(val[1]);
                  AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns = fv;
                }else{
                  AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns = val;
                }

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


  ///Editedddd
  callOnBoardingSubOptions(String webserviceUrl, OnBoardingDataModel question) {
    Map<String, dynamic> body = {
    };
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.get,authorization: false, url: webserviceUrl,body: body,isFormData: true).then(
              (response) {
            var data = List<QaOptions>();
            if (response.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(response.body);
              if(responseJson.containsKey('success')) {
                switch (webserviceUrl){
                  case "data/professions":
                    responseJson['success'].forEach((v){
                      var itm = QaOptions(text: v['pro_name'], value: '${v['pro_id']}' );
                      data.add(itm);
                    });
                    break;
                  case "data/children_preferences":
                    responseJson['success'].forEach((v){
                      var itm = QaOptions(text: v['cp_text'], value: '${v['cp_id']}' );
                      data.add(itm);
                    });
                    break;
                  case "data/faith":
                    responseJson['success'].forEach((v){
                      var itm = QaOptions(text: v['f_name'], value: '${v['f_id']}' );
                      data.add(itm);
                    });
                    break;
                  case "data/ethnicity":
                    responseJson['success'].forEach((v){
                      var itm = QaOptions(text: v['e_name'], value: '${v['e_id']}' );
                      data.add(itm);
                    });
                    break;
                  case "data/vacation_types":
                    responseJson['success'].forEach((v){
                      var itm = QaOptions(text: v['vt_name'], value: '${v['vt_id']}' );
                      data.add(itm);
                    });
                    break;
                  case "data/hobbies":
                    responseJson['success'].forEach((v){
                      var itm = QaOptions(text: v['hb_name'], value: '${v['hb_id']}' );
                      data.add(itm);
                    });
                    break;
                  default:
                    print("Nothing found");
                }

                apiCall = 0;
                setState(() {
                  widget.questionsCheckBox.clear();
                  for(int i=0;i<data.length;i++) {
                    var itm = CheckBoxDataModel(id: question.qaId,checkboxText: data[i].text,checkvalue: false,value: data[i].value);
                    widget.questionsCheckBox.add(itm);
                  }
                  widget.api = null;
                  initState();
                });
              }else{
              }
            }else if (response.statusCode == 401){
              apiCall = 0;
              setState(() {});
              GFunction.showError(jsonDecode(response.body)["error"].toString(), context);
            }else{
              setState(() {
                apiCall = 0;
              });
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


