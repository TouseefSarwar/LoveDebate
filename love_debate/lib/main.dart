
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Modules/LoginSignup/SignUp.dart';
import 'package:lovedebate/Modules/LoginSignup/SignUpform.dart';
import 'package:lovedebate/Modules/OnBoarding/OnBoarding.dart';
import 'package:lovedebate/Modules/OnBoarding/PreferencesOnBoarding.dart';
import 'package:lovedebate/Modules/PreMatches/Rounds/CurrentRounds.dart';
import 'package:lovedebate/Modules/Profile/Profile.dart';
import 'package:lovedebate/Screens/SplashScreen.dart';
import 'package:lovedebate/Screens/TabBarcontroller.dart';

import 'Modules/LoginSignup/Login.dart';
import 'Screens/TabStyleRounds.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
//      home:SplashScreen(),
//        routes: <String, WidgetBuilder> {
//          '/Login': (BuildContext context) =>  Login(),
//        }
    home:Profile(),
      //home: PreferencesOnBoarding(),
    );
  }
}


