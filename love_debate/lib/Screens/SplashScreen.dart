import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app_push_notifications/Modules/PreMatches/Rounds/Rounds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_push_notifications/Utils/Constants/SharedPref.dart';
import 'package:app_push_notifications/Utils/Globals/UserSession.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool count = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  SharedPref prf = SharedPref();
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async{
    if (await prf.containKey(UserSession.authTokenkey)){
      UserSession.authToken = await prf.getBy(UserSession.authTokenkey);
      Navigator.of(context).pushReplacementNamed('/TabBarControllerPage');
    }else{
      UserSession.authToken = "";
      Navigator.of(context).pushReplacementNamed('/Login');
    }

  }

  @override
  void initState() {
    super.initState();
    startTime();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage Is: $message");
//          Navigator.of(context).pushReplacementNamed('/Rounds');
//        Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => Rounds(idNoti:"${message["id"]}" ,catId:"${message["cate"]}"))
//        );
//        handleNotificationScreen(message);
      },
//      onBackgroundMessage: Fcm.myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
//        _showItemDialog(message);
//        Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => Rounds(idNoti:"${message["id"]}" ,catId:"${message["cate"]}"))
//        );

      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
//        Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => Rounds(idNoti:"${message["id"]}" ,catId:"${message["cate"]}"))
//        );
//        _showItemDialog(message);
      },
    );

    if (Platform.isIOS) {
      iOS_Permission();
    }
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
      if(token != null){
        UserSession.fcmToken = token;
      }

    });


  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true,provisional: false));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }





  handleNotificationScreen(Map<String, dynamic> msg){

    if (msg.containsKey("cate") && msg.containsKey("id"))  {
      //rounds handling....
      print("Rounds \n Round Id: ${msg["id"]} \n Categeroy Id: ${msg["cate"]}  ");
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Rounds(idNoti:"${msg["id"]}" ,catId:"${msg["cate"]}"))
      );

//      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Rounds(idNoti:"${msg["id"]}" ,catId:"${msg["cate"]}")));

    }else{
      print("Handle other notifications screens like chat etc.");
    }

  }





  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom;
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                  height: 250,
                  width: 250,
                  //color: Colors.lightBlue,
                  child: Image.asset("images/LoveDebatelogo.png")
              ),
            )

          ],
        ),
      ),
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
        context: context,
        builder: (_){
          return AlertDialog(
            content: Text("$message"),
            actions: <Widget>[
              FlatButton(
                child: const Text('CLOSE'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              FlatButton(
                child: const Text('SHOW'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        });
  }
}