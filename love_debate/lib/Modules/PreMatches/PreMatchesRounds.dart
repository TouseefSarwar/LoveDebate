import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Modules/Matched/Matched.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/CustomAppBar.dart';

import 'package:lovedebate/Utils/Designables/CustomButtons.dart';
import 'package:lovedebate/Utils/Designables/CustomTextFeilds.dart';

class PreMatchesRounds extends StatefulWidget {
  @override
  _PreMatchesRoundsState createState() => _PreMatchesRoundsState();
}

class _PreMatchesRoundsState extends State<PreMatchesRounds> {

  int _index=0;
  bool isActiveRd1=true;
  bool isActiveRd2=false;
  bool isActiveRd3=false;





  @override
  Widget build(BuildContext context) {

    double _height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double _width=MediaQuery.of(context).size.width;
    double isMe=0;
    double Somebody=0;
    double roundsNo=0;
    double pixelRatio = MediaQuery
        .of(context)
        .devicePixelRatio;
    double px = 1 / pixelRatio;

    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.no,
      //color:Color(0xffF1F1F1),
      color: Colors.white,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8, right: 50),
      alignment: Alignment.topLeft,
    );
    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.no,
      //color:Color(0xffF1F1F1),
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );

    // TextEditingController txt_ConfirmPassword = TextEditingController();

    TextEditingController txtAnswerController = TextEditingController();
    FocusNode txtAnswerFocusNode = FocusNode();

    return Scaffold(
      appBar: CustomAppbar.setNavigation("Rounds"),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _steps(_height,_width,isMe,styleSomebody,styleMe,txtAnswerFocusNode,txtAnswerController,context,roundsNo)
          ],
        ),
      ),
    );
  }

  Widget _steps(double height,double width,double isMe, BubbleStyle styleSomebody, BubbleStyle styleMe, FocusNode txtEmailFocusNode, TextEditingController txtEmailController, BuildContext context,double roundsNo) => Container(

    //margin: EdgeInsets.only(top: 10),
    height: height,
    color: Colors.white,

    child: Theme(
      data: ThemeData(

      ),
      child: Stepper(
        type: StepperType.horizontal,
        steps: [
          Step(
            isActive:(_index==0)?true:false,
            title: Text("Round 1"),
//          content: Text(
//              "In this article, I will tell you how to create a page."),
            content: RoundsItemWidget(height, width, isMe, styleSomebody, styleMe, txtEmailFocusNode, txtEmailController, context,1),
          ),
          Step(
            isActive:(_index==1)?true:false,
            title: Text("Round 2"),
            //    content: Text("Let's look at its construtor."),
            content: RoundsItemWidget(height, width, isMe, styleSomebody, styleMe, txtEmailFocusNode, txtEmailController, context,2),
            // state: StepState.editing,
          ),
          Step(
            isActive:(_index==2)? true:false,
            title: Text("Round 3"),
            // content: Text("Let's look at its construtor."),
            content: RoundsItemWidget(height, width, isMe, styleSomebody, styleMe, txtEmailFocusNode, txtEmailController, context,3),
            // state: StepState.error
          ),
        ],

        currentStep: _index,
        onStepTapped: (index){
          setState(() {
            _index=index;
          });
        },
        controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return Row(
            children: <Widget>[
              Container(
                child: null,
              ),
              Container(
                child: null,
              ),
            ],
          );
        },
      ),
    ),
  );

  Material RoundsItemWidget(double _height, double _width, double isMe, BubbleStyle styleSomebody, BubbleStyle styleMe, FocusNode txtEmailFocusNode, TextEditingController txtEmailController, BuildContext context,double roundsNo) {
    return Material(
      elevation: 0,
      borderOnForeground: true,
      child: Container(
        //color: Colors.cyan,
        height: _height,
        decoration: BoxDecoration(
            color: Color(0xffF1F1F1),
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            )
        ),
        child: Column(
          children: <Widget>[
            // Divider(thickness: 1,),
            SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: (10 / 100) * _height,
                  //color: Colors.deepPurple,
                  margin: EdgeInsets.all(8),
                  child: RoundUserItem(Color(0xffa1c4fd ),Color(0xffc2e9fb),0),
                ),
                Container(
                  height: (10 / 100) * _height,
                  //color: Colors.blueGrey,
                  margin: EdgeInsets.all(8),
                  child: RoundUserItem(Color(0xffffecd2),Color(0xfffcb69f),1),
                ),
              ],
            ),
            Container(
              height: (10 / 100) * _height,
              width: _width,
              // color: Colors.grey,
              child: Text(
                "What are your Hobbies ?", style: TextStyle(fontSize: 24,fontWeight:FontWeight.bold ),
                textAlign: TextAlign.center,),
            ),
            Container(
              height: (35/100)*_height,
              width: _width,
              child: ListView(
                padding: EdgeInsets.all(8),
                children: <Widget>[
                  ChatItem((isMe!=1)?styleSomebody:styleMe,'Hi Jason. Sorry to bother you. I have a queston for you',1),
                  ChatItem((isMe!=0)?styleSomebody:styleMe,'what is the question,,I have a queston for you',0),
//                        ChatItem((isMe!=1)?styleSomebody:styleMe,'Text me later',),
//                        ChatItem((isMe!=0)?styleSomebody:styleMe,'Ok'),

                ],
              ),
            ),
            Container(
              height: 45,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                //color: Color(0xffE0E0E0),
                color: Colors.white,
                border: Border.all(
                    width: 1.0,
                    color: Colors.grey
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(22.0) //                 <--- border radius here
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                        textColor: Colors.black,
                        txtController: txtEmailController,
                        onTapFunc: () {
                          setState(() {
                            FocusScope.of(context).requestFocus(txtEmailFocusNode);
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 8,),
                    Icon(Icons.send,color: GlobalColors.firstColor,)
                  ],
                ),
              ),
            ),
            (roundsNo==3)?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RoundsButton("Connect with user",GlobalColors.firstColor,),
                RoundsButton("Start Again",GlobalColors.firstColor,),
              ],
            ):Container(),
            // Divider(thickness: 1,)
          ],
        ),

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
  Container RoundUserItem(Color colorA,Color colorB,double user) {
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
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [colorA,colorB]),
        // color: color, //new Color.fromRGBO(255, 0, 0, 0.0),
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
      height: 130,
      //width:200,
      //color: Colors.,
      child: Column(
        children: <Widget>[
          Bubble(
            style: style,
            child: Text(text,style: TextStyle(fontSize: 17),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
            ),
          )
        ],
      ),
    );
  }
}




