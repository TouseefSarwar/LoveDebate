
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Modules/PreMatches/Catagories.dart';
import 'package:lovedebate/Modules/PreMatches/Rounds/Rounds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class PreMatches extends StatefulWidget {
  @override
  _PreMatchesState createState() => _PreMatchesState();
}

class _PreMatchesState extends State<PreMatches> {
  @override
  Widget build(BuildContext context) {
    double _height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double _width=MediaQuery.of(context).size.width-90;
    double _itemheight =(15/100)*_height;
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: GlobalColors.firstColor,
        backgroundColorEnd: GlobalColors.secondColor,
        title:  Text('Pre Matches',style:TextStyle(color: Colors.white ,fontSize: 30, fontFamily: 'Satisfy', fontWeight:  FontWeight.bold)),
        centerTitle: true,
        //leading:  Icon(Icons.search,color: Colors.white,),
      ),

      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 8),
          child: ListView(
            children: <Widget>[

              PreMatchesItem(_itemheight, _width, "A",Colors.green,context),

              PreMatchesItem(_itemheight, _width, "M",Colors.blue,context),
              PreMatchesItem(_itemheight, _width, "B",Colors.pink,context),
            ],
          ),
        ),
      ),
    );
  }

}

InkWell PreMatchesItem(double itemheight, double width, String text, Color background,BuildContext context) {
  return InkWell(
    onTap: (){
      Navigator.push(context, CupertinoPageRoute(builder: (context) => Catagories()));
    },

    child: Container(
      height: itemheight,
      width: width,
      // color: Colors.black,
      child: Card(
        elevation: 5,
        child: Row(
          children: <Widget>[
            SizedBox(width: 8,),
            Stack(
              children: <Widget>[
                Container(
                    width: 75,
                    height: 75,
                    // margin: EdgeInsets.only(left: 24),
                    decoration: new BoxDecoration(
                      color: background,
                      shape: BoxShape.circle,
                    )
                ),
                Container(
                    width: 75,
                    height: 75,
                    decoration: new BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      shape: BoxShape.circle,
                    )
                ),
                Container(
                  width: 75,
                  height: 75,
                  child: Center(
                    child: Text(
                      text,style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

              ],
            ),
            Expanded(
              child: Container(
                height: itemheight,
                margin: EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Start Round", maxLines: 2,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold ,color:Color(0xff2E3032)),),
                    SizedBox(height: 4,),
                    Text("This is a start round description.... it is test for double line",style: TextStyle(fontSize: 15,color:Color(0xff2E3022)))
                  ],
                ),
              ),
            ),
            SizedBox(width: 8,),
            Container(
              height: itemheight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.navigate_next,size: 35,color: GlobalColors.firstColor),
                ],
              ),
            ),
          ],
        ),

      ),
    ),
  );
}