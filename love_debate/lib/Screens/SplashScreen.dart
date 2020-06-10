


import 'dart:async';

import 'package:lovedebate/Screens/Login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Login');
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
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Container(
                  height: _height,
                  color: Colors.pink,
                  child: Image.asset('images/BackGround.jpeg',fit: BoxFit.cover,),
                ),
              ),
              Container(
                height: (80/100)*_height,
                //color: Colors.greenAccent,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Love',style: TextStyle(fontSize: 45,color:Colors.white),),
                    Text('Debate',style: TextStyle(fontSize: 45,color:Colors.white),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}