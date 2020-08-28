class LoginModel {
  String token;
  User user;

  LoginModel({this.token, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  String socketId;
  String name;
  String email;

  User({this.name, this.email});

  User.fromJson(Map<String, dynamic> json) {
    socketId = json['soc_id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['soc_id'] = this.socketId;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}