
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Modules/PreMatches/Rounds/Rounds.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';
import 'package:lovedebate/Utils/HexColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Catagories extends StatefulWidget {
  @override
  _CatagoriesState createState() => _CatagoriesState();
}

class _CatagoriesState extends State<Catagories> {
  @override
  Widget build(BuildContext context) {

    double _height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double _width=MediaQuery.of(context).size.width;
    double _itemheight=(10/100)*_height;

    TextEditingController txtEmailController = TextEditingController();
    FocusNode txtEmailFocusNode = FocusNode();


    return Scaffold(
      appBar: GradientAppBar(
        centerTitle: true,
        title: Text('Catagories',style:TextStyle(color: Colors.white ,fontSize: GlobalFont.navFontSize, fontFamily: 'Satisfy', fontWeight:  FontWeight.bold)),
        backgroundColorStart: GlobalColors.firstColor,
        backgroundColorEnd: GlobalColors.secondColor,
      ),
      body: SafeArea(
        top: true,
        child: ListView(
            children: <Widget>[
              CatagoryItem('Kids',context),
              CatagoryItem("Hobbies",context),
              CatagoryItem("Preferences",context),
              CatagoryItem("Family",context),
              CatagoryItem("Home Town",context),
              CatagoryItem("Job",context),
              CatagoryItem("Future ",context),
            ],

        ),
      ),
    );
  }

  InkWell CatagoryItem(String text,BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => Rounds()));

      },
      child: Container(
        height:75,
        width:double.infinity,
//      decoration: BoxDecoration(
//          gradient: LinearGradient(
//              begin: Alignment.topLeft,
//              end: Alignment.bottomRight,
//              colors: <Color>[HexColor('#ED2E77'),HexColor('#942ED8')]
//          )
//      ),
        //margin: EdgeInsets.all(2),
        child: Card(
          elevation: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 8,),
              Container(
                height: 30,
                width: 30,
                //color: Colors.pink,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('images/question.png'), fit: BoxFit.cover),),
              ),
              SizedBox(width: 16,),
              Expanded(child: Text(text,style: TextStyle(fontSize: 17,color: Colors.black,),)),
              Icon(Icons.navigate_next,size: 25,),
              SizedBox(width: 12,),

            ],
          ),
        ),
      ),
    );
  }
}
