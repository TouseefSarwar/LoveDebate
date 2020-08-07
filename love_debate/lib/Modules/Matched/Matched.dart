import 'package:app_push_notifications/Models/ListModel.dart';
import 'package:app_push_notifications/Screens/SubViews/RoundsListingCell.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:app_push_notifications/Screens/TabBarcontroller.dart';
import 'package:app_push_notifications/Utils/Globals/CustomAppBar.dart';
import 'package:app_push_notifications/Utils/Designables/CustomButtons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Matched extends StatefulWidget {
  @override
  _MatchedState createState() => _MatchedState();
}

class _MatchedState extends State<Matched> {

  List<ListModel> list = [ ListModel(title: "Completed Round: " ,colorCell: Colors.blue ),
    ListModel(title: "Completed Round: " ,colorCell: Colors.green),
    ListModel(title: "Completed Round: " ,colorCell: Colors.redAccent),
    ListModel(title: "Completed Round: " ,colorCell: Colors.purple),
    ListModel(title: "Completed Round: " ,colorCell: Colors.yellow),
    ListModel(title: "Completed Round: " ,colorCell: Colors.pink),
    ListModel(title: "Completed Round: " ,colorCell: Colors.indigo)
  ];
  @override
  Widget build(BuildContext context) {

    double height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double width=MediaQuery.of(context).size.width;
    double _itemheight =(15/100)*height;

    return Scaffold(
      appBar: CustomAppbar.setNavigationWithOutBack("Matched"),

      body: SafeArea(
        child:ListView.builder(
          itemCount: list.length,
          itemBuilder: (context,index){
            return RoundListingCell(
              title: list[index].title+"$index",
              gender: "Male",
              age: "30",
              personHeight: "5'4",
              height: _itemheight,
              width: width,
              data: "A",
              avatarColor: list[index].colorCell,
              iconColor: GlobalColors.firstColor,
              index: index,
              action: (){
//                Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
              },
            );
          },
        ),
      ),
    );
  }

  Card MatchedScreensItem(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Container(
        height: 90,
        // color: Colors.blue,
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ProfileImageContainer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Completed Rounds : 1",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                        //5 Icon(Icons.chat,size: 25,)
                      ],
                    ),
                    SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 4 - 5 ,
                          height: 28,
                          child: CustomRaisedButton(
                            buttonText: 'Modules',
                            cornerRadius: 5,
                            textColor: Colors.white,
                            backgroundColor:GlobalColors.firstColor,
                            borderWith: 0,
                            action: (){
                              setState(() {
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 4,),
                        Container(
                          width: MediaQuery.of(context).size.width / 4 - 5,
                          height: 28,
                          child: CustomRaisedButton(
                            buttonText: 'Request',
                            cornerRadius: 5,
                            textColor: Colors.white,
                            backgroundColor:GlobalColors.firstColor,
                            borderWith: 0,
                            action: (){
                              setState(() {
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 4,),
                        Container(
                          width: MediaQuery.of(context).size.width / 4 - 5,
                          height: 28,
                          child: CustomRaisedButton(
                            buttonText: 'Chat',
                            cornerRadius: 5,
                            textColor: Colors.white,
                            backgroundColor:GlobalColors.firstColor,
                            borderWith: 0,
                            action: (){
                              setState(() {
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container MatchedItems(double width, BuildContext context,) {
    return Container(
      height:190,
      //width: width,
      //color: Colors.red,
      margin: EdgeInsets.all(2),
      child: Card(
        elevation: 1,
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              //color: Colors.cyan,
              child: Row(
                children: <Widget>[
                  ProfileImageContainer(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Completed Rounds : 1",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),

                      ],
                    ),
                  ),
                  Container(
                      height: 42,
                      margin: EdgeInsets.all(8),
                      child: Icon(Icons.chat,size: 35,color:Colors.grey,))

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomRaisedButton(
                    buttonText: 'View Modules.Profile',
                    cornerRadius: 5,
                    textColor: Colors.white,
                    backgroundColor:GlobalColors.firstColor,
                    borderWith: 0,
                    action: (){
                      setState(() {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
                      });
//
                    },
                  ),
                  SizedBox(width: 8,),
                  CustomRaisedButton(
                    buttonText: 'Request another',
                    cornerRadius: 5,
                    textColor: Colors.white,
                    backgroundColor:GlobalColors.firstColor,                    borderWith: 0,
                    action: (){
                      setState(() {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
                      });
//
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container ProfileImageContainer() {
    return Container(
        width: 60,
        height:60,
        margin: EdgeInsets.all(12),
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/conor.jpg")

//                image: new NetworkImage(
//                    "https://i.imgur.com/BoN9kdC.png")
            )
        ));
  }
}