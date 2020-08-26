import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:app_push_notifications/Modules/PreMatches/Rounds/Rounds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_push_notifications/Utils/Constants/SharedPref.dart';
import 'package:app_push_notifications/Utils/Globals/UserSession.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:get/route_manager.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool count = false;
  //Firebase Notificaiton...
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  //Local Notificaiton...
  FlutterLocalNotificationsPlugin pluginFLN = new FlutterLocalNotificationsPlugin();
  var initializeSettingForIOS;
  var initializeSettingForAndroid;
  var initializeSettings;

  SharedPref prf = SharedPref();
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }


  ///NOTIFICATIONS  Variables....
//  var id="1";
//  var cate="1";


  @override
  void initState() {
    super.initState();
//    prf.remove('isNotification');
    startTime();
    initNotification();


      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage Is: $message");

          // This function is for local notification
//        showNotification();

          if (Platform.isIOS){
            print("IOS"+message["id"]);
            print(message["cate"]);
            await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Rounds(idNoti:"${message["id"]}" ,catId:"${message["cate"]}"))
            );
          }else{
            print("Android"+message["data"]["id"]);
            print(message["data"]["cate"]);
            await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Rounds(idNoti:"${message["data"]["id"]}" ,catId:"${message["data"]["cate"]}"))
            );
          }
        },
//      onBackgroundMessage: Fcm.myBackgroundMessageHandler,
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
//          prf.set("isNotification", true);
          if (Platform.isIOS){
            print("IOS"+message["id"]);
            print(message["cate"]);
            await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Rounds(idNoti:"${message["id"]}" ,catId:"${message["cate"]}"))
            );
          }else{
            print("Android"+message["data"]["id"]);
            print(message["data"]["cate"]);
            await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Rounds(idNoti:"${message["data"]["id"]}" ,catId:"${message["data"]["cate"]}"))
            );
          }
        },
        onResume: (Map<String, dynamic> message) async {
//          prf.set("isNotification", true);
          if (Platform.isIOS){
            print("IOS"+message["id"]);
            print(message["cate"]);
//            await Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => Rounds(idNoti:"${message["id"]}" ,catId:"${message["cate"]}"))
//            );
          }else{
            print("Android"+message["data"]["id"]);
            print(message["data"]["cate"]);
            await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Rounds(idNoti:"${message["data"]["id"]}" ,catId:"${message["data"]["cate"]}"))
            );
          }
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




  ///Notifications Setting....
  showNotification() async{
    await _demoNotification();
  }
  Future<Void> _demoNotification() async{
    var androidChannelSpecifics =  AndroidNotificationDetails(
        'channel_ID', 'channel name', 'channel description',
        importance:  Importance.Max ,
        priority: Priority.High ,
        ticker: 'test ticker' );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidChannelSpecifics,iosChannelSpecifics);
    await  pluginFLN.show(0, 'Test', 'this is a test local notification', platformChannelSpecifics, payload: 'test_payload');
  }

  initNotification(){
    initializeSettingForAndroid = new AndroidInitializationSettings('app_icon');
    initializeSettingForIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializeSettings = new InitializationSettings(initializeSettingForAndroid, initializeSettingForIOS);
    pluginFLN.initialize(initializeSettings,onSelectNotification: selectNotification);
  }


  Future selectNotification(String payload) async{
    if (payload != null){
      print("Click action performed");
    }
  }

  //Used in the case of IOS....
  Future onDidReceiveLocalNotification(int id, String title, String body, String payload)async{

    //push to any view
    print("Payloadssss"+payload);
    print("Receiveddd heerrreee");
  }

  void navigationPage() async{
//    if (await prf.containKey("isNotification")){
//      prf.remove("isNotification");
//      Get.to(Rounds(idNoti: id,catId: cate,));
//    }else{
      if (await prf.containKey(UserSession.authTokenkey)){
        UserSession.authToken = await prf.getBy(UserSession.authTokenkey);
        Navigator.of(context).pushReplacementNamed('/TabBarControllerPage');
      }else{
        UserSession.authToken = "";
        Navigator.of(context).pushReplacementNamed('/Login');
      }
//    }
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




