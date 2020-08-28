import 'package:flutter/foundation.dart';

enum MessageType{
  Sender,
  Receiver,
}

class ChatConversation {
  int chatId;
  int senderId;
  int receiverId;
  int conversationId;
  String message;
  String messageDatetime;
  int isRead;
  MessageType type;

  ChatConversation(
      {this.chatId,
        this.senderId,
        this.receiverId,
        this.conversationId,
        this.message,
        this.messageDatetime,
        this.isRead, this.type});

  ChatConversation.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    conversationId = json['conversation_id'];
    message = json['message'];
    messageDatetime = json['message_datetime'];
    isRead = json['is_read'];
    this.type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_id'] = this.chatId;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['conversation_id'] = this.conversationId;
    data['message'] = this.message;
    data['message_datetime'] = this.messageDatetime;
    data['is_read'] = this.isRead;
    return data;
  }
}