import 'dart:convert';

import 'package:app_push_notifications/Models/QaOptions.dart';
import 'package:app_push_notifications/Models/UserDetailModel.dart';
import 'package:app_push_notifications/Modules/PreMatches/Catagories.dart';
import 'package:app_push_notifications/Modules/PreMatches/Rounds/Rounds.dart';
import 'package:app_push_notifications/Utils/Constants/WebService.dart';
import 'package:app_push_notifications/Utils/Controllers/ApiBaseHelper.dart';
import 'package:app_push_notifications/Utils/Controllers/AppExceptions.dart';
import 'package:app_push_notifications/Utils/Controllers/Loader.dart';
import 'package:app_push_notifications/Utils/Designables/CustomAppBar.dart';
import 'package:app_push_notifications/Utils/Designables/CustomButtons.dart';
import 'package:app_push_notifications/Utils/Globals/AnswersGlobals.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:app_push_notifications/Utils/Globals/Fonts.dart';
import 'package:app_push_notifications/Utils/Globals/GlobalFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtherProfile extends StatefulWidget {
  String userId;

  OtherProfile({this.userId});

  @override
  _OtherProfileState createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {

  bool loading = false;
  UserDetail userDetail = UserDetail();


  Map<String,dynamic> singleJson ={'single':[
    {"text":"High Expectations","value":"6"},
    {"text":"I was not ready before, but now I am","value":"5"},
    {"text":"Too shy to meet people","value":"4"},
    {"text":"No time to date","value":"3"},
    {"text":"I am not big on socializing","value":"2"},
    {"text":"I love being Single","value":"1"}
    ]};
  Map<String,dynamic> partnerJson ={'partner':[
    {"text":"Look just as good as I do.","value":"p1"},
    {"text":"Like the things I like to do.","value":"p2"},
    {"text":"Treat me the way I want to be treated.","value":"p3"}
    ]};
  List<QaOptions> single = List<QaOptions>();
  List<QaOptions> partner = List<QaOptions>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    setState(() {
      FetchUserDetails();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar.setNavigationWithOutBack("Profile"),
        body: (!loading)?SafeArea(
          child: ListView(
            children: [
              topSection(),
              (userDetail.gender!=null)?infoTab("Gender", (userDetail.gender == "1")? 'Male':'Female',','):Container(),
              (userDetail.address!=null)?infoTab("Address", userDetail.city+', '+userDetail.state, ','):Container(),
              (userDetail.dob!=null)?infoTab("Date of Birth", userDetail.dob+'  Age: '+(DateTime.now().difference(DateTime.parse(userDetail.dob)).inDays/365).floor().toString()+" Years", ','):Container(),
              (userDetail.height!=null)?infoTab("Height", userDetail.height, ','):Container(),
              (userDetail.prProfession!=null)?infoTab("Profession", userDetail.professionsStr, '|'):Container(),
              (userDetail.prMatchArea!=null)?infoTab("Match Area", userDetail.prMatchArea, ','):Container(),
              (userDetail.prHeight!=null)?infoTab("Height Preference", capitalizeFirstLetter(userDetail.prHeight) , ','):Container(),
              (userDetail.prSerious!=null)?infoTab("Serious", capitalizeFirstLetter(userDetail.prSerious), ','):Container(),
              (userDetail.prAverageIncome!=null)?infoTab("Average Income", userDetail.prAverageIncome, ''):Container(),
              (userDetail.prGoals!=null)?infoTab("Goals", userDetail.prGoals, ','):Container(),

              //if you want to change title "Partner Expectations" also change in the "infoTab" func
              (userDetail.prExpectations!=null)?infoTab("Partner Expectations", userDetail.prExpectations, ','):Container(),
              (userDetail.prCharacteristic!=null)?infoTab("Characteristic", userDetail.prCharacteristic, ','):Container(),
              (userDetail.prIe!=null)?infoTab("IE", capitalizeFirstLetter(userDetail.prIe), ','):Container(),
              //if you want to change title "Single" also change in the "infoTab" func
              (userDetail.prSingle!=null)?infoTab("Single", userDetail.prSingle, ','):Container(),
              (userDetail.prSingleDislikes!=null)?infoTab("Single Dislikes", userDetail.prSingleDislikes, ','):Container(),
              (userDetail.faith!=null)?infoTab("Faith", userDetail.faithStr, '|'):Container(),
              (userDetail.prFaithDislikes!=null)?infoTab("Faith Dislikes", userDetail.faithDislikeStr, '|'):Container(),
              (userDetail.prReligious!=null)?infoTab("Religious", userDetail.prReligious, ','):Container(),
              (userDetail.ethnicity!=null)?infoTab("Ethnicity", userDetail.ethnicityStr, '|'):Container(),
              (userDetail.prEthnicityDislikes!=null)?infoTab("Ethnicity Dislikes", userDetail.ethnicityDislikeStr, '|'):Container(),

            ],
          ),
        ):Center(child: Loading(),),
    );
  }

  //TopSection
  Widget topSection(){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50,),
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: (userDetail.profilePic == null||userDetail.profilePic == "null")? AssetImage('images/dummy.png'): NetworkImage("https://lovedebate.co/public/assets/images/profile/${userDetail.profilePic}"),
              backgroundColor: Colors.transparent,
            ),
          ),
          SizedBox(height: 16,),
          Center(
            child: Text(
              (userDetail.firstName != null)?userDetail.firstName +' '+ userDetail.lastName: "Test User",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: setBtn(
                    text: "Start Another",
                    backgroundColor: GlobalColors.firstColor,
                    action: (){
                      print(userDetail.roundNo);
                      print(userDetail.cateId);
                      if(userDetail.roundNo == null  && userDetail.cateId == null){
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => CatagoriesView(userId: userDetail.id.toString(),)));
                      }else{
                        //TODO:catId is hardcoded... when this is setup in the api we need to change with that id...
                        if(userDetail.roundNo == '3'){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => CatagoriesView(userId: userDetail.id.toString(),firstName: userDetail.firstName,)));
                        }else{
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => Rounds(idNoti: userDetail.id.toString(),catId: userDetail.cateId.toString(),firstName: userDetail.firstName,)));
                        }


                      }

                    }
                  ),
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: setBtn(
                      text: "Chat",
                      backgroundColor: GlobalColors.firstColor,
                      action: (){
                        //Link Chat screen hereeee.....
                      }
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16,),
        ],
      ),
    );
  }


  //Button

  Widget setBtn({String text,Color backgroundColor, IconData icon,Color iconColor , double radius, double size, VoidCallback action}){
    return CustomRaisedButton(
      buttonText: text,
      cornerRadius: 5.0,
      textColor: Colors.white,
      backgroundColor: backgroundColor,
      borderWith: 0.0,
      action: action,
    );

  }

  // Details tab...
  Widget infoTab(String title, String val,String sperateBy) {
    var lstItems =  val.split(sperateBy);

    if (title == "Single"){
      List<String> vl = List<String>();
      for(int i=0; i<single.length;i++){
        for(int j=0; j<lstItems.length;j++){
          if (single[i].value.contains(lstItems[j])){
            vl.add(single[i].text);
            break;
          }
        }
      }
      lstItems = vl;

    }else if (title == "Partner Expectations"){
      List<String> vl = List<String>();
      for(int i=0; i<partner.length;i++){
        for(int j=0; j<lstItems.length;j++){
          if (partner[i].value.contains(lstItems[j])){
            vl.add(partner[i].text);
            break;
          }
        }
      }
      lstItems = vl;
    }
    return Card(
      shadowColor: Colors.blueGrey,
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              ' '+title,
              style: TextStyle(
                fontSize: GlobalFont.textFontSize,
                color: Colors.black,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 8,),
            (lstItems.length == 1||title=="Address"||title=="Average Income")? Container(
              margin: const EdgeInsets.only(top: 16,bottom: 16,left: 8,right: 8),
              child: Text(
                val,
                style: TextStyle(
                    fontSize: GlobalFont.textFontSize ,
                    color: Colors.grey
                ),
              ),
            ):Container(
              height: 40*lstItems.length.toDouble(),
              child: ListView.builder(
                  physics:  NeverScrollableScrollPhysics(),
                  itemCount: lstItems.length,
                  itemBuilder: (context,index){
                    return Container(
                      margin: const EdgeInsets.only(top: 8,bottom: 8,left: 8,right: 8),
                      child: Text(
                      capitalizeFirstLetter(lstItems[index]),
                        style: TextStyle(
                            fontSize: GlobalFont.textFontSize - 2,
                            color: Colors.grey
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  ///API Call
  FetchUserDetails() {

    Map<String, dynamic> body = {
    };
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.get,authorization: true, url: WebService.userAnswers+'/'+widget.userId,body: body,isFormData: true).then(
              (response) async {
            if (response.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(response.body);
              if(responseJson.containsKey('success')) {
                // print("Responseee----->>>>${responseJson}");
                userDetail = UserDetail.fromJson(responseJson["success"]);
                singleJson['single'].forEach((v) {
                  single.add(QaOptions.fromJson(v));
                });
                partnerJson['partner'].forEach((v){
                  partner.add(QaOptions.fromJson(v));
                });

                loading =false;
                setState(() {});
              } else{
                print("Oh no response");
              }

            }else if (response.statusCode == 401){
              loading =false;
              setState(() {});
              GFunction.showError(response.body["error"].toString(), context);

            }else{
              loading =false;
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


  capitalizeFirstLetter(String strg){
    return strg.replaceAll("_", " ").split(" ").map((str) => '${str[0].toUpperCase()}${str.substring(1)}').join(" ");
  }

}
