import 'dart:async';
import 'dart:io';

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


  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  SharedPref prf = SharedPref();
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async{
    if (await prf.containKey(UserSession.tokenkey)){
      UserSession.token = await prf.getBy(UserSession.tokenkey);
      Navigator.of(context).pushReplacementNamed('/TabBarControllerPage');
    }else{
      UserSession.token = "";
      Navigator.of(context).pushReplacementNamed('/Login');
    }

  }

  @override
  void initState() {
    super.initState();


    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
      },
//      onBackgroundMessage: Fcm.myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _showItemDialog(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _showItemDialog(message);
      },
    );

    if (Platform.isIOS) {
      iOS_Permission();
    }
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
    });

    startTime();
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true,provisional: false));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
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