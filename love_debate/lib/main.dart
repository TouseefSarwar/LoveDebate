import 'package:app_ovedebatef/OnBoarding/OnBoarding.dart';
import 'package:app_ovedebatef/Screens/Login.dart';
import 'package:app_ovedebatef/Screens/Rounds.dart';
import 'package:app_ovedebatef/Screens/SignUp.dart';
import 'package:app_ovedebatef/Screens/SplashScreen.dart';
import 'package:app_ovedebatef/Screens/TabBarcontroller.dart';
import 'package:app_ovedebatef/Screens/UserChatList.dart';
import 'package:flutter/material.dart';
import 'package:app_ovedebatef/Screens/TabStyleRounds.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
//      home:SplashScreen(),
//        routes: <String, WidgetBuilder> {
//          '/Login': (BuildContext context) =>  Login(),
//        }
//    home: TabBarControllerPage(),
      home: OnBoarding(),
    );
  }
}


