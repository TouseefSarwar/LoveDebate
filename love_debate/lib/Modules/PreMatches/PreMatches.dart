
import 'package:lovedebate/Models/ListModel.dart';
import 'package:lovedebate/Screens/SubViews/RoundsListingCell.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Modules/PreMatches/Catagories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Utils/Globals/CustomAppBar.dart';

class PreMatches extends StatefulWidget {
  @override
  _PreMatchesState createState() => _PreMatchesState();
}

class _PreMatchesState extends State<PreMatches> {

  List<ListModel> list = [ ListModel(title: "Start Round" ,colorCell: Colors.blue ),
    ListModel(title: "Start Round" ,colorCell: Colors.green),
    ListModel(title: "Start Round" ,colorCell: Colors.redAccent),
    ListModel(title: "Start Round" ,colorCell: Colors.purple),
    ListModel(title: "Start Round" ,colorCell: Colors.yellow),
    ListModel(title: "Start Round" ,colorCell: Colors.pink),
    ListModel(title: "Start Round" ,colorCell: Colors.indigo)
  ];


  @override
  Widget build(BuildContext context) {
    double height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double width=MediaQuery.of(context).size.width-90;
    double itemheight =(15/100)*height;
    return Scaffold(
      appBar: CustomAppbar.setNavigation("Pre Matches"),

      body: SafeArea(
        child:ListView.builder(
          itemCount: list.length,
          itemBuilder: (context,index){
            return RoundListingCell(
              title: list[index].title,
              gender: "Male",
              age: "30",
              personHeight: "5'4",
              height: itemheight,
              width: width,
              data: "A",
              avatarColor: list[index].colorCell,
              iconColor: GlobalColors.firstColor,
              index: index,
              action: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context) => Catagories()));
              },
            );
          },
        ),
//        ListView(
//          children: <Widget>[
//
//            RoundListingCell(
//              title: "Start Round",
//              gender: "Male",
//              age: "30",
//              personHeight: "5'4",
//              height: _itemheight,
//              width: _width,
//              data: "A",
//              avatarColor: Colors.pink,
//              iconColor: GlobalColors.firstColor,
//            ),
//            RoundListingCell(
//                title: "Start Round",
//                gender: "Male",
//                age: "30",
//                personHeight: "5'4",
//                height: _itemheight,
//                width: _width,
//                data: "S",
//                avatarColor: Colors.blue,
//                iconColor:  GlobalColors.firstColor
//            ),
//            RoundListingCell(
//                title: "Start Round",
//                gender: "Male",
//                age: "30",
//                personHeight: "5'4",
//                height: _itemheight,
//                width: _width,
//                data: "F",
//                avatarColor: Colors.yellow,
//                iconColor:  GlobalColors.firstColor
//            ),
//            RoundListingCell(
//                title: "Start Round",
//                gender: "Male",
//                age: "30",
//                personHeight: "5'4",
//                height: _itemheight,
//                width: _width,
//                data: "G",
//                avatarColor: Colors.green,
//                iconColor: Colors.grey
//            ),
//            RoundListingCell(
//                title: "Start Round",
//                gender: "Male",
//                age: "30",
//                personHeight: "5'4",
//                height: _itemheight,
//                width: _width,
//                data: "H",
//                avatarColor: Colors.purple,
//                iconColor: Colors.grey
//            ),
//            RoundListingCell(
//                title: "Start Round",
//                gender: "Male",
//                age: "30",
//                personHeight: "5'4",height: _itemheight,
//                width: _width,
//                data: "N",
//                avatarColor: Colors.teal,
//                iconColor: Colors.grey
//            ),
////              PreMatchesItem(_itemheight, _width, "A",Colors.green,context),
////
////              PreMatchesItem(_itemheight, _width, "M",Colors.blue,context),
////              PreMatchesItem(_itemheight, _width, "B",Colors.pink,context),
//          ],
//        ),
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

