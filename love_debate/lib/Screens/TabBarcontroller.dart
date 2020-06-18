import 'package:lovedebate/Modules/Profile/Profile.dart';
import 'package:lovedebate/Modules/Matched/Matched.dart';
import 'package:lovedebate/Modules/Prefrences/MyPreferences.dart';
import 'package:lovedebate/Modules/PreMatches/PreMatches.dart';
import 'package:lovedebate/Modules/Stats/Stats.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Screens/UserChatList.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';

import '../Modules/PreMatches/Rounds/Rounds.dart';


class TabBarControllerPage extends StatefulWidget {
  @override
  _TabBarControllerPageState createState() => _TabBarControllerPageState();
}

class _TabBarControllerPageState extends State<TabBarControllerPage> {


  var _curIndex = 0;
  var tabBarChildren = [

    PreMatches(),
    Matched(),
    UserChatList(),
    MyPreferences(),
  ];

  Color FloatingbtnSelected=GlobalColors.firstColor;


  @override
  Widget build(BuildContext context) {


    return Scaffold(

//      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     floatingActionButton: FloatingActionButton(
//       child: Icon(Icons.favorite,size: 30,),
//       backgroundColor: FloatingbtnSelected,
//       onPressed: (){
//         setState(() {
//           _curIndex = 2;
//           if(_curIndex==2){
//             FloatingbtnSelected=GlobalColors.firstColor;
//           }
//           else{
//             FloatingbtnSelected=Colors.blueGrey;
//           }
//         });
//       },
//
//     ),

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
          if(_curIndex==0){
            FloatingbtnSelected=GlobalColors.firstColor;
          }
          else{
            FloatingbtnSelected=Colors.blueGrey;
          }
        });
      },
      items:[
        barItem(icon: Icons.home, title:'Home', ),
        barItem(icon:Icons.person_outline,title: 'Matched'),
        barItem(icon:Icons.chat,title: 'Chat'),
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
