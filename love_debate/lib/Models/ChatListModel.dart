import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatListModel {
  String name;
  String descrip;
  String image;
  String time;
  bool newMsgStatus;


  ChatListModel({this.name, this.descrip, this.image, this.time, this.newMsgStatus});
}