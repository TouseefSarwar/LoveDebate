
import 'package:app_ovedebatef/Globals/Colors.dart';
import 'package:app_ovedebatef/Models/RoundItemModel.dart';
import 'package:app_ovedebatef/Screens/Login.dart';
import 'package:app_ovedebatef/Screens/Matched.dart';
import 'package:app_ovedebatef/Screens/PreMatches.dart';
import 'package:app_ovedebatef/Utils/HexColor.dart';
import 'package:app_ovedebatef/Widgets/CustomButtons.dart';
import 'package:app_ovedebatef/Widgets/CustomTextFeilds.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bubble/bubble.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';



//
//class Rounds extends StatefulWidget {
//  @override
//  _RoundsState createState() => _RoundsState();
//}
//class _RoundsState extends State<Rounds> {
//  bool round=false;
//  bool round1=false;
//  bool round2=false;
//  @override
//  Widget build(BuildContext context) {
//
//    double _height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
//    double _width=MediaQuery.of(context).size.width;
//    double _itemheight=(10/100)*_height;
//
//    TextEditingController txtEmailController = TextEditingController();
//    FocusNode txtEmailFocusNode = FocusNode();
//
//
//    return Scaffold(
//      appBar: GradientAppBar(
//        centerTitle: true,
//        title: Text('Rounds'),
//    backgroundColorStart: HexColor('#ED2E77'),
//    backgroundColorEnd: HexColor('#942ED8'),
//    ),
//      body: SafeArea(
//        top: true,
//        child: Container(
//          height: _height,
//          //color: Colors.blue,
//          child: Column(
//            children: <Widget>[
////            RoundsItem(_itemheight, _width, "Round 1", round),
////            RoundsItem(_itemheight, _width, "Round 2", round1),
////            RoundsItem(_itemheight, _width, "Round 3", round2),
//              RoundsItem(_itemheight, _width, RoundList[0].title, false,0),
//              RoundsItem(_itemheight, _width, RoundList[1].title, false,1),
//              RoundsItem(_itemheight, _width, RoundList[2].title, false,2),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//  InkWell RoundsItem(double _itemheight, double _width,String text,bool expanded,int index) {
//    return InkWell(
//      onTap: (){
//        setState(() {
//          if(RoundList[index].expanded==false){
//            RoundList[index].expanded=true;
//            for(int i=0;i<=index;i++){
//              if(i!=index){
//                RoundList[i].expanded=false;
//              }
//            }
//          }
//          else if(RoundList[index].expanded==true){
//            RoundList[index].expanded=false;
//          }
//        });
//      },
//      child: Container(
//        height:(RoundList[index].expanded==false)? _itemheight:(70/100)*_itemheight*10,
//        width: _width,
//        // color: Colors.greenAccent,
//        child:(RoundList[index].expanded==false)? Card(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              Text(text,style: TextStyle(fontSize: 20,color: Color(0xff6684EC))),
//            ],
//          ),
//        ): Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            Container(
//                height: _itemheight/2,
//                margin: EdgeInsets.all(8),
//                child: Text(text,style: TextStyle(fontSize: 20,color: Color(0xff6684EC)))),
//            Expanded(
//              child: Container(
//                child: MessengerUI(),
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//  var RoundList=[
//    RoundItemModel(title: "Round 1",expanded: false,roundNo: 1),
//    RoundItemModel(title: "Round 2",expanded: false,roundNo: 2),
//    RoundItemModel(title: "Round 3",expanded: false,roundNo: 3),
//  ];
//
//}
//class MessengerUI extends StatefulWidget {
//
//
//  @override
//  _MessengerUIState createState() => _MessengerUIState();
//}
//
//class _MessengerUIState extends State<MessengerUI> {
//
//
//  TextEditingController txt_Password = TextEditingController();
//  TextEditingController txt_ConfirmPassword = TextEditingController();
//
//  double isMe=0;
//  double Somebody=1;
//
//  bool  istext=false;
//
//  @override
//  Widget build(BuildContext context) {
//
//    double height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
//
//    double pixelRatio=MediaQuery.of(context).devicePixelRatio;
//    double px=1/pixelRatio;
//
//    BubbleStyle styleSomebody=BubbleStyle(
//      nip: BubbleNip.no,
//      color: HexColor('#ED2E77'),
//      elevation: 1*px,
//      margin: BubbleEdges.only(top: 8,right: 50),
//      alignment: Alignment.topLeft,
//    );
//    BubbleStyle styleMe = BubbleStyle(
//      nip: BubbleNip.no,
//      color: HexColor('#942ED8'),
//      elevation: 1 * px,
//      margin: BubbleEdges.only(top: 8.0, left: 50.0),
//      alignment: Alignment.topRight,
//    );
//    return Scaffold(
//      body: SafeArea(
//        child: Column(
//          children: <Widget>[
//            Expanded(
//              child: Container(
//                decoration: BoxDecoration(
//                    color: Colors.white,
//
//                  border: Border(
//                    bottom: BorderSide(
//                      color: Colors.grey
//                    )
//                  )
//                ),
//
//                height: height,
//                child: ListView(
//                  padding: EdgeInsets.all(8),
//                  children: <Widget>[
//                    Bubble(
//                      alignment: Alignment.center,
//                      color: Color.fromARGB(255, 212, 234, 244),
//                      elevation: 1 * px,
//                      //margin: BubbleEdges.only(top: 5.0),
//                      child: Text('TODAY', style: TextStyle(fontSize: 10)),
//                    ),
//                    ChatItem((isMe!=1)?styleSomebody:styleMe,'Hi Jason. Sorry to bother you. I have a queston for you',),
//                    ChatItem((isMe!=0)?styleSomebody:styleMe,'what is the question',),
//                    ChatItem((isMe!=1)?styleSomebody:styleMe,'Text me later',),
//                    ChatItem((isMe!=0)?styleSomebody:styleMe,'Ok'),
//                    ChatItem((isMe!=1)?styleSomebody:styleMe,'Ok'),
//                    ChatItem((isMe!=0)?styleSomebody:styleMe,'Ok'),
//                    ChatItem((isMe!=1)?styleSomebody:styleMe,'Ok'),
//                    ChatAudioItem((isMe!=0)?styleSomebody:styleMe),
//                    ChatImageItem((isMe!=0)?styleSomebody:styleMe),
//                  ],
//                ),
//              ),
//            ),
//
//            TextMessagebar(txt_ConfirmPassword),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//Container TextMessagebar(TextEditingController txt_ConfirmPassword) {
//  return Container(
//    decoration: BoxDecoration(
//        color: Colors.white,
//        borderRadius: BorderRadius.all(Radius.circular(0)),
//
//    ),
//    height: 50,
//    child: Row(
//      //mainAxisAlignment: MainAxisAlignment.center,
//      //crossAxisAlignment: CrossAxisAlignment.center,
//      children: <Widget>[
//        Expanded(
//          child: MessengerUnderLineTextField(
//            txtIcon: Icons.message,
//            txtHint: "Type Your Message",
//            txtIsSecure: false,
//            keyboardType: TextInputType.text,
//            txtController: txt_ConfirmPassword,
//          ),
//        ),
//        SizedBox(width: 16,),
//        Icon(Icons.send),
//        SizedBox(width: 8,),
//      ],
//    ),
//
//  );
//}
//
//Bubble ChatImageItem(BubbleStyle style) {
//  return Bubble(
//    style: style,
//    child: MessengerImageItem(),
//  );
//}
//
//Bubble ChatAudioItem(BubbleStyle style) {
//  return Bubble(
//    style: style,
//    child: MessengerAudioPlayerItem(),
//  );
//}
//
//Bubble ChatItem(BubbleStyle style,String text,) {
//  return Bubble(
//    style: style,
//    child: Text(text),
//  );
//}
//
//Container MessengerImageItem() {
//  return Container(
//    height: 225,
//    margin: EdgeInsets.only(top: 10),
//    //color: Colors.pink,
//    child: Column(
//      children: <Widget>[
//        Container(
//          height: 25,
//          width: double.infinity,
//          //color: Colors.blueGrey,
//          margin: EdgeInsets.only(left: 4),
//          child: Text('Hamza Arshad'),
//        ),
//        Container(
//          height: 200,
//          color: Colors.green,
//          child: Stack(
//            children: <Widget>[
//              Container(
//                height: 200,
//                color: Colors.blue,
//              ),
//              Positioned(
//                bottom: 8,
//                left: 8,
//                child: Container(
//                  height: 25,
//                  width: 100,
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Text('2.2 MB'),
//                      SizedBox(width: 8,),
//                      Icon(Icons.arrow_downward),
//                    ],
//                  ),
//                  decoration: BoxDecoration(
//                      color: Colors.pink,
//                      borderRadius: BorderRadius.circular(22.5)
//                  ),
//                ),
//              ),
//              Positioned(
//                bottom: 8,
//                right: 8,
//                child: Container(
//                  height: 25,
//                  width: 70,
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Text('6:40 am'),
//                    ],
//                  ),
//                  decoration: BoxDecoration(
//                      color: Colors.pink,
//                      borderRadius: BorderRadius.circular(22.5)
//                  ),
//                ),
//              ),
//
//            ],
//          ),
//        ),
//      ],
//    ),
//  );
//}
//
//class MessengerAudioPlayerItem extends StatefulWidget {
//  @override
//  _MessengerAudioPlayerItemState createState() => _MessengerAudioPlayerItemState();
//}
//
//class _MessengerAudioPlayerItemState extends State<MessengerAudioPlayerItem> {
//  Duration _duration=new Duration();
//  Duration _position=new Duration();
//  AudioPlayer advancedPlayer;
//  AudioCache audioCache;
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    initPlayer();
//  }
//  void initPlayer(){
//    advancedPlayer=new AudioPlayer();
//    audioCache=new AudioCache(fixedPlayer: advancedPlayer);
//    advancedPlayer.durationHandler = (d) => setState(() {
//      _duration = d;
//    });
//    advancedPlayer.positionHandler = (p) => setState(() {
//      _position = p;
//    });
//
//  }
//  String localFilePath;
//  Widget _btn(){
//    return InkWell(
//        onTap: (){
//          setState(() {
//
//          });
//        },
//        child: Icon(Icons.play_arrow));
//  }
//
//  void seekToSecond(int seconds){
//    Duration newDuration=Duration(seconds: seconds);
//    advancedPlayer.seek(newDuration);
//  }
//
//  Widget slider(){
//    return Slider(
//      activeColor: Colors.black,
//      inactiveColor: Colors.pink,
//      value: _position.inMilliseconds.toDouble(),
//      min:0.0,
//      max:_duration.inMilliseconds.toDouble(),
//      onChanged: (double value){
//        setState(() {
//          seekToSecond(value.toInt());
//          value = value;
//        });
//      },
//    );
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      width: 225,
//      child:Column(
//        children: <Widget>[
//          Row(
//            children: <Widget>[
//              SizedBox(width: 8,),
//              Text('Hamza Arshad')
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              // Icon(Icons.play_arrow),
//              _btn(),
//              SizedBox(width: 8,),
//              slider(),
//            ],
//          ),
//        ],
//      ),
//    );
//  }
//}
//
//class MessengerUnderLineTextField extends StatelessWidget {
//
//  final IconData txtIcon;
//  final String txtHint;
//  final bool txtIsSecure;
//  final TextInputType keyboardType;
//  final TextEditingController txtController;
//  MessengerUnderLineTextField({this.txtIcon, this.txtHint, this.txtIsSecure, this.keyboardType, this.txtController});
//  @override
//  Widget build(BuildContext context) {
//    return TextField(
//      style: TextStyle(fontSize: 20),
//      textAlign: TextAlign.justify,
//      textAlignVertical: TextAlignVertical.center,
//      keyboardType: keyboardType,
//      obscureText: txtIsSecure,
//      controller: txtController,
//      decoration: InputDecoration(
//        prefixIcon: Container(transform: Matrix4.translationValues(-8.0, 0.0, 0.0), child: Icon(txtIcon,)),
//        hintText: txtHint,
//        hintStyle: TextStyle(fontSize: 20),
//        filled: false,
//        fillColor: Colors.white,
//        contentPadding: EdgeInsets.symmetric(vertical: 0),
//        border: UnderlineInputBorder(
////              borderRadius: BorderRadius.circular(25),
//            borderSide: BorderSide(
//              width: 1,
//              style: BorderStyle.solid,
//            )
//        ),
//      ),
//    );
//  }
//}
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
