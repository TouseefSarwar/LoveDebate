
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Modules/LoginSignup/SocialSignUpInfo.dart';
import 'Modules/LoginSignup/Login.dart';
import 'package:lovedebate/Screens/SplashScreen.dart';
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
//    home:FutureBuilder<bool>(
//      future: isLoggedIn(),
//      builder:(BuildContext context, AsyncSnapshot<bool> snapshot) {
//        if (snapshot.data == false) {
//          isLogIn = false;
//          return SplashScreen();
//        }
//        else {
//          isLogIn = true;
//          return SplashScreen();
//        }
//      }),

      routes: {
        '/Login': (BuildContext context) =>  Login(),
        '/TabBarControllerPage' : (BuildContext context) => TabBarControllerPage(),
        '/SocialSignUp' : (BuildContext context) => SocialSignUpForm(),
      }

    );
  }

}


