import 'dart:convert';
import 'dart:math';
import 'package:app_push_notifications/Models/MatchedModel.dart';
import 'package:app_push_notifications/Modules/OtherProfile/OtherProfile.dart';
import 'package:app_push_notifications/Screens/SubViews/MatchListingCell.dart';
import 'package:app_push_notifications/Utils/Constants/WebService.dart';
import 'package:app_push_notifications/Utils/Controllers/ApiBaseHelper.dart';
import 'package:app_push_notifications/Utils/Controllers/Loader.dart';
import 'package:app_push_notifications/Utils/Globals/GlobalFunctions.dart';
import 'package:http/http.dart' as http;
import 'package:app_push_notifications/Screens/SubViews/RoundsListingCell.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:app_push_notifications/Screens/TabBarcontroller.dart';
import 'package:app_push_notifications/Utils/Designables/CustomAppBar.dart';
import 'package:app_push_notifications/Utils/Designables/CustomButtons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_push_notifications/Utils/Controllers/AppExceptions.dart';

class Matched extends StatefulWidget {
  @override
  _MatchedState createState() => _MatchedState();
}

class _MatchedState extends State<Matched> {


  int apiCall = 0;
  List<MatchedModel> matchedUsers = List<MatchedModel>();
  //For Avatar Colors
  List<int> colorsR = [0xFF9055A2,0xFFF7C548,0xFFFF66D8,0xFFDC493A,0xFF4392F1,0xFF3D0814,0xFFF7EC59,0xFFFF66D8,0xFFA98743,0xFFEEEBD3,0xFF011638];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMatchedData();
  }

  @override
  Widget build(BuildContext context) {

    double height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double width=MediaQuery.of(context).size.width;
    double _itemheight =(15/100)*height;

    return Scaffold(
      appBar: CustomAppbar.setNavigationWithOutBack("Matched"),

      body: apiCall == 0 ? SafeArea(
        child: matchedUsers.length > 0 ? ListView.builder(
          itemCount: matchedUsers.length,
          itemBuilder: (context,index){
            return RoundListingCell(
              title: "Completed Round: 1",
              gender: "Male",
              age: "30",
              personHeight: "5'4",
              height: _itemheight,
              width: width,
              data: matchedUsers[index].userName[0],
              avatarColor: Color(colorsR[Random().nextInt(colorsR.length)]),
              address: "N/A",
              iconColor: GlobalColors.firstColor,
              index: index,
//              img: WebService.baseURL+"/"+matchedUsers[index].profilePic,
              action: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => OtherProfile(userId: matchedUsers[index].userId.toString(),)));
              },
            );
          },
        ): Center(
          child: Text(
            'No Matches Found.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 19
            ),
          ),
        ),
      ):Center(child: Loading(),),
    );
  }

  Card MatchedScreensItem(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Container(
        height: 90,
        // color: Colors.blue,
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ProfileImageContainer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Completed Rounds : 1",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                        //5 Icon(Icons.chat,size: 25,)
                      ],
                    ),
                    SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 4 - 5 ,
                          height: 28,
                          child: CustomRaisedButton(
                            buttonText: 'Modules',
                            cornerRadius: 5,
                            textColor: Colors.white,
                            backgroundColor:GlobalColors.firstColor,
                            borderWith: 0,
                            action: (){
                              setState(() {
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 4,),
                        Container(
                          width: MediaQuery.of(context).size.width / 4 - 5,
                          height: 28,
                          child: CustomRaisedButton(
                            buttonText: 'Request',
                            cornerRadius: 5,
                            textColor: Colors.white,
                            backgroundColor:GlobalColors.firstColor,
                            borderWith: 0,
                            action: (){
                              setState(() {
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 4,),
                        Container(
                          width: MediaQuery.of(context).size.width / 4 - 5,
                          height: 28,
                          child: CustomRaisedButton(
                            buttonText: 'Chat',
                            cornerRadius: 5,
                            textColor: Colors.white,
                            backgroundColor:GlobalColors.firstColor,
                            borderWith: 0,
                            action: (){
                              setState(() {
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container MatchedItems(double width, BuildContext context,) {
    return Container(
      height:190,
      //width: width,
      //color: Colors.red,
      margin: EdgeInsets.all(2),
      child: Card(
        elevation: 1,
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              //color: Colors.cyan,
              child: Row(
                children: <Widget>[
                  ProfileImageContainer(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Completed Rounds : 1",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),

                      ],
                    ),
                  ),
                  Container(
                      height: 42,
                      margin: EdgeInsets.all(8),
                      child: Icon(Icons.chat,size: 35,color:Colors.grey,))

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomRaisedButton(
                    buttonText: 'View Modules.Profile',
                    cornerRadius: 5,
                    textColor: Colors.white,
                    backgroundColor:GlobalColors.firstColor,
                    borderWith: 0,
                    action: (){
                      setState(() {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
                      });
//
                    },
                  ),
                  SizedBox(width: 8,),
                  CustomRaisedButton(
                    buttonText: 'Request another',
                    cornerRadius: 5,
                    textColor: Colors.white,
                    backgroundColor:GlobalColors.firstColor,
                    borderWith: 0,
                    action: (){
                      setState(() {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
                      });
//
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container ProfileImageContainer() {
    return Container(
        width: 60,
        height:60,
        margin: EdgeInsets.all(12),
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/conor.jpg")

//                image: new NetworkImage(
//                    "https://i.imgur.com/BoN9kdC.png")
            )
        ));
  }


  getMatchedData(){
    Map<String, dynamic> body= {};
    apiCall = 1;
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post,authorization: true, url: WebService.chatUsersList,body: body,isFormData: true).then(
              (response) async{
            var res = response as http.Response;
            if (res.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(res.body);
              if(responseJson.containsKey('success')){
               print("response is =====> ${responseJson['success']}");
                responseJson["success"].forEach((v) {
                  MatchedModel item = MatchedModel.fromJson(v);
                  matchedUsers.add(MatchedModel.fromJson(v));
                });
                apiCall = 0;
                setState(() {});
              }else{
                apiCall = 0;
                setState(() {});
              }
            }else if (res.statusCode == 401){
              apiCall = 0;
              setState(() {});
              Map<String, dynamic> err = json.decode(res.body);
              GFunction.showError(err['error'].toString(), context);
            }else{
              apiCall = 0;
              setState(() {});
              GFunction.showError(res.reasonPhrase.toString(), context);
            }
          });
    } on FetchDataException catch(e) {
      apiCall = 0;
      setState(() {});
      GFunction.showError(e.toString(), context);
    }
  }

}




