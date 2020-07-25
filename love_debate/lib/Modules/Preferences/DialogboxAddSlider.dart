
import 'dart:convert';
import 'dart:wasm';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Models/AnswersModel.dart';
import 'package:lovedebate/Models/OnBoardingModel.dart';
import 'package:lovedebate/Utils/Constants/SharedPref.dart';
import 'package:lovedebate/Utils/Constants/WebService.dart';
import 'package:lovedebate/Utils/Controllers/ApiBaseHelper.dart';
import 'package:lovedebate/Utils/Controllers/AppExceptions.dart';
import 'package:lovedebate/Utils/Designables/CustomButtons.dart';
import 'package:lovedebate/Utils/Designables/CustomTextFeilds.dart';
import 'package:lovedebate/Utils/Globals/AnswersGlobals.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';
import 'package:lovedebate/Utils/Globals/GlobalFunctions.dart';
import 'package:lovedebate/Utils/Globals/UserSession.dart';

class DialogboxAddSlider extends StatefulWidget {

  OnBoardingDataModel Question;
  String tempCity;
  String tempState;
  String tempFAdd ="";
  String tempLat ="";
  String tempLng ="";

  DialogboxAddSlider({this.Question,this.tempCity,this.tempState, this.tempFAdd,this.tempLat,this.tempLng});
  @override
  _DialogboxAddSliderState createState() => _DialogboxAddSliderState();
}

class _DialogboxAddSliderState extends State<DialogboxAddSlider> {

  double _value = 0.0;
  void setvalue(double value) => setState(() => _value = value);
  SharedPref prf = SharedPref();
  TextEditingController txtCityController = TextEditingController();
  TextEditingController txtStateController = TextEditingController();
  FocusNode txtCityFocusNode = FocusNode();
  FocusNode txtStateFocusNode = FocusNode();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.Question.qaAns != null && widget.Question.qaAns != ""){
      if(widget.Question.qaSlug=='match_area'){
        if (widget.Question.qaAns.isEmpty){
          _value = 0.0;
        }else{
          _value = double.parse(widget.Question.qaAns.first);
        }
        setvalue(_value);
      }else{
        if (widget.tempCity.isNotEmpty || widget.tempState.isNotEmpty){
          txtCityController.text = widget.tempCity;
          txtStateController.text = widget.tempState;
        }else{
          print("isEmpty");
        }

      }
    }
    
  }
  
  @override
  Widget build(BuildContext context) {

    var totalDialogWidth = (MediaQuery.of(context).size.width - 20)/2.2;
    // var centerBoxWidth = (MediaQuery.of(context).size.width - 80)/ 2.2;
    var totalHeight = totalDialogWidth;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(22.5))
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[


            (widget.Question.qaSlug=='match_area')?Column(
              children: <Widget>[
                SizedBox(height: 12,),
                Container(
                  // height:(10/100)*totalHeight,
                  child: Center(child: Text("Select Matching Distance",style: TextStyle(fontSize: GlobalFont.textFontSize),)),
                ),
                SizedBox(height: 16,),
                RangeSlider(totalDialogWidth),
              ],
            ):Column(
              children: <Widget>[
                Container(
                  height:(10/100)*totalHeight,
                  child: Center(child: Text("Select City and State",style: TextStyle(fontSize: GlobalFont.textFontSize),)),
                ),
                placesTextField(txtStateFocusNode, txtStateController, "State",false),
                placesTextField(txtCityFocusNode,txtCityController,'City',false),
                SizedBox(height: 16,),
              ],
            ),

            Container(
              //height: 100,
              width: double.infinity,
              //color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: OnBoardingDialogBoxBtn("Cancel",Colors.grey,Colors.black)),
                  SizedBox(width: 16,),
                  Expanded(child: OnBoardingDialogBoxBtn("Done",GlobalColors.firstColor,Colors.white)),
                ],
              ),
            ),

          ],
        ),
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
            if(text=="Done"){
              if (widget.Question.qaSlug=='match_area'){
                selectedResults="${(_value).round()}";
                List<String> val = selectedResults.split(">");
                AnswersGlobal.answers.removeWhere((element){
                  if (element.qId== widget.Question.qaId){
                    return true;
                  } else{
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
                  saveSingleAnswers(lst,val);
                }

                ///Need to change: Use Answers Array for answers to show instead of Questions for all.


                Navigator.pop(context, selectedResults,);
              }else{
                if (txtCityController.text.isEmpty){
                  GFunction.showError("Enter City", context);
                } else if (txtStateController.text.isEmpty){
                  GFunction.showError("Enter State", context);
                }else{
                  print("asaas");
                  Map<String, dynamic> val = {"city" : txtCityController.text, "state" :txtStateController.text, "formattedAddress": widget.tempFAdd,"lat": widget.tempLat, "lng":widget.tempLng};
                  AnswersGlobal.answers.removeWhere((element){
                    if (element.qId== widget.Question.qaId){
                      return true;
                    } else{
                      return false;
                    }
                  });
                  AnswersModel v = AnswersModel(qId: widget.Question.qaId,qSlug: widget.Question.qaSlug, answers: val);
//                  AnswersGlobal.answers.add(v);
                  ///Need to change: Use Answers Array for answers to show instead of Questions for all.
                  AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns.clear();
                  AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns.add(val["city"].toString()) ;
                  AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns.add(val["state"].toString());
                  AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns.add(widget.tempFAdd);
                  AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns.add(widget.tempLat);
                  AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns.add(widget.tempLng);
                  if (UserSession.isSignup){
                    AnswersGlobal.answers.add(v);
                  }else{
                    print("no signup");
                    List<AnswersModel> lst = List<AnswersModel>();
                    lst.add(v);
                    saveSingleAnswers(lst,AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns);

                  }
                  Navigator.pop(context, selectedResults,);
                }

              }
            } else if (text=="Cancel") {
              Navigator.pop(context);
            }

          });
//
        },
      ),
    );
  }
  Widget placesTextField( FocusNode focusNode, TextEditingController txtFeild,String text, bool isSecure ) {
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

  Widget RangeSlider(double width) {
    return Column(
      children: <Widget>[
        Slider(value: _value, onChanged: setvalue,activeColor: GlobalColors.firstColor,min: 0.0, max: 4000,),
        Text(
          '${(_value).round()} Miles',
          style: TextStyle(
            fontSize: GlobalFont.textFontSize,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 16,),
      ],
    );
  }



  ///Save Answers.
  saveSingleAnswers(List<AnswersModel> ans,List<String> val) {
    Map<String, dynamic> body = {
      'answers' : ans,
    };
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post, url: WebService.answers,body: body,isFormData: false).then(
              (response) async {
            if (response.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(response.body);
              print("Your Api Response ;${responseJson}");
              if(responseJson.containsKey('success')) {
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
              setState(() {});
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