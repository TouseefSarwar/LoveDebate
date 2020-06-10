import 'package:lovedebate/Globals/Colors.dart';
import 'package:flutter/material.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double width=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: GlobalColors.firstColor,
        backgroundColorEnd: GlobalColors.secondColor,
        title:  Text('Profile',style:TextStyle(color: Colors.white ,fontSize: 30, fontFamily: 'Satisfy', fontWeight:  FontWeight.bold)),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Upper Body
              Stack(
                  children: <Widget>[
                    //Gradient Background...
                    Container(
                      height: (30/100)*height,
                      width: width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              GlobalColors.firstColor,
                              GlobalColors.secondColor,
                            ]
                        ),
                      ),
                    ),

                    //Overlay
                    Container(
                      height: (30/100)*height,
                      width: width,
                      color: Colors.black.withOpacity(0.3),
                      padding: EdgeInsets.only(bottom: 8),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Muhammad Touseef",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: ((30/100)*height) / 2 - 70,
                      left: width / 2 - 70,
                      child: Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('images/conor.jpg'),
                              fit: BoxFit.fitHeight
                          ),
                        ),
                      ),
                    ),


                  ]
              ),


              InfoRow("Date of Birth","12 December, 1992"),
              SizedBox(height: 12,),
              InfoRow("email","touseef@gmail.com"),
              SizedBox(height: 12,),
              InfoRow("Contact","+1 233322233"),
              SizedBox(height: 12,),
              InfoRow("Address","Los Angles, USA"),





            ],
          ),
        ),
      ),
    );
  }

  Column InfoRow(String _heading, String info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12, top: 20),
          child: Text(
            _heading,
            style: TextStyle(
              fontSize: 17,
              color: Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12, top: 12) ,
          child: Text(
            info,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 12,),
        Center(
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width - 32,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
