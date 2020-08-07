import 'package:app_push_notifications/Modules/Profile/BasicInfo.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:app_push_notifications/Utils/Globals/CustomAppBar.dart';


class MyPreferences extends StatefulWidget {
  @override
  _MyPreferencesState createState() => _MyPreferencesState();
}

class _MyPreferencesState extends State<MyPreferences> {
  @override
  Widget build(BuildContext context) {
    double _height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double _width=MediaQuery.of(context).size.width;
    double _itemheight =(15/100)*_height;
    return Scaffold(
      appBar: CustomAppbar.setNavigation("Preferences"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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



  InkWell ProfileListItems(String text,IconData icon,) {
    return InkWell(
      onTap: (){
        setState((){

        });
      },
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                SizedBox(width: 4,),
                Icon(icon,color: GlobalColors.firstColor,size: 28,),
                SizedBox(width: 12,),
                Expanded(child: Text(text,style: TextStyle(fontSize: 17),)),
                SizedBox(width: 8,),
                Icon(Icons.navigate_next,size: 24,color: Colors.blueGrey,),
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
          )
        ],
      ),
    );
  }
}



