
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Models/LoginModel.dart';
import 'package:lovedebate/Modules/LoginSignup/SocialSignUpInfo.dart';
import 'package:lovedebate/Utils/Constants/SharedPref.dart';
import 'Modules/LoginSignup/Login.dart';
import 'package:lovedebate/Screens/SplashScreen.dart';

import 'Modules/Preferences/PreferencesOnBoarding.dart';
import 'Screens/TabBarcontroller.dart';
import 'Utils/Globals/UserSession.dart';

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

//   Future<bool> isLoggedIn() async{
//    if (await prf.containKey(UserSession.tokenkey)){
//      UserSession.token = await prf.getBy(UserSession.tokenkey);
//      return true;
//    }else{
//      UserSession.token = "";
//      return false;
//    }
//  }

}


