import 'dart:convert';
import 'dart:math';
import 'package:app_push_notifications/Modules/Chat/ChatBloc/blocProvider.dart';
import 'package:app_push_notifications/Modules/Chat/ChatBloc/chatBloc.dart';
import 'package:http/http.dart' as http;

import 'package:app_push_notifications/Models/ListModel.dart';
import 'package:app_push_notifications/Models/PreMatches.dart';
import 'package:app_push_notifications/Screens/SubViews/RoundsListingCell.dart';
import 'package:app_push_notifications/Utils/Constants/WebService.dart';
import 'package:app_push_notifications/Utils/Controllers/ApiBaseHelper.dart';
import 'package:app_push_notifications/Utils/Controllers/Loader.dart';
import 'package:app_push_notifications/Utils/Designables/Toast.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:app_push_notifications/Modules/PreMatches/Catagories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_push_notifications/Utils/Designables/CustomAppBar.dart';
import 'package:app_push_notifications/Utils/Controllers/AppExceptions.dart';
import 'package:app_push_notifications/Utils/Globals/Fonts.dart';


class PreMatches extends StatefulWidget {
  @override
  _PreMatchesState createState() => _PreMatchesState();
}

class _PreMatchesState extends State<PreMatches> {

  List<Matches> matches = List<Matches>();
  int apiCall=0;
  var bloc;
  //For Avatar Colors
  List<int> colorsR = [0xFF9055A2,0xFFF7C548,0xFFFF66D8,0xFFDC493A,0xFF4392F1,0xFF3D0814,0xFFF7EC59,0xFFFF66D8,0xFFA98743,0xFFEEEBD3,0xFF011638];

  @override
  void initState() {
    funPreMatches();
    apiCall=1;
    super.initState();
    bloc = BlocProvider.of<ChatBloc>(context).createSocketConnection();
  }

  String dateofBirth;
  @override
  Widget build(BuildContext context) {
    double height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double width=MediaQuery.of(context).size.width-90;
    double itemheight =(15/100)*height;
    return Scaffold(
      appBar: CustomAppbar.setNavigationWithOutBack("Pre Matches"),

      body: SafeArea(
        child:(apiCall==0)? (matches.length>0)? ListView.builder(
          itemCount: matches.length,
          itemBuilder: (context,index){
            return RoundListingCell(
              title: 'Start Round',
              gender: (matches[index].gender!=null)?(matches[index].gender==1)?'Male':'Female':"N/A",
              age: (matches[index].dob!= null)?(DateTime.now().difference(DateTime.parse(matches[index].dob)).inDays/365).floor().toString():"N/A",
              personHeight:(matches[index].height==null )? "N/A" :matches[index].height,
              height: itemheight,
              width: width,
              data: (matches[index].firstName!=null)?matches[index].firstName[0].toString():'',
              address: (matches[index].city!=null && matches[index].state!=null)?"${matches[index].city}, ${matches[index].state}":"Address not found",
              iconColor: GlobalColors.firstColor,
              index: index,
              avatarColor: Color(colorsR[Random().nextInt(colorsR.length)]),
              action: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context) => CatagoriesView(roundDetail:  matches[index],)));
              },
            );
          },
        ): Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              '''No matches found.
              
 Please make some changes to your preferences and filters and try again.
              ''',
              maxLines: 5,
              style: TextStyle(
                fontSize: GlobalFont.textFontSize,
                color: GlobalColors.secondColor
              ),
              textAlign: TextAlign.center,
            ),),
        ) :Center(child: Loading(),),
      ),
    );



  }

  void funPreMatches(){
    Map<String, dynamic> body = {

    };
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.get,authorization: true, url: WebService.prematches,body: body,isFormData: false).then(
              (response){
            var res = response as http.Response;
            if (res.statusCode == 200){
              var data=List<Matches>();
              Map<String, dynamic> responseJson = json.decode(res.body);
              if(responseJson.containsKey('success')){
                print("HEre is yourrr response : ${responseJson["success"]}");
                responseJson["success"].forEach((v) {
                  Matches item = Matches.fromJson(v);
                  print(item.height);
                  data.add(Matches.fromJson(v));
                });
                setState(() {
                  matches=data;
                  apiCall=0;
                });
              }else{
                print("Oh no response");
              }

            }else if (res.statusCode == 401){
              Toast.show(res.reasonPhrase.toString(), context, duration: Toast.LENGTH_LONG);
            }else{
              Toast.show(res.reasonPhrase.toString(), context, duration: Toast.LENGTH_LONG);
            }
          });
    } on FetchDataException catch(e) {
      setState(() {

      });
    }
  }


}

InkWell PreMatchesItem(double itemheight, double width, String text, Color background,BuildContext context) {
  return InkWell(
    onTap: (){
      Navigator.push(context, CupertinoPageRoute(builder: (context) => CatagoriesView()));
    },

    child: Container(
      height: itemheight,
      width: width,
// color: Colors.black,
      child: Card(
        elevation: 5,
        child: Row(
          children: <Widget>[
            SizedBox(width: 8,),
            Stack(
              children: <Widget>[
                Container(
                    width: 75,
                    height: 75,
// margin: EdgeInsets.only(left: 24),
                    decoration: new BoxDecoration(
                      color: background,
                      shape: BoxShape.circle,
                    )
                ),
                Container(
                    width: 75,
                    height: 75,
                    decoration: new BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      shape: BoxShape.circle,
                    )
                ),
                Container(
                  width: 75,
                  height: 75,
                  child: Center(
                    child: Text(
                      text,style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

              ],
            ),
            Expanded(
              child: Container(
                height: itemheight,
                margin: EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Start Round", maxLines: 2,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold ,color:Color(0xff2E3032)),),
                    SizedBox(height: 4,),
                    Text("This is a start round description.... it is test for double line",style: TextStyle(fontSize: 15,color:Color(0xff2E3022)))
                  ],
                ),
              ),
            ),
            SizedBox(width: 8,),
            Container(
              height: itemheight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.navigate_next,size: 35,color: GlobalColors.firstColor),
                ],
              ),
            ),
          ],
        ),

      ),
    ),
  );
}


