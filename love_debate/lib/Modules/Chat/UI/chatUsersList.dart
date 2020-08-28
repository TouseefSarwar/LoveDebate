import 'dart:convert';
import 'dart:math';

import 'package:app_push_notifications/Modules/Chat/Components/chat.dart';
import 'package:app_push_notifications/Modules/Chat/Model/chatUsers.dart';
import 'package:app_push_notifications/Utils/Constants/WebService.dart';
import 'package:app_push_notifications/Utils/Controllers/ApiBaseHelper.dart';
import 'package:app_push_notifications/Utils/Controllers/AppExceptions.dart';
import 'package:app_push_notifications/Utils/Controllers/Loader.dart';
import 'package:app_push_notifications/Utils/Globals/GlobalFunctions.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UsersChatList extends StatefulWidget {
  @override
  _UsersChatListState createState() => _UsersChatListState();
}

class _UsersChatListState extends State<UsersChatList> {

  List<ChatUser> _listOfChatUsers = List<ChatUser>();
  //For Avatar Colors
  List<int> colorsR = [0xFF9055A2,0xFFF7C548,0xFFFF66D8,0xFFDC493A,0xFF4392F1,0xFF3D0814,0xFFF7EC59,0xFFFF66D8,0xFFA98743,0xFFEEEBD3,0xFF011638];
  bool apiCall = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChatUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: apiCall == false ? SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child:  Column(
          children: <Widget>[
            SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Chats",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
//                    Container(
//                      padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
//                      height: 30,
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(30),
//                        color: Colors.pink[50],
//                      ),
//                      child: Row(
//                        children: <Widget>[
//                          Icon(Icons.add,color: Colors.pink,size: 20,),
//                          SizedBox(width: 2,),
//                          Text("New",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                        ],
//                      ),
//                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16,right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: Icon(Icons.search,color: Colors.grey.shade400,size: 20,),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Colors.grey.shade200
                      )
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: _listOfChatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ChatUsersListItem(
                  chatUser: _listOfChatUsers[index],
                  color: Color(colorsR[Random().nextInt(colorsR.length)]),
                );
              },
            ),
          ],
        ) ) : Center(child: Loading(),
      ),
    );
  }



  getChatUsers(){
    Map<String, dynamic> body= {};
    apiCall = true;
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post,authorization: true, url: WebService.chatUsersList,body: body,isFormData: true).then(
              (response) async{

            var res = response as http.Response;
            if (res.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(res.body);
              if(responseJson.containsKey('success')){
//                print("response is =====> "+responseJson['success']);
                responseJson["success"].forEach((v) {
                  ChatUser item = ChatUser.fromJson(v);
                  _listOfChatUsers.add(ChatUser.fromJson(v));
                });
                apiCall = false;
                setState(() {});
              }else{
                apiCall = false;
                setState(() {});
                print("Oh no response");
              }
            }else if (res.statusCode == 401){
              apiCall = false;
              setState(() {});
              Map<String, dynamic> err = json.decode(res.body);
              GFunction.showError(err['error'].toString(), context);
            }else{
              apiCall = false;
              setState(() {});
              GFunction.showError(res.reasonPhrase.toString(), context);
            }
          });
    } on FetchDataException catch(e) {
      apiCall = false;
      setState(() {});
      GFunction.showError(e.toString(), context);
    }
  }
  
  
}
