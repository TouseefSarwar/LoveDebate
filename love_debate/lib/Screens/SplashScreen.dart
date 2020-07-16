import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:lovedebate/Modules/LoginSignup/Login.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Screens/TabBarcontroller.dart';
import 'package:lovedebate/Utils/Constants/SharedPref.dart';
import 'package:lovedebate/Utils/Globals/UserSession.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
    startTime();
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