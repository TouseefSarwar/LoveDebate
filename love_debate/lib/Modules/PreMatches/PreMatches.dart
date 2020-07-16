//import
//import 'package:lovedebate/Models/ListModel.dart';
//import 'package:lovedebate/Screens/SubViews/RoundsListingCell.dart';
//import 'package:lovedebate/Utils/Globals/Colors.dart';
//import 'package:lovedebate/Modules/PreMatches/Catagories.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:lovedebate/Utils/Globals/CustomAppBar.dart';
//
//class PreMatches extends StatefulWidget {
//  @override
//  _PreMatchesState createState() => _PreMatchesState();
//}
//
//class _PreMatchesState extends State<PreMatches> {
//
//  List<ListModel> list = [ ListModel(title: "Start Round" ,colorCell: Colors.blue ),
//    ListModel(title: "Start Round" ,colorCell: Colors.green),
//    ListModel(title: "Start Round" ,colorCell: Colors.redAccent),
//    ListModel(title: "Start Round" ,colorCell: Colors.purple),
//    ListModel(title: "Start Round" ,colorCell: Colors.yellow),
//    ListModel(title: "Start Round" ,colorCell: Colors.pink),
//    ListModel(title: "Start Round" ,colorCell: Colors.indigo)
//  ];
//
//
//  @override
//  Widget build(BuildContext context) {
//    double height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
//    double width=MediaQuery.of(context).size.width-90;
//    double itemheight =(15/100)*height;
//    return Scaffold(
//      appBar: CustomAppbar.setNavigation("Pre Matches"),
//
//      body: SafeArea(
//        child:ListView.builder(
//          itemCount: list.length,
//          itemBuilder: (context,index){
//            return RoundListingCell(
//              title: list[index].title,
//              gender: "Male",
//              age: "30",
//              personHeight: "5'4",
//              height: itemheight,
//              width: width,
//              data: "A",
//              avatarColor: list[index].colorCell,
//              iconColor: GlobalColors.firstColor,
//              index: index,
//              action: (){
//                Navigator.push(context, CupertinoPageRoute(builder: (context) => Catagories()));
//              },
//            );
//          },
//        ),
////        ListView(
////          children: <Widget>[
////
////            RoundListingCell(
////              title: "Start Round",
////              gender: "Male",
////              age: "30",
////              personHeight: "5'4",
////              height: _itemheight,
////              width: _width,
////              data: "A",
////              avatarColor: Colors.pink,
////              iconColor: GlobalColors.firstColor,
////            ),
////            RoundListingCell(
////                title: "Start Round",
////                gender: "Male",
////                age: "30",
////                personHeight: "5'4",
////                height: _itemheight,
////                width: _width,
////                data: "S",
////                avatarColor: Colors.blue,
////                iconColor:  GlobalColors.firstColor
////            ),
////            RoundListingCell(
////                title: "Start Round",
////                gender: "Male",
////                age: "30",
////                personHeight: "5'4",
////                height: _itemheight,
////                width: _width,
////                data: "F",
////                avatarColor: Colors.yellow,
////                iconColor:  GlobalColors.firstColor
////            ),
////            RoundListingCell(
////                title: "Start Round",
////                gender: "Male",
////                age: "30",
////                personHeight: "5'4",
////                height: _itemheight,
////                width: _width,
////                data: "G",
////                avatarColor: Colors.green,
////                iconColor: Colors.grey
////            ),
////            RoundListingCell(
////                title: "Start Round",
////                gender: "Male",
////                age: "30",
////                personHeight: "5'4",
////                height: _itemheight,
////                width: _width,
////                data: "H",
////                avatarColor: Colors.purple,
////                iconColor: Colors.grey
////            ),
////            RoundListingCell(
////                title: "Start Round",
////                gender: "Male",
////                age: "30",
////                personHeight: "5'4",height: _itemheight,
////                width: _width,
////                data: "N",
////                avatarColor: Colors.teal,
////                iconColor: Colors.grey
////            ),
//////              PreMatchesItem(_itemheight, _width, "A",Colors.green,context),
//////
//////              PreMatchesItem(_itemheight, _width, "M",Colors.blue,context),
//////              PreMatchesItem(_itemheight, _width, "B",Colors.pink,context),
////          ],
////        ),
//      ),
//    );
//  }
//
//}
//
//InkWell PreMatchesItem(double itemheight, double width, String text, Color background,BuildContext context) {
//  return InkWell(
//    onTap: (){
//      Navigator.push(context, CupertinoPageRoute(builder: (context) => Catagories()));
//    },
//
//    child: Container(
//      height: itemheight,
//      width: width,
//      // color: Colors.black,
//      child: Card(
//        elevation: 5,
//        child: Row(
//          children: <Widget>[
//            SizedBox(width: 8,),
//            Stack(
//              children: <Widget>[
//                Container(
//                    width: 75,
//                    height: 75,
//                    // margin: EdgeInsets.only(left: 24),
//                    decoration: new BoxDecoration(
//                      color: background,
//                      shape: BoxShape.circle,
//                    )
//                ),
//                Container(
//                    width: 75,
//                    height: 75,
//                    decoration: new BoxDecoration(
//                      color: Colors.black.withOpacity(0.2),
//                      shape: BoxShape.circle,
//                    )
//                ),
//                Container(
//                  width: 75,
//                  height: 75,
//                  child: Center(
//                    child: Text(
//                      text,style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
//                    ),
//                  ),
//                ),
//
//              ],
//            ),
//            Expanded(
//              child: Container(
//                height: itemheight,
//                margin: EdgeInsets.only(left: 16),
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text("Start Round", maxLines: 2,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold ,color:Color(0xff2E3032)),),
//                    SizedBox(height: 4,),
//                    Text("This is a start round description.... it is test for double line",style: TextStyle(fontSize: 15,color:Color(0xff2E3022)))
//                  ],
//                ),
//              ),
//            ),
//            SizedBox(width: 8,),
//            Container(
//              height: itemheight,
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.end,
//                children: <Widget>[
//                  Icon(Icons.navigate_next,size: 35,color: GlobalColors.firstColor),
//                ],
//              ),
//            ),
//          ],
//        ),
//
//      ),
//    ),
//  );
//}

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:lovedebate/Models/ListModel.dart';
import 'package:lovedebate/Models/PreMatches.dart';
import 'package:lovedebate/Screens/SubViews/RoundsListingCell.dart';
import 'package:lovedebate/Utils/Constants/WebService.dart';
import 'package:lovedebate/Utils/Controllers/ApiBaseHelper.dart';
import 'package:lovedebate/Utils/Controllers/Loader.dart';
import 'package:lovedebate/Utils/Designables/Toast.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Modules/PreMatches/Catagories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Utils/Globals/CustomAppBar.dart';
import 'package:lovedebate/Utils/Controllers/AppExceptions.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';


class PreMatches extends StatefulWidget {
  @override
  _PreMatchesState createState() => _PreMatchesState();
}

class _PreMatchesState extends State<PreMatches> {

  List<Matches> matches = List<Matches>();
  int apiCall=0;

  List<ListModel> list = [ ListModel(title: "Start Round" ,colorCell: Colors.blue ),
    ListModel(title: "Start Round" ,colorCell: Colors.green),
    ListModel(title: "Start Round" ,colorCell: Colors.redAccent),
    ListModel(title: "Start Round" ,colorCell: Colors.purple),
    ListModel(title: "Start Round" ,colorCell: Colors.yellow),
    ListModel(title: "Start Round" ,colorCell: Colors.pink),
    ListModel(title: "Start Round" ,colorCell: Colors.indigo)
  ];

  @override
  void initState() {
    funPreMatches();
    apiCall=1;
    super.initState();
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
              gender: (matches[index].gender!=null)?(matches[index].gender==0)?'Male':'Female':" ",
//              age: (matches[index].dob!=null)?matches[index].dob:'',
              age: '25',
              personHeight:(matches[index].height!=null || matches[index].height!="")? matches[index].height: " ",
              height: itemheight,
              width: width,
              data: (matches[index].firstName!=null)?matches[index].firstName[0].toString():'',
              address: (matches[index].address!=null)?matches[index].address:'',
              avatarColor: Colors.red,
              iconColor: GlobalColors.firstColor,
              index: index,
              action: (){
//DateTime dob = DateTime.parse(matches[index].dob);
                DateTime dob = DateTime.parse('1967-10-12');
                Duration dur = DateTime.now().difference(dob);
                String differenceInYears = (dur.inDays/365).floor().toString();
                print(differenceInYears);
                Navigator.push(context, CupertinoPageRoute(builder: (context) => Catagories()));
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
//              "No matches found.\n\nPlease make some changes to your preferences and filters and try again.",
              maxLines: 5,
              style: TextStyle(
                fontSize: GlobalFont.textFontSize,
                color: GlobalColors.secondColor
              ),
              textAlign: TextAlign.center,
            ),),
        ) :Center(child: Loading(),),
// ListView(
// children: <Widget>[
//
// RoundListingCell(
// title: "Start Round",
// gender: "Male",
// age: "30",
// personHeight: "5'4",
// height: _itemheight,
// width: _width,
// data: "A",
// avatarColor: Colors.pink,
// iconColor: GlobalColors.firstColor,
// ),
// RoundListingCell(
// title: "Start Round",
// gender: "Male",
// age: "30",
// personHeight: "5'4",
// height: _itemheight,
// width: _width,
// data: "S",
// avatarColor: Colors.blue,
// iconColor: GlobalColors.firstColor
// ),
// RoundListingCell(
// title: "Start Round",
// gender: "Male",
// age: "30",
// personHeight: "5'4",
// height: _itemheight,
// width: _width,
// data: "F",
// avatarColor: Colors.yellow,
// iconColor: GlobalColors.firstColor
// ),
// RoundListingCell(
// title: "Start Round",
// gender: "Male",
// age: "30",
// personHeight: "5'4",
// height: _itemheight,
// width: _width,
// data: "G",
// avatarColor: Colors.green,
// iconColor: Colors.grey
// ),
// RoundListingCell(
// title: "Start Round",
// gender: "Male",
// age: "30",
// personHeight: "5'4",
// height: _itemheight,
// width: _width,
// data: "H",
// avatarColor: Colors.purple,
// iconColor: Colors.grey
// ),
// RoundListingCell(
// title: "Start Round",
// gender: "Male",
// age: "30",
// personHeight: "5'4",height: _itemheight,
// width: _width,
// data: "N",
// avatarColor: Colors.teal,
// iconColor: Colors.grey
// ),
//// PreMatchesItem(_itemheight, _width, "A",Colors.green,context),
////
//// PreMatchesItem(_itemheight, _width, "M",Colors.blue,context),
//// PreMatchesItem(_itemheight, _width, "B",Colors.pink,context),
// ],
// ),
      ),
    );



  }

  void funPreMatches(){
    Map<String, dynamic> body = {

    };
    print(body);
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.get,authorization: true, url: WebService.prematches,body: body,isFormData: false).then(
              (response){
            var res = response as http.Response;
            if (res.statusCode == 200){
              var data=List<Matches>();
              Map<String, dynamic> responseJson = json.decode(res.body);
              if(responseJson.containsKey('success')){
//                print("HEre is yourrr response : ${responseJson["success"]}");
                responseJson["success"].forEach((v) {

//                  print(v);
                  Matches item = Matches.fromJson(v);
//                  print(item);
                  data.add(Matches.fromJson(v));
// print(Matches.fromJson(v));
                });
//                print("Countttt: ${data.length}");

                setState(() {
                  matches=data;
                  apiCall=0;
                });
// print(responseJson);
// Navigator.push(context, CupertinoPageRoute(builder: (context) => PreferencesOnBoarding()));
// var loginResponse = LoginModel.fromJson(responseJson["success"]);
// print(res.statusCode.toString());
// print(loginResponse.user.email);
// print(loginResponse.user.name);
              }else{
                print("Oh no response");
              }

            }else if (res.statusCode == 401){
              Toast.show(res.reasonPhrase.toString(), context, duration: Toast.LENGTH_LONG);
            }else{
              Toast.show(res.reasonPhrase.toString(), context, duration: Toast.LENGTH_LONG);
            }



//
// var data=List<Matches>();
// Map<String, dynamic> responseJson = json.decode(response);
// if(responseJson.containsKey('success')){
//
// responseJson['success'].forEach((v) {
// data.add(Matches.fromJson(v));
// print(Matches.fromJson(v));
// });
// matches=data;

// print("responce");
// }else{
// print(responseJson);
// }
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
      Navigator.push(context, CupertinoPageRoute(builder: (context) => Catagories()));
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


