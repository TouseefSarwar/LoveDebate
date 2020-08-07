
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:app_push_notifications/Utils/Globals/Fonts.dart';

class RoundListingCell extends StatelessWidget {
  double height;
  double width;
  String title;
  String age;
  String gender;
  String personHeight;
  Color avatarColor;
  Color iconColor;
  int index;
  String address;
  VoidCallback action;

  ///Here we can use the model instead of "String" variable in future
  String data;



  RoundListingCell({this.height, this.width, this.data,this.address ,this.avatarColor, this.iconColor, this.title, this.age, this.gender,this.personHeight,this.index, this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:  action,
      child: Container(
        height: height,
        width: width,
        // color: Colors.black,
        child: Card(
          elevation: 5,
          child: Row(
            children: <Widget>[
              ///Circle Word/ Image
              SizedBox(width: 8,),
              Stack(
                children: <Widget>[
                  Container(
                      width: 75,
                      height: 75,
                      // margin: EdgeInsets.only(left: 24),
                      decoration: new BoxDecoration(
                        color: avatarColor,
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
                        (data != null || data!="")?data:"",style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),

              ///Rounds Heading and Sub Headings....
              Expanded(
                child: Container(
                  height: height,
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ///Completed Rounds....
                      Row(
                        children: <Widget>[
                          Text(title, maxLines: 1,style: TextStyle(fontSize: GlobalFont.textFontSize, fontWeight: FontWeight.bold ,color:Color(0xff2E3032)),),
                        ],
                      ),
                      SizedBox(height: 4,),
                      ///age, gender, Height....
                      Row(
                        children: <Widget>[
                          ///Gender Icon And text
//                        Icon(Icons.account_circle, color: iconColor,size: 20,),
                          SizedBox(width: 4,),
                          Text("$gender, ",style: TextStyle(fontSize: GlobalFont.textFontSize - 2,color:Color(0xff2E3022))),

                          ///Age Icon And text
//                        SizedBox(width: 12,),
//                        Icon(Icons.person, color: iconColor,size: 20,),
                          SizedBox(width: 4,),
                          Text("$age years, ",style: TextStyle(fontSize: GlobalFont.textFontSize - 2,color:Color(0xff2E3022))),

                          ///Height Icon And text
//                        SizedBox(width: 12,),
//                        Icon(Icons.person, color: iconColor,size: 20,),
                          SizedBox(width: 4,),
                          Text("$personHeight\"",style: TextStyle(fontSize: GlobalFont.textFontSize - 2,color:Color(0xff2E3022))),


                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        children: <Widget>[
                          Icon(Icons.pin_drop, color: iconColor,size: 20,),
                          SizedBox(width: 4,),
                          Text((address != null || address != "")?address:"Address not found",style: TextStyle(fontSize: GlobalFont.textFontSize,color:Color(0xff2E3022))),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8,),
              Container(
                height: height,
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
}