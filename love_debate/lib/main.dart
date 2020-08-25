import 'package:app_push_notifications/Modules/PreMatches/Rounds/Rounds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_push_notifications/Modules/LoginSignup/SocialSignUpInfo.dart';
import 'Modules/LoginSignup/Login.dart';
import 'package:app_push_notifications/Screens/SplashScreen.dart';
import 'Screens/TabBarcontroller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
        ),
        home:  SplashScreen(),
//        home:  RoundsCopy(),
        routes: {
          '/Login': (BuildContext context) =>  Login(),
          '/TabBarControllerPage' : (BuildContext context) => TabBarControllerPage(),
          '/SocialSignUp' : (BuildContext context) => SocialSignUpForm(),
          '/Rounds' : (BuildContext context) => Rounds(),
        }

    );
  }


}


