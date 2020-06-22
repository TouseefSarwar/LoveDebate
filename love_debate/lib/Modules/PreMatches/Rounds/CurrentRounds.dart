import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:lovedebate/Modules/Matched/Matched.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/CustomAppBar.dart';
import 'package:lovedebate/Utils/Designables/CustomButtons.dart';
import 'package:lovedebate/Utils/Designables/CustomTextFeilds.dart';



class CurrentRounds extends StatefulWidget {
  @override
  _CurrentRoundsState createState() => _CurrentRoundsState();
}

class _CurrentRoundsState extends State<CurrentRounds> {
  @override
  Widget build(BuildContext context) {

    double _height = (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.vertical) - AppBar().preferredSize.height;
    double _width = MediaQuery.of(context).size.width;

    double isMe=0;
    double Somebody=0;

    double roundsNo=0;



    double pixelRatio = MediaQuery
        .of(context)
        .devicePixelRatio;
    double px = 1 / pixelRatio;

    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.no,
      color:Colors.grey,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8, right: 50),
      alignment: Alignment.topLeft,
    );
    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.no,
      color:Colors.grey,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );

    TextEditingController txt_ConfirmPassword = TextEditingController();

    TextEditingController txtEmailController = TextEditingController();
    FocusNode txtEmailFocusNode = FocusNode();
    return Scaffold(
      appBar: CustomAppbar.setNavigation("Current Round"),
      body: Column(
        children: <Widget>[
          Container(
            height: 75,
            width: _width,
            //color: Colors.blue,
            child: Row(
              children: <Widget>[
                Expanded(child: btnRounds("Round 1",1)),
                Expanded(child: btnRounds("Rounds 2",2)),
                Expanded(child: btnRounds("Rounds 3",3)),
              ],
            ),
          ),
          Expanded(
            child: RoundsItemWidget(_height, _width, isMe, styleSomebody, styleMe, txtEmailFocusNode, txtEmailController, context,1),
          ),

        ],
      ),
    );
  }

  Container RoundsItemWidget(double _height, double _width, double isMe, BubbleStyle styleSomebody, BubbleStyle styleMe, FocusNode txtEmailFocusNode, TextEditingController txtEmailController, BuildContext context,double roundsNo) {
    return Container(
           // color: Colors.cyan,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: (10 / 100) * _height,
                      //color: Colors.deepPurple,
                      margin: EdgeInsets.all(8),
                      child: RoundUserItem(Colors.blue,0),
                    ),
                    Container(
                      height: (10 / 100) * _height,
                      //color: Colors.blueGrey,
                      margin: EdgeInsets.all(8),
                      child: RoundUserItem(Colors.pink,1),
                    ),
                  ],
                ),
                Container(
                  height: (7 / 100) * _height,
                  width: _width,
                  // color: Colors.grey,
                  child: Text(
                    "What are your Hobbies ?", style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold ),
                    textAlign: TextAlign.center,),
                ),
                Container(
                  height: (25/100)*_height,
                  width: _width,
                  child: ListView(
                    padding: EdgeInsets.all(8),
                    children: <Widget>[
                      ChatItem((isMe!=1)?styleSomebody:styleMe,'Hi Jason. Sorry to bother you. I have a queston for you',1),
                      ChatItem((isMe!=0)?styleSomebody:styleMe,'what is the question',0),
//                        ChatItem((isMe!=1)?styleSomebody:styleMe,'Text me later',),
//                        ChatItem((isMe!=0)?styleSomebody:styleMe,'Ok'),

                    ],
                  ),
                ),
                Container(
                  height: 45,
                  margin: EdgeInsets.all(8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: UnderLineTextField(
                          focusNode: txtEmailFocusNode,
                          txtHint: "Your answer",
                          isSecure: false,
                          keyboardType: TextInputType.emailAddress,
                          enableBorderColor: Colors.white,
                          focusBorderColor: Colors.white,
                          textColor: Colors.white,
                          txtController: txtEmailController,
                          onTapFunc: () {
                            setState(() {
                              FocusScope.of(context).requestFocus(txtEmailFocusNode);
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 8,),
                      Icon(Icons.send)
                    ],
                  ),
                ),
                (roundsNo==3)?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RoundsButton("Connect with user",GlobalColors.firstColor,),
                    RoundsButton("Start Again",GlobalColors.firstColor,),
                  ],
                ):Container(),
              ],
            ),

          );
  }
  Widget btnRounds(String text,double round) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(8),
      //width: double.infinity,
      child: CustomRaisedButton(
        buttonText: text,
        cornerRadius: 5,
        textColor: Colors.white,
        backgroundColor:GlobalColors.firstColor,
        borderWith: 0,
        action: (){
          setState(() {
           // roundsNo=round;

          });
        },
      ),
    );
  }

  Container RoundsButton(String text,Color color) {
    return Container(
      height: 35,
      margin: EdgeInsets.all(8),
      child: CustomRaisedButton(
        buttonText: text,
        cornerRadius: 22.5,
        textColor: Colors.white,
        backgroundColor: color,
        borderWith: 0,
        action: () {
          setState(() {
            if(text=="Accept"){
              Navigator.push(context, CupertinoPageRoute(builder: (context) =>Matched()));}
          });
        },
      ),
    );
  }
  Container RoundUserItem(Color color,double user) {
//    return CircleAvatar(
//      radius: 28,
//      backgroundColor: color,
//      child: Text("HA"),
//    );
    return Container(
      height: 40,
      width: 100,
      //color: color,
      decoration:BoxDecoration(
        color: color, //new Color.fromRGBO(255, 0, 0, 0.0),
        borderRadius: (user==0)? BorderRadius.only(
          // bottomLeft:Radius.circular(40.0),
          topRight: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),

        ):BorderRadius.only(
          topLeft: Radius.circular(40.0),
          bottomLeft: Radius.circular(40.0),

        ),),
      child: Center(child: Text("HA",style: TextStyle(fontSize: 18),)),
    );
  }

  Container ChatItem(BubbleStyle style, String text,double isMe) {
    return Container(
      height: 105,
      //width:200,
      //color: Colors.blue,
      child: Column(
        children: <Widget>[
          Bubble(
            style: style,
            child: Text(text),
          ),
          Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:(isMe!=0)? MainAxisAlignment.end:MainAxisAlignment.start,
            children: <Widget>[
              (isMe!=0)?Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green
                  ),
                  margin: EdgeInsets.all(4),
                  child: Icon(Icons.add)):Container(),
              SizedBox(width: 8,),
              (isMe!=0)?Container(
                margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red
                  ),
                  child: Icon(Icons.remove)):Container(),
            ],
          )
        ],
      ),
    );
  }
}
