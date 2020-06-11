
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';


class MyPreferences extends StatefulWidget {
  @override
  _MyPreferencesState createState() => _MyPreferencesState();
}

class _MyPreferencesState extends State<Preferences> {
  @override

  Widget build(BuildContext context) {
    double _height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double _width=MediaQuery.of(context).size.width;
    double _itemheight =(15/100)*_height;
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: GlobalColors.firstColor,
        backgroundColorEnd: GlobalColors.secondColor,
        title:  Text('Preferences',style:TextStyle(color: Colors.white ,fontSize: GlobalFont.navFontSize, fontFamily: 'Satisfy', fontWeight:  FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 8),
          child: ListView(
            children: <Widget>[
//              InfoRow("What is your age?", "Ohh! Thats a good question."),
//              InfoRow("What is your age?", "Ohh! Thats a good question."),
//              InfoRow("What is your age?", "Ohh! Thats a good question."),
//              InfoRow("What is your age?", "Ohh! Thats a good question."),
//              InfoRow("What is your age?", "Ohh! Thats a good question."),
              ProfileListItems("Preferences",Icons.list ),
              ProfileListItems("Notifications",Icons.notifications_active ),
              ProfileListItems("Help & FAQs",Icons.help ),
              ProfileListItems("Contact Us",Icons.phone ),
              ProfileListItems("Deactivate Account",Icons.account_circle ),
              ProfileListItems("Change Password",Icons.lock ),
              ProfileListItems("Share your Feedback",Icons.feedback ),
              ProfileListItems("Logout",Icons.power_settings_new ),
            ],
          ),
        ),
      ),
    );
  }


Column ProfileListItems(String text, IconData leftIcon ) {
  return Column(
    children: <Widget>[
      Container(
        margin: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            SizedBox(width: 8,),
            Icon(leftIcon,size: 30,color: GlobalColors.firstColor,),
            SizedBox(width: 12,),
            Expanded(child: Text(text,style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color: Color(0xFF434546)),)),
            SizedBox(width: 8,),
            Icon(Icons.navigate_next,size: 24,color:GlobalColors.secondColor),
            SizedBox(width: 8,),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Container(
          height: 1,
          color:  GlobalColors.firstColor,//Colors.grey,
        ),
      ),
    ],
  );
}

