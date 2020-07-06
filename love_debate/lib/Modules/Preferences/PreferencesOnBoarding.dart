import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Models/OnBoardingModel.dart';
import 'package:lovedebate/Models/QaOptions.dart';
import 'package:lovedebate/Modules/Preferences/DialogboxAddSlider.dart';
import 'package:lovedebate/Modules/Preferences/GooglePlaces.dart';
import 'package:lovedebate/Modules/Preferences/OnBoardingDialogBox.dart';
import 'package:lovedebate/Utils/Constants/WebService.dart';
import 'package:lovedebate/Utils/Controllers/ApiBaseHelper.dart';
import 'package:lovedebate/Utils/Controllers/Loader.dart';
import 'package:lovedebate/Utils/Designables/Toast.dart';
import 'package:lovedebate/Utils/Globals/AnswersGlobals.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';
import 'package:lovedebate/Utils/Controllers/AppExceptions.dart';
import 'PreferencesModel/CheckBoxDataModel.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:math';



var qOptions;
const kGoogleApiKey = "AIzaSyDkrmNt7yLpSO4JA9k7JdzVmX3KQrvvyzg";
// to get places detail (lat/lng)
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
class PreferencesOnBoarding extends StatefulWidget {
  @override
  _PreferencesOnBoardingState createState() => _PreferencesOnBoardingState();
}

class _PreferencesOnBoardingState extends State<PreferencesOnBoarding> {

  ///additionals
  ///
  ///
  List<CheckBoxDataModel> questionsCheckBox = List<CheckBoxDataModel>();
  List<CheckBoxDataModel> apiQuestionsCheckBox = List<CheckBoxDataModel>();

///ends

  int apiCall = 0;
  List<Success> questionsData = List<Success>();

  String answer=" ";

  double _value = 0.0;
  void _setvalue(double value) => setState(() => _value = value);

  TextEditingController txtAnswerController = TextEditingController();

  FocusNode txtEmailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    callOnBoardingQuestions();
    apiCall=1;
    AnswersGlobal.answers.clear();
    AnswersGlobal.questionIndex = -1;
  }


  @override
  Widget build(BuildContext context) {

    double _height=(MediaQuery.of(context).size.height)-AppBar().preferredSize.height;
    double _width=MediaQuery.of(context).size.width;
//    String ans = "";

    return Scaffold(
      appBar: AppBar(
        title: Text("Preferences" ,style: TextStyle(fontSize: GlobalFont.navFontSize, fontWeight: FontWeight.bold,color:  Colors.black),),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0,top: 12),
            child: GestureDetector(
              onTap: () {
                if (ValidateQuestion()){
                  saveAnswers();
                }else{
                  print("Missing Feilds");
                }
              },
              child: Text(
                "Save" ,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w500 ,
                  color: GlobalColors.firstColor
                ),
              )
            ),
          ),
        ],
      ),
      body: SafeArea(
      child: (apiCall==0)?Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView.builder(
//          itemCount: questionsData.length,
          itemCount: AnswersGlobal.questions.length,
          itemBuilder: (context, index){
//            AnswersGlobal.questionIndex = index;
            return PreferenceQuestion(
              ques: AnswersGlobal.questions[index],
              ans: AnswersGlobal.questions[index].qaAns == null || AnswersGlobal.questions[index].qaAns.isEmpty ?Text(
                "Answer",
                style: TextStyle(
                    fontSize: GlobalFont.textFontSize - 2,
                    color: Colors.grey),
              ):Text(
                index == 0 ? AnswersGlobal.questions[index].qaAns.first +", "+ AnswersGlobal.questions[index].qaAns.last  :"Selected",
                style: TextStyle(
                    fontSize: GlobalFont.textFontSize - 2,
                    fontWeight: FontWeight.w500,
                    color: Colors.green),
              ) ,
              action: (){
                if (AnswersGlobal.questions[index].qaSlug == "address"){
                    print("Use places instead");
                    AnswersGlobal.questionIndex = index;
                    _handlePressButton();

                }else if (AnswersGlobal.questions[index].qaSlug == "match_area"){
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          AnswersGlobal.questionIndex = index;
                          return DialogboxAddSlider(Question: AnswersGlobal.questions[index],);
                        }
                    ).then((value){
                      print(value);
                      setState(() {
  //                        AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns = value;
                        print("Yahn pa Slider.... :${AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns}");
                      });
                    });
                }else{
                    if (AnswersGlobal.questions[index].qaId !=null){
                      qOptions = Autogenerated.fromJson(json.decode('{"MyKey" : ${AnswersGlobal.questions[index].qaOptions}}'));
                    }
                    questionsCheckBox.clear();
                    for(int i=0;i<qOptions.myKey.length;i++) {
                      var itm = CheckBoxDataModel(id: AnswersGlobal.questions[index].qaId,checkboxText: qOptions.myKey[i].text,checkvalue: false,value: qOptions.myKey[i].value);
                      questionsCheckBox.add(itm);
                    }
                    if(qOptions.myKey.first.text=="api"){
                      var dialogApi=qOptions.myKey.first.value;
                      print(dialogApi);

                      ///here is change
                      AnswersGlobal.questionIndex = index;
//                      print(AnswersGlobal.questionIndex);
                      callOnBoardingSubOptions(dialogApi, AnswersGlobal.questions[index]);
                      setState(() {
                        apiCall = 1;
                      });
                    }else{

                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            AnswersGlobal.questionIndex = index;
                            return OnBoardingDialogBox(Question: AnswersGlobal.questions[index],questionsCheckBox: questionsCheckBox,);
                          }
                      ).then((value){

                        setState(() {
  //                        AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns = value;
                          print("Yahn pa Baki sab.... :${AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns}");
                        });
                      });
                    }
                }
              },
            );
           },
        ),
      ):Center(child: Loading(),),
    ),

    );
  }

  Card QuestionsContainer(double _height, double _width, FocusNode txtEmailFocusNode, TextEditingController txtAnswerController, BuildContext context,String questiontext,int _questionType,String fieldtype,Success QuestionObj,) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation:  5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Container(
            width: _width,
            margin: EdgeInsets.all(24),
              child: Text(questiontext,style: TextStyle(
                  fontSize: GlobalFont.textFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
                textAlign: TextAlign.justify,
              )
          ),
          (fieldtype!="Slider")?Container(
           // height: 120,
            margin: EdgeInsets.all(4),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AnswerContainer(_width,"Enter Required value",QuestionObj)
//                  (fieldtype=="Dropdown"||fieldtype=="Checkbox")? AnswerContainer(_width,"Enter Required value",QuestionObj):
//                  Padding(
//                    padding: const EdgeInsets.all(16),
//                    child: NumberTextFeildContainer(txtAnswerController, fieldtype, context, QuestionObj),
//                  ),
                ],
              ),
            ),
          ):OnBoardingSlider(_width),
        ],
      ),
    );
  }

  InkWell AnswerContainer(double _width,String answerText,Success QuestionObj,) {
    return InkWell(
      onTap: (){
        setState(() {
          if (QuestionObj.qaId !=null){
            qOptions = Autogenerated.fromJson(json.decode('{"MyKey" : ${QuestionObj.qaOptions}}'));
            print(qOptions.myKey.length);
          }
          for(int i=0;i<qOptions.myKey.length;i++)
          {
            var itm = CheckBoxDataModel(id: QuestionObj.qaId,checkboxText: qOptions.myKey[i].text,checkvalue: false,value: qOptions.myKey[i].value);
            questionsCheckBox.add(itm);
          }
          if(qOptions.myKey.first.text=="api"){
            callOnBoardingSubOptions(qOptions.myKey.first.value, QuestionObj);
          }
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {

                return OnBoardingDialogBox(Question: QuestionObj);
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
          margin: EdgeInsets.only(bottom: 8, left: 8),
          child: Text((answer==" ")?answerText:answer,
            style: TextStyle(
                  fontSize: GlobalFont.textFontSize,
                  color: Colors.grey,
                ),
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,maxLines: 2,),

        ),
        SizedBox(height: 8,),
        Container(height: 1,width:_width-54 ,color:Colors.grey,),
        SizedBox(height: 16,),
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
          Text(
            'Value: ${(_value * 100).round()}',
            style: TextStyle(
              fontSize: GlobalFont.textFontSize,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  ///API's Calling
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
//                  questionsData=data;
                  AnswersGlobal.questions = data;
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
  ///additional
  callOnBoardingSubOptions(String webserviceUrl, Success question) {
    Map<String, dynamic> body = {
    };
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.get, url: webserviceUrl,body: body,isFormData: true).then(
              (response) {
            var data = List<QaOptions>();
            if (response.statusCode == 200){
              print(webserviceUrl);
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
                setState(() {
                  apiCall = 0;
                });
                questionsCheckBox.clear();
                for(int i=0;i<data.length;i++) {
                  var itm = CheckBoxDataModel(id: question.qaId,checkboxText: data[i].text,checkvalue: false,value: data[i].value);
                  questionsCheckBox.add(itm);
                }
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return OnBoardingDialogBox(Question: AnswersGlobal.questions[AnswersGlobal.questionIndex],questionsCheckBox: questionsCheckBox,);
                    }

                ).then((value){
                  setState(() {});
                });
              } else{
                print("Oh no response");
              }
            }else if (response.statusCode == 401){
              setState(() {
                apiCall = 0;
              });
              Toast.show(response.reasonPhrase.toString(), context, duration: Toast.LENGTH_LONG);
            }else{
              setState(() {
                apiCall = 0;
              });
              Toast.show(response.reasonPhrase.toString(), context, duration: Toast.LENGTH_LONG);
            }
          });
    } on FetchDataException catch(e) {
      setState(() {
      });
    }
  }

///Save Answers.
  saveAnswers() {


    Map<String, dynamic> body = {
      "answers" : jsonEncode(AnswersGlobal.questions),
    };
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post, url: WebService.answers,body: body,isFormData: true).then(
              (response) {
            var data = List<QaOptions>();
            if (response.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(response.body);
              print("Your Api Response ;${responseJson}");
              if(responseJson.containsKey('success')) {
                AnswersGlobal.questions.clear();
                AnswersGlobal.questionIndex = -1;
                AnswersGlobal.answers.clear();
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

  ///Validate Questions....
  bool ValidateQuestion(){
    bool flag = true;
    for (int i=0; i<AnswersGlobal.questions.length; i++){
      if (AnswersGlobal.questions[i].qaSkipable == 0) {
        if (AnswersGlobal.questions[i].qaAns.isEmpty) {
          Toast.show("Please Enter ${AnswersGlobal.questions[i].qaName}", context, duration: Toast.LENGTH_LONG);
          flag = false;
          break;
        }
      }

    }
    return flag;
  }

  ///Google Places...
  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: Mode.overlay,

//      language: "fr",
//      components: [Component(Component.country, "fr")],
    );
    displayPrediction(p, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
//      final lat = detail.result.geometry.location.lat;
//      final lng = detail.result.geometry.location.lng;

      var city="";
      var state="";
    for(int i=0;i<detail.result.addressComponents.length;i++){
      if(detail.result.addressComponents[i].types[0].toString()=="administrative_area_level_1"){
        if (detail.result.addressComponents[i].longName != null && detail.result.addressComponents[i].longName != ""){
          state =detail.result.addressComponents[i].longName.toString();
        }
      }
      if(detail.result.addressComponents[i].types[0]=="locality"){
        if (detail.result.addressComponents[i].longName != null && detail.result.addressComponents[i].longName != ""){
          city =detail.result.addressComponents[i].longName.toString();
        }
      }
    }
    Map<String, dynamic> val = {"city" : city, "state" :state};

    print(val["city"]);

    if ((val["city"].toString() == null || val["city"].toString() == "") || (val["state"].toString() == null || val["state"].toString() == "")){
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return DialogboxAddSlider(Question: AnswersGlobal.questions[AnswersGlobal.questionIndex],tempCity: val["city"],tempState: val["state"],);
          }

      ).then((value){
        setState(() {
        });
      });
    }else{
      AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns.clear();
      AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns.add(val["city"].toString());
      AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns.add(val["state"].toString());
      setState(() {
      });
    }

    }
  }

}

///Questions Stateless widget
class PreferenceQuestion extends StatelessWidget {

  Success ques;
  VoidCallback action;
  Text ans;
  PreferenceQuestion({this.ques, this.action, this.ans});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: action,
      child: Container(
        height: 80,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
//                Icon(Icons.accessibility_new, size: 40,color: Colors.black,),
                Expanded(
                  child: ques.qaSkipable == 1? Text(ques.qaName,style: TextStyle(
                      fontSize: GlobalFont.textFontSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                    textAlign: TextAlign.left,
                  ) :Text(ques.qaName+"*",style: TextStyle(
                      fontSize: GlobalFont.textFontSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                    textAlign: TextAlign.left,
                  ),
                ),
                ans,
              ],
            ),
          ),
        ),
      ),
    );
  }
}



///Google places


class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold()
      : super(
    apiKey: kGoogleApiKey,
    sessionToken: Uuid().generateV4(),
    language: "en",
    components: [Component(Component.country, "uk")],
  );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
    final body = PlacesAutocompleteResult(
      onTap: (p) {
        displayPrediction(p, searchScaffoldKey.currentState);
      },
      logo: Row(
        children: [FlutterLogo()],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
    return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    searchScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {
      searchScaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Got answer")),
      );
    }
  }
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(generateBits(bitCount), digitCount);

  int generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}