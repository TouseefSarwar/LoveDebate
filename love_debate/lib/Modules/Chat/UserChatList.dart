import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:lovedebate/Models/ChatListModel.dart';
import 'package:lovedebate/Modules/Chat/ChatRoom.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/CustomAppBar.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';


class UserChatList extends StatefulWidget {
  @override
  _UserChatListState createState() => _UserChatListState();
}

class _UserChatListState extends State<UserChatList> {
  List<ChatListModel> list = [
    ChatListModel(
      name: "Brett Lee",
      descrip: "Hi! How are you doing bro?",
      image: "images/conor.jpg",
      time: "2 min",
      newMsgStatus: true,
    ),
    ChatListModel(
      name: "Brett Lee",
      descrip: "Hi! How are you doing bro?",
      image: "images/conor.jpg",
      time: "1 days",
      newMsgStatus: false,
    ),
    ChatListModel(
      name: "Brett Lee",
      descrip: "Hi! How are you doing bro?",
      image: "images/conor.jpg",
      time: "1 weeks",
      newMsgStatus: false,
    ),
    ChatListModel(
      name: "Brett Lee",
      descrip: "Hi! How are you doing bro?",
      image: "images/conor.jpg",
      time: "1 months",
      newMsgStatus: true,
    ),
    ChatListModel(
      name: "Brett Lee",
      descrip: "Hi! How are you doing bro?",
      image: "images/conor.jpg",
      time: "6 months",
      newMsgStatus: false,
    ),
    ChatListModel(
      name: "Brett Lee",
      descrip: "Hi! How are you doing bro?",
      image: "images/conor.jpg",
      time: "2 years",
      newMsgStatus: false,
    ),


  ];


  @override
  Widget build(BuildContext context) {

    double _height=(MediaQuery.of(context).size.height)-AppBar().preferredSize.height;
    double _width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppbar.setNavigation("Chats"),
      body: SafeArea(
        child:Container(
          height: _height,
          width: _width,
          //color: Colors.blue,
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context,index){
              return ChatListItem(_width, list[index]);
            }
          ),
        ),

      ),
    );
  }

  InkWell ChatListItem(double _width, ChatListModel data) {
    return InkWell(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => ChatRoom()));
      },
      child: Container(
                height: 90,
                width: _width,
                //color: Colors.cyan,
                child: Card(
                  elevation: 5,
                  child: Row(
                    children: <Widget>[
                      AppBarPic(),
                      Expanded(
                        child: Container(
                          height: 90,
                          margin: EdgeInsets.only(left: 8),
                         child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(data.name,style: TextStyle(fontSize: GlobalFont.textFontSize,fontWeight: FontWeight.w500),),
                              SizedBox(height: 4,),
                              Text(data.descrip,style: TextStyle(fontSize: GlobalFont.textFontSize-2, color: Colors.grey),),
                            ]
                          ),
                        ),
                      ),
                      SizedBox(width: 8,),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(data.time,style: TextStyle(fontSize: GlobalFont.textFontSize - 5,color: Colors.grey),),

                            Container(
                              width: 10,
                              height: 10,
                              decoration : new BoxDecoration(
                                  color: data.newMsgStatus ? Colors.blueAccent : Colors.transparent ,
                                  shape: BoxShape.circle,
//                                image: new DecorationImage(
//                                    fit: BoxFit.fitHeight,
//                                    image: AssetImage("images/conor.jpg"),
//                                )
                              ),
                            ),


                          ],
                        ),
                      ),

//                    Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        Row(
//                          children: <Widget>[
//                            Text("Hamza Arshad",style: TextStyle(fontSize: GlobalFont.textFontSize,fontWeight: FontWeight.bold),),
//                            SizedBox(width:8,),
//                            Text("Yesterday",style: TextStyle(fontSize: GlobalFont.textFontSize - 5),)
//                          ],
//                        ),
//                        Text("How are you?",style: TextStyle(fontSize: GlobalFont.textFontSize),),
//                      ],
//                    ),

//                    Expanded(
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Text("Hamza Arshad",style: TextStyle(fontSize: GlobalFont.textFontSize,fontWeight: FontWeight.bold),),
//                          SizedBox(height: 4,),
//                          Text("How are you?",style: TextStyle(fontSize: GlobalFont.textFontSize),),
//                        ],
//                      ),
//                    ),
//                    Container(
//                      height: 40,
//                     // color: Colors.cyan,
//                      margin: EdgeInsets.all(8),
//                     // child: Image.asset("images/message.png"),
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.end,
//                        children: <Widget>[
//                          Text("Yesterday",style: TextStyle(fontSize: GlobalFont.textFontSize - 5),),
//                        ],
//                      ),
//                    )
                    ],
                  ),
                ),
              ),
    );
  }
}

Container AppBarPic() {
    return Container(
            width: 60,
            height: 60,
            margin: EdgeInsets.all(8),
            decoration: new BoxDecoration(
              color: Colors.grey,
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage(
                        "images/conor.jpg")
                )
            ));
  }



