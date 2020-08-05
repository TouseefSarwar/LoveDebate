import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Utils/Constants/SharedPref.dart';
import 'package:lovedebate/Utils/Globals/UserSession.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPref prf = SharedPref();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _message = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    getMessage();
    startTime();
  }

  void getMessage(){
    if (Platform.isIOS) iOS_Permission();
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('on message $message');
          setState(() => _message = message["notification"]["title"]);},
        onResume: (Map<String, dynamic> message) async {
          print('on resume $message');
          setState(() => _message = message["notification"]["title"]);},
        onLaunch: (Map<String, dynamic> message) async {
          print('on launch $message');
          setState(() => _message = message["notification"]["title"]);
    });
  }
  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((token) => print(token));
  }

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
}