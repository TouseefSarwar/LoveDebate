import 'package:flutter/foundation.dart';

//class ChatUsers{
//
//  final String id;
//  final String name;
//  final String message;
//  final String image;
//  final String time;
//
//  ChatUsers({@required this.id, @required this.name, @required this.message, @required this.image, @required this.time});
//
//}


//class ChatUserList {
//  List<ChatUser> success;
//
//  ChatUserList({this.success});
//
//  ChatUserList.fromJson(Map<String, dynamic> json) {
//    if (json['success'] != null) {
//      success = new List<ChatUser>();
//      json['success'].forEach((v) {
//        success.add(new ChatUser.fromJson(v));
//      });
//    }
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.success != null) {
//      data['success'] = this.success.map((v) => v.toJson()).toList();
//    }
//    return data;
//  }
//}

class ChatUser {
  int cId;
  String socketId;
  int userId;
  String userName;
  Null profilePic;
  String lastMsg;
  String lastMsgDate;

  ChatUser(
      {this.cId,
        this.socketId,
        this.userId,
        this.userName,
        this.profilePic,
        this.lastMsg,
        this.lastMsgDate});

  ChatUser.fromJson(Map<String, dynamic> json) {
    cId = json['c_id'];
    socketId = json['socket_id'];
    userId = json['user_id'];
    userName = json['userName'];
    profilePic = json['profilePic'];
    lastMsg = json['last_msg'];
    lastMsgDate = json['last_msg_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['c_id'] = this.cId;
    data['socket_id'] = this.socketId;
    data['user_id'] = this.userId;
    data['userName'] = this.userName;
    data['profilePic'] = this.profilePic;
    data['last_msg'] = this.lastMsg;
    data['last_msg_date'] = this.lastMsgDate;
    return data;
  }
}