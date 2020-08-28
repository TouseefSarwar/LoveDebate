import 'package:app_push_notifications/Modules/Chat/Model/chatUsers.dart';
import 'package:app_push_notifications/Modules/Chat/UI/chatDetails.dart';
import 'package:flutter/material.dart';

class ChatUsersListItem extends StatefulWidget{
  ChatUser chatUser;
  Color color;
  ChatUsersListItem({@required this.chatUser, this.color});
  @override
  _ChatUsersListItemState createState() => _ChatUsersListItemState();
}

class _ChatUsersListItemState extends State<ChatUsersListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ChatDetails(chatUser: widget.chatUser);
        }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  widget.chatUser.profilePic != null?
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.chatUser.profilePic),
                    maxRadius: 30,
                  ):CircleAvatar(
                    child: Text(widget.chatUser.userName[0], style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
                    backgroundColor: widget.color,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.chatUser.userName),
                          SizedBox(height: 6,),
                          Text(widget.chatUser.lastMsg,style: TextStyle(fontSize: 14,color: Colors.grey.shade500),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
//            Text(widget.chatUser.lastMsgDate,style: TextStyle(fontSize: 12,color: widget.chatUsers.isMessageRead?Colors.pink:Colors.grey.shade500),),
          ],
        ),
      ),
    );
  }
}