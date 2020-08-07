import 'package:app_push_notifications/Modules/Preferences/PreferencesOnBoarding.dart';
import 'package:app_push_notifications/Modules/Profile/Profile.dart';
import 'package:app_push_notifications/Modules/Matched/Matched.dart';
import 'package:app_push_notifications/Modules/Profile/MyPreferences.dart';
import 'package:app_push_notifications/Modules/PreMatches/PreMatches.dart';
import 'package:app_push_notifications/Modules/Stats/Stats.dart';
import 'package:flutter/material.dart';
import 'package:app_push_notifications/Modules/Chat/UserChatList.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';

import '../Modules/PreMatches/Rounds/Rounds.dart';


class TabBarControllerPage extends StatefulWidget {
  @override
  _TabBarControllerPageState createState() => _TabBarControllerPageState();
}

class _TabBarControllerPageState extends State<TabBarControllerPage> {


  var _curIndex = 2;
  var tabBarChildren = [
    Matched(),
    UserChatList(),
    PreMatches(),
    PreferencesOnBoarding(),
    Profile(),
  ];

  Color FloatingbtnSelected=GlobalColors.firstColor;


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite,size: 30,),
        backgroundColor: FloatingbtnSelected,
        onPressed: (){
          setState(() {
            _curIndex = 2;
            if(_curIndex==2){
              FloatingbtnSelected=GlobalColors.firstColor;
              _curIndex=2;
            }
            else{
              FloatingbtnSelected=Colors.blueGrey;
            }
          });
        },

      ),

      body:Center(
        child:tabBarChildren[_curIndex],
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }


  Widget bottomNavigationBar() => BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      //backgroundColor: Colors.white,
      currentIndex: _curIndex,
      unselectedItemColor: Colors.blueGrey,
      selectedItemColor: GlobalColors.firstColor,

      onTap: (index){
        setState(() {
          _curIndex = index;
          if(_curIndex==2){
            FloatingbtnSelected=GlobalColors.firstColor;
          }
          else{
            FloatingbtnSelected=Colors.blueGrey;
          }
        });
      },
      items:[

        barItem(icon:Icons.person_outline,title: 'Matched'),
        barItem(icon:Icons.chat,title: 'Chat'),
        barItem( title: ""),
        barItem(icon: Icons.filter_list, title:'Preferences', ),
        barItem(icon:Icons.menu, title:'More'),
      ]
  );

  BottomNavigationBarItem barItem({IconData icon , String title}){
    return BottomNavigationBarItem(
      icon: Icon(icon, size: 30,),
      title: Text(title),
    );
  }


}