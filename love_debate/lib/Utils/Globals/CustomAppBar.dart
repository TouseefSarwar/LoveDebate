
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';

class CustomAppbar{


  static AppBar setNavigation(String title){
     return AppBar(
      title: Text(title, style: TextStyle(fontFamily: ('Satisfy'),fontSize: GlobalFont.navFontSize, fontWeight: FontWeight.bold,color:  Colors.black),) ,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
    );
  }

}