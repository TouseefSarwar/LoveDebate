import 'package:app_push_notifications/Modules/Notifications/Notifications.dart';
import 'package:app_push_notifications/Modules/Preferences/PreferencesOnBoarding.dart';
import 'package:app_push_notifications/Modules/Profile/Profile.dart';
import 'package:app_push_notifications/Modules/Matched/Matched.dart';
import 'package:app_push_notifications/Modules/PreMatches/PreMatches.dart';
import 'package:flutter/material.dart';
import 'package:app_push_notifications/Modules/Chat/UI/chatUsersList.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';



class TabBarControllerPage extends StatefulWidget {
  @override
  _TabBarControllerPageState createState() => _TabBarControllerPageState();
}

class _TabBarControllerPageState extends State<TabBarControllerPage> {


  var _curIndex = 2;
  var tabBarChildren = [
    Matched(),
    UsersChatList(),
    PreMatches(),
    Notifications(),
    Profile(),
  ];

  Color FloatingbtnSelected=GlobalColors.firstColor;


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite,size: 24,),
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
        barItem(icon: Icons.notifications_active, title:'Notifications', ),
        barItem(icon:Icons.menu, title:'More'),
      ]
  );

  BottomNavigationBarItem barItem({IconData icon , String title}){
    return BottomNavigationBarItem(
      icon: Icon(icon, size: 24,),
      title: Text(title,style: TextStyle(fontSize: 12),),
    );
  }


}