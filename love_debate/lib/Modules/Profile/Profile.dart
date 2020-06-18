import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:lovedebate/Modules/Profile/BasicInfo.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double width=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: GlobalColors.firstColor,
        backgroundColorEnd: GlobalColors.secondColor,
        title:  Text('Profile',style:TextStyle(color: Colors.white ,fontSize: 30, fontFamily: 'Satisfy', fontWeight:  FontWeight.bold)),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Upper Body
                Stack(
                    children: <Widget>[
                      //Gradient Background...
                      Container(
                        height: (30/100)*height,
                        width: width,
                         //color: Colors.white,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white
                              ]
                          ),
                        ),
                      ),

                      //Overlay
                      Container(
                        height: (30/100)*height,
                        width: width,
                        color: Colors.white,
                        padding: EdgeInsets.only(bottom: 8),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Muhammad Touseef",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 18
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: ((30/100)*height) / 2 - 70,
                        left: width / 2 - 60,
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('images/conor.jpg'),
                                fit: BoxFit.fitHeight
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
                SizedBox(height: 8,),
                ProfileListItems("Basic Info",Icon(Icons.info_outline)),
                ProfileListItems("Ethnicity/Religion",Icon(Icons.info_outline,)),
                ProfileListItems("Education/Job",Icon(Icons.info_outline,)),
                ProfileListItems("Family/Contact",Icon(Icons.info_outline,)),
                ProfileListItems("About me/Life Style",Icon(Icons.info_outline,)),
                ProfileListItems("Photos",Icon(Icons.info_outline,)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell ProfileListItems(String text,Icon icon,) {
    return InkWell(
      onTap: (){
        setState(() {
          Navigator.push(context, CupertinoPageRoute(builder: (context) => BasicInfo()));

        });
      },
      child: Column(
        children: <Widget>[
          Card(
            elevation: 5,

            child: Container(
              margin: EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 4,),
                    Icon(Icons.info_outline,color:Colors.black,size: 28,),
                    SizedBox(width: 12,),
                    Expanded(child: Text(text,style: TextStyle(fontSize: 17),)),
                    SizedBox(width: 8,),
                    Icon(Icons.edit,size: 24,color: Colors.blueGrey,),
                    SizedBox(width: 8,),
                  ],
                ),
              ),
          ),

//          Padding(
//            padding: const EdgeInsets.only(right: 16, left: 16),
//            child: Container(
//              height: 1,
//              color:  GlobalColors.firstColor,//Colors.grey,
//            ),
//          )
        ],
      ),
    );
  }

}
