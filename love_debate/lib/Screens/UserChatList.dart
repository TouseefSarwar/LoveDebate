import 'dart:developer';
import 'dart:math';
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
    return Container(

    );
  }
}


  Container AppBarPic() {
    return Container(
            width: 40,
            height:40,
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
  Container UserChatItem(double _itemheight, double _width) {
    return Container(
      height:_itemheight,
      width: _width,
      margin: EdgeInsets.all(4),
      // color: Colors.blueGrey,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              width:(25/100)*_width,
              // margin: EdgeInsets.all(8),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  ProfileImage(60,60,24),
                  Positioned(
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius:12,
                        backgroundColor:Colors.deepPurple ,
                      ),
                    ),
                    bottom: 6,
                    right: 24,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: _itemheight,
                //width: (50/100)*_width,
                // color: Colors.greenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Hamza Arshad',style: TextStyle(fontSize: 20,color:Colors.deepPurple ),),
                    SizedBox(height: 8,),
                    Container(
                        child: Text('How are you? what are you doing ',overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 18),))
                  ],
                ),
              ),
            ),
            Container(
              height: _itemheight,
              width: (25/100)*_width,
              //  color: Colors.blueGrey,
              margin: EdgeInsets.only(right: 12,top: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  CircleAvatar(
                    child: Text('1',style: TextStyle(color: Colors.white),),
                    backgroundColor: Colors.deepPurple,
                    radius: 10,
                  ),
                  SizedBox(height: 4,),
                  Text('5:45 PM',style: TextStyle(fontSize: 16),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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