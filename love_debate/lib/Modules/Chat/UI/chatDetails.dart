import 'package:app_push_notifications/Modules/Chat/ChatBloc/blocProvider.dart';
import 'package:app_push_notifications/Modules/Chat/Components/chat_bubble.dart';
import 'package:app_push_notifications/Modules/Chat/Components/chat_detail_page_appbar.dart';
import 'package:app_push_notifications/Modules/Chat/Model/chatMessages.dart';
import 'package:app_push_notifications/Modules/Chat/Model/chatUsers.dart';
import 'package:app_push_notifications/Modules/Chat/Model/sendMenu.dart';
import 'package:app_push_notifications/Modules/Chat/ChatBloc/chatBloc.dart';
import 'package:app_push_notifications/Modules/Chat/ChatBloc/blocProvider.dart';
import 'package:app_push_notifications/Utils/Constants/SharedPref.dart';
import 'package:app_push_notifications/Utils/Globals/UserSession.dart';
import 'package:flutter/material.dart';

class ChatDetails extends StatefulWidget {
  final ChatUser chatUser;

  const ChatDetails({Key key, this.chatUser}) : super(key: key);
  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {

  TextEditingController _txtMessages = TextEditingController();
  ChatUser chatUser;
  var bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatUser = widget.chatUser;
    bloc = BlocProvider.of<ChatBloc>(context);
    bloc.getChatFromServer(chatUser.cId.toString());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatDetailPageAppBar(),
      body: StreamBuilder<bool>(
        stream: bloc.isLoading,
        builder: (context, snapshot) {
          final result = snapshot.data;

          if (result == null) {
            return Container();
          }

          return Column(
            children: <Widget>[
              Expanded(
                  child: chatList(bloc)
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 24, bottom: 10, right: 16),
//              height: 80,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _txtMessages,
                          decoration: InputDecoration(
                            hintText: "Type message...",
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            border: InputBorder.none,
                          ),
                          maxLines: null,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => sendMessage(bloc),
                        child:
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.redAccent.shade200,
                            borderRadius: BorderRadius.circular(40 / 2),
                          ),
                          child: Center(child: Icon(
                            Icons.send, color: Colors.white, size: 20,)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      )
    );
  }

  Widget chatList(ChatBloc bloc){
    return StreamBuilder<List<ChatConversation>>(
      stream: bloc.listOfMessages,
      builder: (context, snapShot){
        final result = snapShot.data;

        if(result == null || result.isEmpty){
          return Container();
        }

        return ListView.builder(
          itemCount: result.length,
//          controller: bloc.scrollController,
          itemBuilder: (context, index){
            return ChatBubble(
              chatMessage: result[index],
            );
          },
        );
      },
    );
  }

  sendMessage(ChatBloc provider){
    FocusScope.of(context).unfocus();
    provider.sendMessages(toUserId: chatUser.socketId, message: _txtMessages.text);
    _txtMessages.text = '';
  }
}




