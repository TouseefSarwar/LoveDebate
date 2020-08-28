import 'dart:convert';

import 'package:app_push_notifications/Models/UserDetailModel.dart';
import 'package:app_push_notifications/Utils/Constants/WebService.dart';
import 'package:app_push_notifications/Utils/Controllers/ApiBaseHelper.dart';
import 'package:app_push_notifications/Utils/Controllers/AppExceptions.dart';
import 'package:app_push_notifications/Utils/Controllers/Loader.dart';
import 'package:app_push_notifications/Utils/Designables/CustomAppBar.dart';
import 'package:app_push_notifications/Utils/Globals/Fonts.dart';
import 'package:app_push_notifications/Utils/Globals/GlobalFunctions.dart';
import 'package:app_push_notifications/Utils/Globals/UserSession.dart';
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50,),
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    child: ClipOval(
                      child: Image.asset('images/conor.jpg',height: 120,width: 120,fit: BoxFit.cover,),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Text(
                  (userDetail.firstName != null)?userDetail.firstName +' '+ userDetail.lastName: "Test User",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
                SizedBox(height: 16,),

                (userDetail.gender!=null) ? infoTab("Gender", userDetail.gender.toString()):Container(),
                (userDetail.dob!=null) ? infoTab("Date of Birth", userDetail.dob.toString()):Container(),
                (userDetail.city!=null) ? infoTab("Address", userDetail.city.toString()+","+userDetail.state.toString()):Container(),
                (userDetail.prMatchArea!=null) ? infoTab("Match Area", userDetail.prMatchArea.toString()):Container(),
                (userDetail.prHeight!=null) ? infoTab("Height Preference", userDetail.prHeight.toString()):Container(),
                (userDetail.prSerious!=null) ? infoTab("Serious", userDetail.prSerious.toString()):Container(),
                (userDetail.prProfession!=null) ? infoTab("Profession", userDetail.prProfession.toString()):Container(),
                (userDetail.prAverageIncome!=null) ? infoTab("Average Income", userDetail.prAverageIncome.toString()):Container(),
                (userDetail.prGoals!=null) ? infoTab("Goals", userDetail.prGoals.toString()):Container(),
                (userDetail.prExpectations!=null) ? infoTab("Partner Expectation", userDetail.prExpectations.toString()):Container(),
                (userDetail.prCharacteristic!=null) ? infoTab("Characteristic", userDetail.prCharacteristic.toString()):Container(),
                (userDetail.prIe!=null) ? infoTab("IE", userDetail.prIe.toString()):Container(),
                (userDetail.prSingle!=null) ? infoTab("Single", userDetail.prSingle.toString()):Container(),
                (userDetail.prSingleDislikes!=null) ? infoTab("Single Dislikes", userDetail.prSingleDislikes.toString()):Container(),
                (userDetail.faith!=null) ? infoTab("Faith", userDetail.faith.toString()):Container(),
                (userDetail.prFaithDislikes!=null) ? infoTab("Faith Dislikes", userDetail.prFaithDislikes.toString()):Container(),
                (userDetail.prReligious!=null) ? infoTab("Religious", userDetail.prReligious.toString()):Container(),
                (userDetail.ethnicity!=null) ? infoTab("Ethnicity", userDetail.ethnicity.toString()):Container(),
                (userDetail.prEthnicityDislikes!=null) ? infoTab("Ethnicity Dislikes", userDetail.prEthnicityDislikes.toString()):Container(),

              ],
            ),
          ),
        ):Center(child: Loading(),),
    );
  }

  // Details tab...
  Padding infoTab(String title, String val) {
    return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: GlobalFont.textFontSize,
                        color: Colors.black
                      ),
                    ),

                    Text(
                      val,
                      style: TextStyle(
                          fontSize: GlobalFont.textFontSize - 2,
                          color: Colors.grey
                      ),
                    )
                  ],
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
                print("Responseee----->>>>${responseJson}");
                userDetail = UserDetail.fromJson(responseJson["success"]);
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



}
