import 'dart:developer';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';
import 'package:lovedebate/Utils/HexColor.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
class UserChatList extends StatefulWidget {
  @override
  _UserChatListState createState() => _UserChatListState();
}

class _UserChatListState extends State<UserChatList> {
  @override
  Widget build(BuildContext context) {

    double _height=(MediaQuery.of(context).size.height)-AppBar().preferredSize.height;
    double _width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: GlobalColors.firstColor,
        backgroundColorEnd: GlobalColors.secondColor,
        title:  Text('Chats',style:TextStyle(color: Colors.white ,fontSize: GlobalFont.navFontSize, fontFamily: 'Satisfy', fontWeight:  FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child:Container(
          height: _height,
          width: _width,
          //color: Colors.blue,
          child: ListView(
            children: <Widget>[
              ChatListItem(_width),
              ChatListItem(_width),
              ChatListItem(_width),

            ],
          ),
        ),

      ),
    );
  }

  Container ChatListItem(double _width) {
    return Container(
              height: 90,
              width: _width,
              //color: Colors.cyan,
              child: Card(
                child: Row(

                  children: <Widget>[
                    AppBarPic(),
                    SizedBox(width: 8,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Hamza Arshad",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(height: 4,),
                          Text("How are you?",style: TextStyle(fontSize: GlobalFont.textFontSize),),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                     // color: Colors.cyan,
                      margin: EdgeInsets.all(16),
                     // child: Image.asset("images/message.png"),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("Yesterday",style: TextStyle(fontSize: GlobalFont.textFontSize),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
  }
}

  Container AppBarPic() {
    return Container(
            width: 70,
            height:70,
            margin: EdgeInsets.all(8),
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: new NetworkImage(
                        "https://i.imgur.com/BoN9kdC.png")
                )
            ));
  }
class AppBarProfilePic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Center(
        child: CircleAvatar(
          radius: 23,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 20,
            // child: Image.asset('images/BackGround.png',fit: BoxFit.fill,),
          ),
        ),
      ),
    );
  }
}
Container ProfileImage(double height,double width,double leftmargin) {
  return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(left: leftmargin),
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.fill,
              image: new NetworkImage(
                  "https://i.imgur.com/BoN9kdC.png")
          )
      ));
}