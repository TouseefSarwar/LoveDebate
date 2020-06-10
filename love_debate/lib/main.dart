
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Screens/SplashScreen.dart';

import 'Screens/Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home:SplashScreen(),
        routes: <String, WidgetBuilder> {
          '/Login': (BuildContext context) =>  Login(),
        }
//    home: TabBarControllerPage(),
     // home: CurrentRounds(),
    );
  }
}

