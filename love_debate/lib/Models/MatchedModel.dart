class MatchedModel {
  int cId;
  String socketId;
  int userId;
  String userName;
  Null profilePic;
  String lastMsg;
  String lastMsgDate;

  MatchedModel(
      {this.cId,
        this.socketId,
        this.userId,
        this.userName,
        this.profilePic,
        this.lastMsg,
        this.lastMsgDate});

  MatchedModel.fromJson(Map<String, dynamic> json) {
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