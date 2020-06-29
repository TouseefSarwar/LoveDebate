import 'package:lovedebate/Modules/OnBoarding/PreferencesOnBoarding.dart';
import 'package:lovedebate/Modules/Profile/MyPreferences.dart';
import 'package:lovedebate/Modules/Profile/GeneralSettings.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:lovedebate/Modules/Profile/BasicInfo.dart';
import 'package:lovedebate/Utils/Globals/CustomAppBar.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';

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
      appBar: CustomAppbar.setNavigation("Profile"),

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
                       //color: Colors.white,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white
                            ]
                        ),
                      ),
                    ),

                    //Overlay
                    Container(
                      height: (30/100)*height,
                      width: width,
                      color: Colors.white,
                      padding: EdgeInsets.only(bottom: 8),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Muhammad Touseef",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: ((30/100)*height) / 2 - 70,
                      left: width / 2 - 60,
                      child: Container(
                        height: 120,
                        width: 120,
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
              SizedBox(height: 8,),
              ProfileListItems("Basic Info",Icons.info_outline,1),
//              ProfileListItems("Preferences & Filters",Icons.menu,2),
              ProfileListItems("General Settings",Icons.settings,3),
              ProfileListItems("Notifications",Icons.notifications,4),
              ProfileListItems("Deactivate Account",Icons.cancel,5),
              ProfileListItems("Logout",Icons.power_settings_new,6),
            ],
          ),
        ),
      ),
    );
  }

  InkWell ProfileListItems(String text,IconData icon,int screenNo) {
    return InkWell(
      onTap: (){
        setState(() {
          switch(screenNo){
            case 1:
              Navigator.push(context, CupertinoPageRoute(builder: (context) => BasicInfo()));
              break;
            case 2:
              Navigator.push(context, CupertinoPageRoute(builder: (context) => PreferencesOnBoarding()));
              break;
            case 3:
              Navigator.push(context, CupertinoPageRoute(builder: (context) => GeneralSettings()));
              break;
            case 4:
              Navigator.push(context, CupertinoPageRoute(builder: (context) => BasicInfo()));
              break;
            case 5:
              Navigator.push(context, CupertinoPageRoute(builder: (context) => BasicInfo()));
              break;
            case 6:
              Navigator.push(context, CupertinoPageRoute(builder: (context) => BasicInfo()));
              break;
            default:
              print("Nothing to do");
              break;
          }



//          Navigator.push(context, CupertinoPageRoute(builder: (context) => BasicInfo()));

        });
      },
      child: Column(
        children: <Widget>[
          Card(
            elevation: 3.0,
            child: Container(
              height: 50,
              margin: EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 12,),
                    Icon(icon,color: GlobalColors.firstColor,size: 28,),
                    SizedBox(width: 12,),
                    Expanded(child: Text(text,style: TextStyle(fontSize: GlobalFont.textFontSize, fontWeight: FontWeight.w500),)),
                    SizedBox(width: 8,),
                    Icon(Icons.edit,size: 20,color: Colors.blueGrey,),
                    SizedBox(width: 8,),
                  ],
                ),
              ),
          ),

//          Padding(
//            padding: const EdgeInsets.only(right: 16, left: 16),
//            child: Container(
//              height: 1,
//              color:  GlobalColors.firstColor,//Colors.grey,
//            ),
//          )
        ],
      ),
    );
  }

}
