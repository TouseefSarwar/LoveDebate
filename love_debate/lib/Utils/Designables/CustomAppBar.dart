
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_push_notifications/Utils/Globals/Fonts.dart';

class CustomAppbar{


  static AppBar setNavigation(String title){
     return AppBar(
      centerTitle: true,
      title: Text(title, style: TextStyle(fontSize: GlobalFont.navFontSize, fontWeight: FontWeight.bold,color:  Colors.black),) ,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
    );
  }


  static AppBar setNavigationWithOutBack(String title){
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(title, style: TextStyle(fontSize: GlobalFont.navFontSize, fontWeight: FontWeight.bold,color:  Colors.black),) ,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
    );
  }

}