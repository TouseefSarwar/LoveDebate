import 'dart:convert';
import 'package:lovedebate/Models/UserDetailModel.dart';
import 'package:lovedebate/Modules/Profile/GeneralSettings.dart';
import 'package:lovedebate/Utils/Constants/SharedPref.dart';
import 'package:lovedebate/Utils/Constants/WebService.dart';
import 'package:lovedebate/Utils/Controllers/ApiBaseHelper.dart';
import 'package:lovedebate/Utils/Controllers/AppExceptions.dart';
import 'package:lovedebate/Utils/Controllers/Loader.dart';
import 'package:lovedebate/Utils/Globals/AnswersGlobals.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lovedebate/Modules/Profile/BasicInfo.dart';
import 'package:lovedebate/Utils/Globals/CustomAppBar.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';
import 'package:lovedebate/Utils/Globals/GlobalFunctions.dart';
import 'package:lovedebate/Utils/Globals/UserSession.dart';

import 'CameraDialog.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SharedPref prf = SharedPref();
  bool loading = false;

  String image='images/conor.jpg';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loading= true;
    setState(() {
      FetchUserDetails();
    });

  }

  @override
  Widget build(BuildContext context) {
    double height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double width=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppbar.setNavigationWithOutBack("Profile"),

      body: (!loading)? SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Upper Body
              Stack(
                  children: <Widget>[
                    //Gradient Background...
                    Container(
                      height: (30/100)*height,
                      width: width,
                       //color: Colors.white,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white
                            ]
                        ),
                      ),
                    ),
                    //Overlay
                    Container(
                      height: (30/100)*height,
                      width: width,
                      color: Colors.white,
                      padding: EdgeInsets.only(bottom: 8),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          (UserSession.userData != null) ?UserSession.userData.firstName+" "+UserSession.userData.lastName : "",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: ((30/100)*height) / 2 - 70,
                      left: width / 2 - 60,
                      child: Container(
                        alignment: Alignment.center,
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('images/conor.jpg'),
                              fit: BoxFit.fitHeight
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: ((55/100)*height) / 2 - 70,
                      left: width / 1.6 - 30,
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return CameraDialog();
                                }
                            ).then((value){
                              var img=value;
                              print(img);
                            });

                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(360))
                            ),
                            child: Icon(Icons.camera_alt,color: GlobalColors.firstColor,)),
                      ),
                    )

                  ]
              ),
              SizedBox(height: 8,),
              ProfileListItems("Basic Info",Icons.info_outline,1),
//              ProfileListItems("Preferences & Filters",Icons.menu,2),
              ProfileListItems("General Settings",Icons.settings,3),
              ProfileListItems("Notifications",Icons.notifications,4),
              ProfileListItems("Deactivate Account",Icons.cancel,5),
              ProfileListItems("Logout",Icons.power_settings_new,6),
            ],
          ),
        ),
      ): Center(child: Loading(),),
    );
  }

  InkWell ProfileListItems(String text,IconData icon,int screenNo) {
    return InkWell(
      onTap: (){
          switch(screenNo){
            case 1:
              Navigator.push(context, CupertinoPageRoute(builder: (context) => BasicInfo()));
              break;
            case 2:
//              Navigator.push(context, CupertinoPageRoute(builder: (context) => PreferencesOnBoarding()));
              break;
            case 3:
              Navigator.push(context, CupertinoPageRoute(builder: (context) => GeneralSettings()));
              break;
            case 4:
//              Navigator.push(context, CupertinoPageRoute(builder: (context) => BasicInfo()));
              break;
            case 5:
//              Navigator.push(context, CupertinoPageRoute(builder: (context) => BasicInfo()));
              break;
            case 6:
              loading = true;
              setState(() {
                logoutUserSession();
              });
              break;
            default:
              print("Nothing to do");
              break;
          }

      },
      child: Column(
        children: <Widget>[
          Card(
            elevation: 3.0,
            child: Container(
              height: 50,
              margin: EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 12,),
                    Icon(icon,color: GlobalColors.firstColor,size: 28,),
                    SizedBox(width: 12,),
                    Expanded(child: Text(text,style: TextStyle(fontSize: GlobalFont.textFontSize, fontWeight: FontWeight.w500),)),
                    SizedBox(width: 8,),
                    Icon(Icons.edit,size: 20,color: Colors.blueGrey,),
                    SizedBox(width: 8,),
                  ],
                ),
              ),
          ),

//          Padding(
//            padding: const EdgeInsets.only(right: 16, left: 16),
//            child: Container(
//              height: 1,
//              color:  GlobalColors.firstColor,//Colors.grey,
//            ),
//          )
        ],
      ),
    );
  }


  ///Logout Api Call
    logoutUserSession(){

      Map<String, dynamic> body = {};
      try {
        ApiBaseHelper().fetchService(method: HttpMethod.get,authorization: true, url: WebService.logout,body: body,isFormData: true).then(
                (response) async {

              if (response.statusCode == 200){
                Map<String, dynamic> responseJson = json.decode(response.body);
                if(responseJson.containsKey('success')) {
                  if (await prf.containKey(UserSession.tokenkey)){
                    AnswersGlobal.questions.clear();
                    AnswersGlobal.answers.clear();
                    AnswersGlobal.questionIndex = -1;
                    await prf.remove(UserSession.tokenkey);
                    await prf.remove(UserSession.answers);
                    await prf.remove(UserSession.question);
                    await prf.remove(UserSession.email);
                    Navigator.of(context).pushReplacementNamed('/Login');
                  }
                } else{
                }

              }else if (response.statusCode == 401){
                loading=false;
                setState(() {});
                GFunction.showError(response.body["error"].toString(), context);
              }else{
                loading=false;
                setState(() {});
                GFunction.showError(response.reasonPhrase.toString(), context);
              }
            });

      } on FetchDataException catch(e) {
        loading=false;
        setState(() {});
        GFunction.showError(e.toString(), context);
      }
    }

  ///UserDetails
  FetchUserDetails() {

    Map<String, dynamic> body = {

    };
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.get,authorization: true, url: WebService.userAnswers,body: body,isFormData: true).then(
              (response) async {
            List<String> val = List<String>();
            if (response.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(response.body);
              if(responseJson.containsKey('success')) {
                UserSession.userData = null;
                UserSession.userData = UserDetail.fromJson(responseJson["success"]);
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
