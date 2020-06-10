import 'package:app_ovedebatef/Globals/Colors.dart';
import 'package:app_ovedebatef/Screens/Catagories.dart';
import 'package:app_ovedebatef/Screens/Login.dart';
import 'package:app_ovedebatef/Screens/Matched.dart';
import 'package:app_ovedebatef/Screens/MyPreferences.dart';
import 'package:app_ovedebatef/Screens/PreMatches.dart';
import 'package:app_ovedebatef/Screens/Profile.dart';
import 'package:app_ovedebatef/Screens/Stats.dart';
import 'package:app_ovedebatef/Screens/TabStyleRounds.dart';
import 'package:app_ovedebatef/Screens/UserChatList.dart';
import 'package:flutter/material.dart';

import 'Rounds.dart';


class TabBarControllerPage extends StatefulWidget {
  @override
  _TabBarControllerPageState createState() => _TabBarControllerPageState();
}

class _TabBarControllerPageState extends State<TabBarControllerPage> {


  var _curIndex = 2;
  var tabBarChildren = [

    Stats(),
    Matched(),
    PreMatches(),
    Profile(),
    Preferences(),
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
        barItem(icon: Icons.people, title:'Stats', ),
        barItem(icon:Icons.person_outline,title: 'Matched'),
        barItem(title:""),
        barItem(icon:Icons.person,title: 'Profile'),
        barItem(icon:Icons.settings, title:'Settings'),
      ]
  );

  BottomNavigationBarItem barItem({IconData icon , String title}){
    return BottomNavigationBarItem(
      icon: Icon(icon, size: 30,),
      title: Text(title),
    );
  }


}
