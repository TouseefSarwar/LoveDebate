import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_push_notifications/Models/AnswersModel.dart';
import 'package:app_push_notifications/Models/OnBoardingModel.dart';
import 'package:app_push_notifications/Modules/Preferences/DialogboxAddSlider.dart';
import 'package:app_push_notifications/Modules/Preferences/GooglePlaces.dart';
import 'package:app_push_notifications/Modules/Preferences/OnBoardingDialogBox.dart';
import 'package:app_push_notifications/Screens/TabBarcontroller.dart';
import 'package:app_push_notifications/Utils/Constants/SharedPref.dart';
import 'package:app_push_notifications/Utils/Constants/WebService.dart';
import 'package:app_push_notifications/Utils/Controllers/ApiBaseHelper.dart';
import 'package:app_push_notifications/Utils/Controllers/Loader.dart';
import 'package:app_push_notifications/Utils/Globals/AnswersGlobals.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:app_push_notifications/Utils/Designables/CustomAppBar.dart';
import 'package:app_push_notifications/Utils/Globals/Fonts.dart';
import 'package:app_push_notifications/Utils/Controllers/AppExceptions.dart';
import 'package:app_push_notifications/Utils/Globals/GlobalFunctions.dart';
import 'package:app_push_notifications/Utils/Globals/UserSession.dart';
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
  List<CheckBoxDataModel> questionsCheckBox = List<CheckBoxDataModel>();
  List<CheckBoxDataModel> apiQuestionsCheckBox = List<CheckBoxDataModel>();


///ends
  ///
  int apiCall = 0;
  String answer="";
  double _value = 0.0;
  SharedPref prf = SharedPref();

  void _setvalue(double value) => setState(() => _value = value);


  @override
  void initState() {
    super.initState();
    get();
  }


  get() async{

    if (await prf.containKey(UserSession.signUp)){
      if (await prf.getBy(UserSession.signUp)){
          apiCall=1;
          setState(() {
            callOnBoardingQuestions();
          });
      }else{
        if(await prf.containKey(UserSession.question)){
            Map<String, dynamic> responseJson = json.decode(await prf.getBy(UserSession.question));
            AnswersGlobal.questions.clear();
            responseJson["success"].forEach((v) {
            OnBoardingDataModel item = OnBoardingDataModel.fromJson(v);
            AnswersGlobal.questions.add(OnBoardingDataModel.fromJson(v));
            });
            AnswersGlobal.questions.forEach((element) {
            print(element.qaAns);
            });
            apiCall =0;
            setState(() {});

        }else{
          apiCall=1;
          setState(() {
            callOnBoardingQuestions();
          });

        }
      }
    }else{
    }

  }

  @override
  Widget build(BuildContext context)  {

    return Scaffold (
      appBar: (UserSession.isSignup)? AppBar(
        automaticallyImplyLeading: false,
        title: Text("I Seek!" ,style: TextStyle(fontSize: GlobalFont.navFontSize, fontWeight: FontWeight.bold,color:  Colors.black),),
        backgroundColor: Colors.white,
        actions: UserSession.isSignup? <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0,top: 12),
            child: GestureDetector(
              onTap: () {
                if (ValidateQuestion()){
                  apiCall =1;
                  setState(() {
                    saveAnswers();
                  });

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
        ]:<Widget>[],
      ): CustomAppbar.setNavigationWithOutBack("I Seek!"),
      body: SafeArea(
      child: (apiCall==0)?Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView.builder(
          itemCount: AnswersGlobal.questions.length,
          itemBuilder: (context, index){
            return PreferenceQuestion(
              ques: AnswersGlobal.questions[index],
              ans: AnswersGlobal.questions[index].qaAns == null || AnswersGlobal.questions[index].qaAns.isEmpty ?Text(
                "Answer",
                style: TextStyle(
                    fontSize: GlobalFont.textFontSize - 2,
                    color: Colors.grey),
              ):Text(
                index == 0 ? AnswersGlobal.questions[index].qaAns.first +", "+ AnswersGlobal.questions[index].qaAns[1]  :"Selected",
                style: TextStyle(
                    fontSize: GlobalFont.textFontSize - 2,
                    fontWeight: FontWeight.w500,
                    color: Colors.green),
              ) ,
              action: (){
                if (AnswersGlobal.questions[index].qaSlug == "address"){
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

                      setState(() {
                        print("${AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns}");
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

                      ///Heree is change
                      AnswersGlobal.questionIndex = index;
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return OnBoardingDialogBox(Question: AnswersGlobal.questions[AnswersGlobal.questionIndex],questionsCheckBox: questionsCheckBox,api: dialogApi,);
                          }
                      ).then((value){
                        setState(() {});
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
                        setState(() {});
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

  ///API's OnboardingQuestions
  callOnBoardingQuestions() {

    Map<String, dynamic> body = {

    };
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.get,authorization: false, url: WebService.onboardingApi,body: body,isFormData: true).then(
              (response) async {
            var data = List<OnBoardingDataModel>();
            if (response.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(response.body);
              if(responseJson.containsKey('success')) {
                responseJson['success'].forEach((v) {
                  data.add(OnBoardingDataModel.fromJson(v));
                });
                AnswersGlobal.questions = data;
                FetchUserAnswers();
              } else{
                print("Oh no response");
              }

            }else if (response.statusCode == 401){
              apiCall=0;
              setState(() {});
              GFunction.showError(response.body["error"].toString(), context);
            }else{
              apiCall=0;
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

  ///API's Answers
  FetchUserAnswers() {

    Map<String, dynamic> body = {

    };
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.get,authorization: true, url: WebService.userAnswers,body: body,isFormData: true).then(
              (response) async {
            List<String> val = List<String>();
            if (response.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(response.body);
              if(responseJson.containsKey('success')) {
                for(int i= 0; i<AnswersGlobal.questions.length;i++){
                  if (AnswersGlobal.questions[i].qaSlug == "address"){
                    if(responseJson['success']['city'] != null && responseJson['success']['state'] != null ){
                      AnswersGlobal.questions[i].qaAns.add(responseJson['success']['city'].toString());
                      AnswersGlobal.questions[i].qaAns.add(responseJson['success']['state'].toString());
                      AnswersGlobal.questions[i].qaAns.add(responseJson['success']['address'].toString());
                      AnswersGlobal.questions[i].qaAns.add(responseJson['success']['lat'].toString());
                      AnswersGlobal.questions[i].qaAns.add(responseJson['success']['lng'].toString());
                    }
                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "match_area"){
                    if (responseJson['success']['pr_match_area'] != null){
                      AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_match_area'].toString());
                    }
                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "height_preference"){
                    if (responseJson['success']['pr_height'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_height'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_height'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }
                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "serious"){
                    if (responseJson['success']['pr_serious'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_serious'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_serious'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }
                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "profession"){
                    if (responseJson['success']['pr_profession'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_profession'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_profession'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }

                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "avg_income"){
                    if (responseJson['success']['pr_average_income'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_average_income'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_average_income'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }

                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "goal"){
                    if (responseJson['success']['pr_goals'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_goals'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_goals'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }

                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "children_preference"){
                    if (responseJson['success']['pr_kids'] != null){

                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_kids'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_kids'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }

                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "partner_expectations"){
                    if (responseJson['success']['pr_expectations'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_expectations'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_expectations'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }

                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "characteristics"){
                    if (responseJson['success']['pr_characteristic'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_characteristic'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_characteristic'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }
                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "IE"){
                    if (responseJson['success']['pr_ie'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_ie'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_ie'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }

                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "single"){
                    if (responseJson['success']['pr_single'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_single'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_single'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }
                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "single_dislikes"){
                    if (responseJson['success']['pr_single_dislikes'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_single_dislikes'].toString());

                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_single_dislikes'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }
                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "faith"){
                    if (responseJson['success']['faith'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['faith'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['faith'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }

                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "faith_dislike"){
                    if (responseJson['success']['pr_faith_dislikes'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_faith_dislikes'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_faith_dislikes'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }
                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "religion_comp"){
                    if (responseJson['success']['pr_religious'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_religious'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_religious'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }
                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "ethnicity"){
                    if (responseJson['success']['ethnicity'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['ethnicity'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['ethnicity'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }
                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "ethnicity_dislike"){
                    if (responseJson['success']['pr_ethnicity_dislikes'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_ethnicity_dislikes'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_ethnicity_dislikes'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }
                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "most_dislikes"){
                    if (responseJson['success']['pr_other_dislikes'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_other_dislikes'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_other_dislikes'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }
                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "town"){
                    if (responseJson['success']['pr_town_likes'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_town_likes'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_town_likes'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }
                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "vacation"){
                    if (responseJson['success']['pr_vacations'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_vacations'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_vacations'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }

                    }
                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "curse"){
                    if (responseJson['success']['pr_curse'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_curse'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_curse'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }
                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "hobbies_outdoor"){
                    if (responseJson['success']['pr_hobbies_outdoor'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_hobbies_outdoor'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_hobbies_outdoor'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }
                  }
                  else if (AnswersGlobal.questions[i].qaSlug == "hobbies_indoor"){
                    if (responseJson['success']['pr_hobbies_indoor'] != null){
                      if(AnswersGlobal.questions[i].qaFieldType == "Dropdown"){
                        AnswersGlobal.questions[i].qaAns.add(responseJson['success']['pr_hobbies_indoor'].toString());
                      }else if (AnswersGlobal.questions[i].qaFieldType == "Checkbox"){
                        val = responseJson['success']['pr_hobbies_indoor'].toString().split(",");
                        AnswersGlobal.questions[i].qaAns = val;
                      }
                    }


                  }
                }

                AnswersGlobal.questions.forEach((element) {
                  print(element.qaAns);

                });
                await prf.remove(UserSession.question);
                Map<String, dynamic> resp = {
                  'success': AnswersGlobal.questions,
                };
                await prf.set(UserSession.question, json.encode(resp));

                apiCall=0;
                setState(() {});
              } else{
                print("Oh no response");
              }

            }else if (response.statusCode == 401){
              apiCall=0;
              setState(() {});
              GFunction.showError(response.body["error"].toString(), context);

            }else{
              apiCall=0;
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

  ///Save Answers.
  saveSingleAnswers(List<AnswersModel> ans) {
    Map<String, dynamic> body = {
      'answers' : ans,
    };
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post,authorization: true, url: WebService.answers,body: body,isFormData: false).then(
              (response) async {
            if (response.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(response.body);
              if(responseJson.containsKey('success')) {
                await prf.remove(UserSession.question);
                Map<String, dynamic> resp = {
                  'success': AnswersGlobal.questions,
                };
                await prf.set(UserSession.question, json.encode(resp));
                apiCall = 0;
                setState(() {});

              } else{
                print("Oh No....! response");
              }
            }else if (response.statusCode == 401){
              apiCall = 0;
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

  ///additional
//  callOnBoardingSubOptions(String webserviceUrl, OnBoardingDataModel question) {
//    Map<String, dynamic> body = {
//    };
//    try {
//      ApiBaseHelper().fetchService(method: HttpMethod.get,authorization: false, url: webserviceUrl,body: body,isFormData: true).then(
//              (response) {
//            var data = List<QaOptions>();
//            if (response.statusCode == 200){
//              Map<String, dynamic> responseJson = json.decode(response.body);
//              if(responseJson.containsKey('success')) {
//                switch (webserviceUrl){
//                  case "data/professions":
//                    responseJson['success'].forEach((v){
//                      var itm = QaOptions(text: v['pro_name'], value: '${v['pro_id']}' );
//                      data.add(itm);
//                    });
//                    break;
//                  case "data/children_preferences":
//                    responseJson['success'].forEach((v){
//                      var itm = QaOptions(text: v['cp_text'], value: '${v['cp_id']}' );
//                      data.add(itm);
//                    });
//                    break;
//                  case "data/faith":
//                    responseJson['success'].forEach((v){
//                      var itm = QaOptions(text: v['f_name'], value: '${v['f_id']}' );
//                      data.add(itm);
//                    });
//                    break;
//                  case "data/ethnicity":
//                    responseJson['success'].forEach((v){
//                      var itm = QaOptions(text: v['e_name'], value: '${v['e_id']}' );
//                      data.add(itm);
//                    });
//                    break;
//                  case "data/vacation_types":
//                    responseJson['success'].forEach((v){
//                      var itm = QaOptions(text: v['vt_name'], value: '${v['vt_id']}' );
//                      data.add(itm);
//                    });
//                    break;
//                  case "data/hobbies":
//                    responseJson['success'].forEach((v){
//                      var itm = QaOptions(text: v['hb_name'], value: '${v['hb_id']}' );
//                      data.add(itm);
//                    });
//                    break;
//                  default:
//                    print("Nothing found");
//                }
//
//
//                questionsCheckBox.clear();
//                for(int i=0;i<data.length;i++) {
//                  var itm = CheckBoxDataModel(id: question.qaId,checkboxText: data[i].text,checkvalue: false,value: data[i].value);
//                  questionsCheckBox.add(itm);
//                }
//                showDialog(
//                    barrierDismissible: false,
//                    context: context,
//                    builder: (context) {
//                      return OnBoardingDialogBox(Question: AnswersGlobal.questions[AnswersGlobal.questionIndex],questionsCheckBox: questionsCheckBox,);
//                    }
//
//                ).then((value){
//                  apiCall = 0;
//                  setState(() {});
//                });
//              }else{
//              }
//            }else if (response.statusCode == 401){
//              apiCall = 0;
//              setState(() {});
//              GFunction.showError(jsonDecode(response.body)["error"].toString(), context);
//            }else{
//              setState(() {
//                apiCall = 0;
//              });
//              GFunction.showError(response.reasonPhrase.toString(), context);
//            }
//          });
//    } on FetchDataException catch(e) {
//      setState(() {
//        GFunction.showError(e.toString(), context);
//      });
//    }
//  }

///Save Answers.
  saveAnswers(){

    Map<String, dynamic> body = {
      'answers' : AnswersGlobal.answers,
      'profile_completion_status' : "1",
    };
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post,authorization: true, url: WebService.answers,body: body,isFormData: false).then(
              (response) async {
            if (response.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(response.body);
              if(responseJson.containsKey('success')) {
                //edited
                await prf.set(UserSession.authTokenkey,UserSession.authToken);
                //end
                await prf.remove(UserSession.question);
                Map<String, dynamic> resp = {
                  'success': AnswersGlobal.questions,
                };
                await prf.set(UserSession.question, json.encode(resp));
                if(!(await prf.containKey(UserSession.answers))){
                  Map<String, dynamic> respAns = {
                    'answers': AnswersGlobal.answers,
                  };
                  await prf.set(UserSession.answers, json.encode(respAns));
                }
                await prf.set(UserSession.signUp,false);
                UserSession.isSignup = await prf.getBy(UserSession.signUp);
                setState(() {});
                apiCall = 0;
                Navigator.push(context, CupertinoPageRoute(fullscreenDialog: true,builder: (context) => TabBarControllerPage()) );

              } else{}
            }else if (response.statusCode == 401){
              apiCall = 0;
              setState(() {});
              GFunction.showError(jsonDecode(response.body)["error"].toString(), context);
            }else{
              apiCall = 0;
              GFunction.showError(response.reasonPhrase.toString(), context);
            }
          });
    } on FetchDataException catch(e) {
      setState(() {
        GFunction.showError(e.toString(), context);
      });
    }
  }

  ///Validate Questions....
  bool ValidateQuestion(){
    bool flag = true;
    for (int i=0; i<AnswersGlobal.questions.length; i++){
      if (AnswersGlobal.questions[i].qaSkipable == 0) {
        if (AnswersGlobal.questions[i].qaAns.isEmpty) {
          GFunction.showError("Please Enter ${AnswersGlobal.questions[i].qaName}", context);
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
      final lat = detail.result.geometry.location.lat != null && detail.result.geometry.location.lat.toString() != "" ? detail.result.geometry.location.lat.toString() : "";
      final lng = detail.result.geometry.location.lng != null && detail.result.geometry.location.lng.toString() != "" ? detail.result.geometry.location.lng.toString() : "";
      final fortAdd= detail.result.formattedAddress != null && detail.result.formattedAddress.toString() != ""? detail.result.formattedAddress.toString() : "";
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
      Map<String, dynamic> val = {"city" : city, "state" :state, "formattedAddress": fortAdd,"lat": lat, "lng": lng};
    if ((val["city"].toString() == null || val["city"].toString() == "") || (val["state"].toString() == null || val["state"].toString() == "") || (val["formatedAddress"].toString() == null || val["formatedAddress"].toString() == "") || (val["lat"].toString() == null || val["lat"].toString() == "") || (val["lng"].toString() == null || val["lng"].toString() == "")){
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return DialogboxAddSlider(Question: AnswersGlobal.questions[AnswersGlobal.questionIndex],tempCity: val["city"],tempState: val["state"],tempFAdd: fortAdd,tempLat: lat,tempLng: lng,);
          }

      ).then((value){
        setState(() {
        });
      });
    }else{
      AnswersModel v = AnswersModel(qId: AnswersGlobal.questions[AnswersGlobal.questionIndex].qaId,qSlug: AnswersGlobal.questions[AnswersGlobal.questionIndex].qaSlug, answers: val);

      ///Need to change: Use Answers Array for answers to show instead of Questions for all.
      AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns.clear();
      AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns.add(val["city"].toString());
      AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns.add(val["state"].toString());
      AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns.add(fortAdd);
      AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns.add(lat);
      AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns.add(lng);
      if (UserSession.isSignup){
        AnswersGlobal.answers.add(v);
        setState(() {});
      }else{
        List<AnswersModel> lst = List<AnswersModel>();
        lst.add(v);
        apiCall = 1;
        setState(() {
          saveSingleAnswers(lst);
        });

      }

    }

    }
  }

}

///Questions Stateless widget
class PreferenceQuestion extends StatelessWidget {

  OnBoardingDataModel ques;
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