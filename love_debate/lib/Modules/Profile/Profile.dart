import 'dart:convert';
import 'dart:io';
import 'package:app_push_notifications/Models/UserDetailModel.dart';
import 'package:app_push_notifications/Modules/Preferences/PreferencesOnBoarding.dart';
import 'package:app_push_notifications/Modules/Profile/GeneralSettings.dart';
import 'package:app_push_notifications/Utils/Constants/SharedPref.dart';
import 'package:app_push_notifications/Utils/Constants/WebService.dart';
import 'package:app_push_notifications/Utils/Controllers/ApiBaseHelper.dart';
import 'package:app_push_notifications/Utils/Controllers/AppExceptions.dart';
import 'package:app_push_notifications/Utils/Controllers/Loader.dart';
import 'package:app_push_notifications/Utils/Globals/AnswersGlobals.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_push_notifications/Modules/Profile/BasicInfo.dart';
import 'package:app_push_notifications/Utils/Designables/CustomAppBar.dart';
import 'package:app_push_notifications/Utils/Globals/Fonts.dart';
import 'package:app_push_notifications/Utils/Globals/GlobalFunctions.dart';
import 'package:app_push_notifications/Utils/Globals/UserSession.dart';
import 'package:image_picker/image_picker.dart';

import 'CameraDialog.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SharedPref prf = SharedPref();
  bool loading = false;
 dynamic selectedImage;

  File image;
  final picker = ImagePicker();
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Upper Body
              SizedBox(height: 50,),
              Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60,
                      backgroundImage:  ( UserSession.userData.profilePic == null)? NetworkImage("${UserSession.userData.profilePic}")
                          :AssetImage('images/dummy.png'),
                      backgroundColor: Colors.transparent,
                    ),
                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: InkWell(
                        onTap: (){
                          showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) {
                                return CameraDialog();
                              }
                          ).then((value){
                            print("Value is: $value");
                            if (value != null){
                              switch (value){
                                case "gallery":
                                  openGallery();
                                  break;
                                case "camera":
                                  openCamera();
                                  break;
                              }
                              selectedImage=value;
                            }


                            setState(() {});
                          });

                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: GlobalColors.firstColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
              SizedBox(height: 16,),
              Text(
                (UserSession.userData != null) ?UserSession.userData.firstName+" "+UserSession.userData.lastName : "",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
              SizedBox(height: 30,),
              ProfileListItems("Basic Info",Icons.info_outline,1),
              ProfileListItems("General Settings",Icons.settings,3),
              // ProfileListItems("Notifications",Icons.notifications,4),
              ProfileListItems("Preferences",Icons.filter_list,5),
              ProfileListItems("Deactivate Account",Icons.cancel,6),
              ProfileListItems("Logout",Icons.power_settings_new,7),
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
             Navigator.push(context, CupertinoPageRoute(builder: (context) => PreferencesOnBoarding()));
            break;
          case 6:
//              Navigator.push(context, CupertinoPageRoute(builder: (context) => BasicInfo()));
            break;
          case 7:
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
        ],
      ),
    );
  }


  ///Image Picker


  Future openCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if(pickedFile != null){
      image = File(pickedFile.path);
      UpdateProfileImage(image);
      setState(() {});
    }
  }
  Future openGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 50);
    if(pickedFile != null){
      image = File(pickedFile.path);
      UpdateProfileImage(image);
      setState(() {});
    }


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
                if (await prf.containKey(UserSession.authTokenkey)){
                  AnswersGlobal.questions.clear();
                  AnswersGlobal.answers.clear();
                  AnswersGlobal.questionIndex = -1;
                  await prf.remove(UserSession.authTokenkey);
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
                print(UserSession.userData.profilePic);
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


  ///Upload Profile Photo.... Set Profile Image



  UpdateProfileImage(File imageFile) async{
    Response response;
    FormData formData = new FormData.fromMap({
      "type": "profile",
      "file": await MultipartFile.fromFile(imageFile.path,filename: "${DateTime.now().toString()}-${imageFile.path.split('/').last}"),
    });

    Dio dio = new Dio();
    print(WebService.baseURL+WebService.uploadProfileImage);
    response = await dio.post(WebService.baseURL+WebService.uploadProfileImage,
      data: formData,
      options :Options(
        headers: {
          Headers.wwwAuthenticateHeader:"Bearer ${UserSession.authToken}", // set content-length
        },
      ),
      onSendProgress: (int send, int total){print("Send: ${send}, Total: ${total} ");},
    );
    print("The result is: ${response.statusCode}");
    print("The response is: ${response}");
  }





}
