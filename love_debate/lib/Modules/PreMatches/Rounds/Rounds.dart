
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Modules/Matched/Matched.dart';
import 'package:lovedebate/Widgets/CustomButtons.dart';
import 'package:lovedebate/Widgets/CustomTextFeilds.dart';
import 'package:bubble/bubble.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';


class Rounds extends StatefulWidget {
  @override
  _RoundsState createState() => _RoundsState();
}

class _RoundsState extends State<Rounds> {

  double isMe=0;
  double Somebody=0;

  bool  istext=false;

  //bool currentUser=true;

  TextEditingController txt_ConfirmPassword = TextEditingController();

  TextEditingController txtEmailController = TextEditingController();
  FocusNode txtEmailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    double _height = (MediaQuery
        .of(context)
        .size
        .height - MediaQuery
        .of(context)
        .padding
        .vertical) - AppBar().preferredSize.height;
    double _width = MediaQuery
        .of(context)
        .size
        .width;
    double _itemheight = (10 / 100) * _height;

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
    return Scaffold(
      appBar: GradientAppBar(
        centerTitle: true,
        title: Text('Rounds',style:TextStyle(color: Colors.white ,fontSize: 30, fontFamily: 'Satisfy', fontWeight:  FontWeight.bold)),
        backgroundColorStart: GlobalColors.firstColor,
        backgroundColorEnd: GlobalColors.secondColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ExapandableRoundsItem(_width, _height, styleSomebody, styleMe, context,"Round 1",1),
            ExapandableRoundsItem(_width, _height, styleSomebody, styleMe, context,"Round 2",2),
            ExapandableRoundsItem(_width, _height, styleSomebody, styleMe, context,"Round 3",3),
          ],
        ),
      ),
    );
  }

  ExpandablePanel ExapandableRoundsItem(double _width, double _height, BubbleStyle styleSomebody, BubbleStyle styleMe, BuildContext context,String RoundNo,double RoundIndex) {
    return ExpandablePanel(
            header: Container(height: 50,width:_width,child: Card(child: Center(child: Text(RoundNo,style: TextStyle(fontSize: 18),)),),),
//              collapsed: Text("This is collapsed", softWrap: true,
//                maxLines: 2,
//                overflow: TextOverflow.ellipsis,),
            expanded: Column(
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
                  height: (15/100)*_height,
                  width: _width,
                  child: ListView(
                    padding: EdgeInsets.all(8),
                    children: <Widget>[
                      ChatItem((isMe!=1)?styleSomebody:styleMe,'Hi Jason. Sorry to bother you. I have a queston for you',),
                      ChatItem((isMe!=0)?styleSomebody:styleMe,'what is the question',),
//                        ChatItem((isMe!=1)?styleSomebody:styleMe,'Text me later',),
//                        ChatItem((isMe!=0)?styleSomebody:styleMe,'Ok'),
                    ],
                  ),
                ),
                (RoundIndex!=3)?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RoundsButton("Accept",Colors.green),
                    RoundsButton("Decline",GlobalColors.firstColor,),
                  ],
                ):Container(),
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
                        (RoundIndex==3)?Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RoundsButton("Connect with user",GlobalColors.firstColor,),
                            RoundsButton("Start Again",GlobalColors.firstColor,),
                          ],
                ):Container()
              ],
            ),
            //tapHeaderToExpand: true,
            hasIcon: false,
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

  Bubble ChatItem(BubbleStyle style, String text,) {
    return Bubble(
      style: style,
      child: Text(text),
    );
  }

}
