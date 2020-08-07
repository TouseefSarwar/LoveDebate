import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:app_push_notifications/Models/ChatRoomModel.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:app_push_notifications/Utils/Globals/CustomAppBar.dart';
import 'package:app_push_notifications/Utils/Globals/Fonts.dart';
import 'package:app_push_notifications/Utils/Designables/CustomTextFeilds.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  TextEditingController sendMsgTF = TextEditingController();
  FocusNode sendMsgFN = FocusNode();


  BubbleStyle styleSomebody = BubbleStyle(
    nip: BubbleNip.no,
    color:Color(0xFFE9E9EA),
    elevation: 1,
    margin: BubbleEdges.only(top: 8, right: 50),
    alignment: Alignment.topLeft,
  );
  BubbleStyle styleMe = BubbleStyle(
    nip: BubbleNip.no,
    color: GlobalColors.firstColor,
    elevation: 1,
    margin: BubbleEdges.only(top: 8.0, left: 50.0),
    alignment: Alignment.topRight,
  );

  @override
  Widget build(BuildContext context) {

    List<ChatRoomModel> msgList = [
      ChatRoomModel(
        msg: "Welcome to LoveDebate! \nThis is test message to checking the User Interface.",
        isMe: true,

      ),
      ChatRoomModel(
        msg: "Thanks to LoveDebate! \nThis is test message to checking the User Interface.",
        isMe: false,

      ),
      ChatRoomModel(
        msg: "Hi!",
        isMe: true,

      ),
      ChatRoomModel(
        msg: "Hello Lee!",
        isMe: false,
      ),
      ChatRoomModel(
        msg: "How are you?",
        isMe: true,
      ),
      ChatRoomModel(
        msg: "Thanks to God. I'm good.\nWhats about you?",
        isMe: false,
      ),
    ];
    return Scaffold(
      appBar: CustomAppbar.setNavigation("Chat Room"),
      body:  Column(
        children: <Widget>[
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height - 50,
              child: ListView.builder(
                itemCount: msgList.length ,
                itemBuilder: (context,index){

                  if (msgList[index].isMe){
                    return ChatItem(styleMe, msgList[index].msg);
                  }else{
                    return ChatItem(styleSomebody, msgList[index].msg);
                  }

//          return index != 9? ChatItem(styleMe, "Welcome to LoveDebate! \nThis is test message to checking the User Interface.", true): sendMsgTextFeild();
                },
              ),
            ),
          ),

          sendMsgTextFeild(),
          SizedBox(height: 24,),
        ],
      )
    );
  }


  Container ChatItem(BubbleStyle style, String text) {
    return Container(
      //width:200,
      //color: Colors.,
      child: Column(
        children: <Widget>[
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Bubble(
              style: style,
              child: Text(text, style: TextStyle(fontSize:GlobalFont.textFontSize,fontWeight: FontWeight.w500, color: style == styleMe ? Colors.white : Colors.black),),
            ),
          ),
          SizedBox(height: 8,),
        ],
      ),
    );
  }


  Container sendMsgTextFeild(){
    ///TextFeild...
    return Container(
      height: 60,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        //color: Color(0xffE0E0E0),
        color: Colors.white,
        border: Border.all(
            width: 1.0,
            color: Colors.grey
        ),
//        borderRadius: BorderRadius.all(
//            Radius.circular(22.0) //                 <--- border radius here
//        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: NewUnderLineTextField(
                focusNode: sendMsgFN,
                txtHint: "Your answer",
                isSecure: false,
                keyboardType: TextInputType.emailAddress,
                enableBorderColor: Colors.white,
                focusBorderColor: Colors.white,
                textColor: Colors.black,
                txtController: sendMsgTF,
                onTapFunc: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(sendMsgFN);
                  });
                },
              ),
            ),
            SizedBox(width: 8,),
            Icon(Icons.send , size: 36, color: GlobalColors.firstColor,)
          ],
        ),
      ),
    );
  }

  

}

