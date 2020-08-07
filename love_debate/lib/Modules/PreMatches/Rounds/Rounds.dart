import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_push_notifications/Models/OnBoardingModel.dart';
import 'package:app_push_notifications/Modules/Matched/Matched.dart';
import 'package:app_push_notifications/Utils/Constants/WebService.dart';
import 'package:app_push_notifications/Utils/Controllers/ApiBaseHelper.dart';
import 'package:app_push_notifications/Utils/Controllers/AppExceptions.dart';
import 'package:app_push_notifications/Utils/Controllers/Loader.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:app_push_notifications/Utils/Globals/CustomAppBar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_push_notifications/Utils/Designables/CustomButtons.dart';
import 'package:app_push_notifications/Utils/Designables/CustomTextFeilds.dart';
import 'package:app_push_notifications/Utils/Globals/Fonts.dart';
import 'package:app_push_notifications/Utils/Globals/GlobalFunctions.dart';
import 'SubViews/RoundsDataModelClass.dart';

class Rounds extends StatefulWidget {
  String catId;
  Rounds({this.catId});
  @override
  _RoundsState createState() => _RoundsState();
}

class _RoundsState extends State<Rounds> {

  int _index=0;
  bool isActiveRd1=true;
  bool isActiveRd2=false;
  bool isActiveRd3=false;
  bool done=false;
  int accept=0;
  bool status=false;
  int apiCall = 0;
  var chatList=[
    RoundsDataModelClass(isMe: 1.0,answerText: "What is your name"),
  ];

  List<OnBoardingDataModel> roundsQuestion = List<OnBoardingDataModel>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCall =1;
    setState(() {
      getRoundsQuestion();
    });

  }

  @override
  Widget build(BuildContext context) {

    double _height=(MediaQuery.of(context).size.height) -(AppBar().preferredSize.height);
    double _width=MediaQuery.of(context).size.width;


    double isMe=0;
    double roundsNo=0;
    double pixelRatio = MediaQuery
        .of(context)
        .devicePixelRatio;
    double px = 1 / pixelRatio;

    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.no,
      color: Colors.white,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8, right: 50),
      alignment: Alignment.topLeft,
    );
    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.no,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );

// TextEditingController txt_ConfirmPassword = TextEditingController();

    TextEditingController txtAnswerController = TextEditingController();
    FocusNode txtAnswerFocusNode = FocusNode();

    return Scaffold(
      appBar: CustomAppbar.setNavigation("Rounds"),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _steps(_height,_width,isMe,styleSomebody,styleMe,txtAnswerFocusNode,txtAnswerController,context,roundsNo)
            ],
          ),
        ),
      ),
    );
  }

  Widget _steps(double height,double width,double isMe, BubbleStyle styleSomebody, BubbleStyle styleMe, FocusNode txtEmailFocusNode, TextEditingController txtEmailController, BuildContext context,double roundsNo) => Container(

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
// content: Text(
// "In this article, I will tell you how to create a page."),
            content: RoundsItemWidget(height, width, isMe, styleSomebody, styleMe, txtEmailFocusNode, txtEmailController, context,1),
          ),
          Step(
            isActive:(_index==1)?true:false,
            title: Text("Round 2"),
// content: Text("Let's look at its construtor."),
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

  Material RoundsItemWidget(double _height, double _width, double isMe, BubbleStyle styleSomebody, BubbleStyle styleMe, FocusNode txtAnswerFN, TextEditingController txtAnswerTF, BuildContext context,double roundsNo) {
    return Material(
      elevation: 0,
      borderOnForeground: true,
      child: (apiCall == 0)?Container(
//color: Colors.cyan,
        height: _height - AppBar().preferredSize.height - MediaQuery.of(context).padding.vertical,
        decoration: BoxDecoration(
            color: Color(0xffF1F1F1),
//            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
//mainAxisSize: MainAxisSize.min,
            children: <Widget>[
// Divider(thickness: 1,),
              SizedBox(height: 24,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 70,
                    child: RoundUserItem(Color(0xffa1c4fd ),Color(0xffc2e9fb),0),
                  ),
                  Container(
                    height: 70,
                    child: RoundUserItem(Color(0xffffecd2),Color(0xfffcb69f),1),
                  ),
                ],
              ),
              SizedBox(height: 12,),
              Text(
                roundsQuestion[_index].qaQuestion, style: TextStyle(fontSize: 21,fontWeight:FontWeight.bold,),
                textAlign: TextAlign.center,),
              SizedBox(height: 12,),

              // Ider kisi or ka answer



              // Accept decline Button
              // Ider apna answer

              Expanded(
                child: Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                      itemCount: chatList.length,
                      itemBuilder:(BuildContext context,int index){
                        return ChatItem((chatList[index].isMe!=1)?styleSomebody:styleMe,chatList[index].answerText,chatList[index].isMe.toDouble());
                      }),
                ),
              ),
              (done==false)?Container(
                height: 45,
                margin: EdgeInsets.all(8),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child:UnderLineTextField(
                        focusNode: txtAnswerFN,
                        txtHint: " Your answer",
                        isSecure: false,
                        keyboardType: TextInputType.emailAddress,
                        enableBorderColor: Colors.white,
                        focusBorderColor: Colors.white,
                        textColor: Colors.black,
                        txtController: txtAnswerTF,
                        onTapFunc: () {
                          setState(() {
                            FocusScope.of(context).requestFocus(txtAnswerFN);
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 16,),
                    InkWell(
                        onTap: (){
                          setState(() {
                            if(txtAnswerTF.text.isEmpty){
                              GFunction.showError("Write your answer", context);
                            }else{
                              done=true;
                              chatList.add(RoundsDataModelClass(isMe: 0.0,answerText: txtAnswerTF.text));
                            }

                          });
                        },
                        child: Icon(Icons.send,color: GlobalColors.firstColor,))
                  ],
                ),
              ):Container(
                width: double.infinity,
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(22.5))
                ),
                child: (_index == 2) ? Container():btnRounds("Next",1),
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

      ):Center(child: Loading(),),
    );
  }
  Widget btnRounds(String text,double round) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(8),
      child: CustomRaisedButton(
        buttonText: text,
        cornerRadius: 5,
        textColor: Colors.white,
        backgroundColor:GlobalColors.firstColor,
        borderWith: 0,
        action: (){
          setState(() {
            done=false;
            chatList.clear();
            print("heerree1");
            if(_index<3){
              _index++;
            }

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
    return Container(
      height: 40,
      width: 100,
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
//      height: (isMe!=0)?140:80,
      width: double.infinity,
//color: Colors.,
      child: Column(
//mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Bubble(
            padding:BubbleEdges.all(12),
            style: style,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                        child: Text(
                          text,
                          style: TextStyle(fontSize: GlobalFont.textFontSize),
                          overflow: TextOverflow.ellipsis,
                        )
                    ),
                    SizedBox(width: 6,),
                  ],
                ),

              ],
            ),
          ),


          (status==true)?AnswerStatus(isMe):Padding(
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
                    child: InkWell(
                        onTap: (){
                          setState(() {
                            accept=1;
                            status=true;

                          });
                        },
                        child: Icon(Icons.check,color: Colors.white,size: 34,))):Container(),
                SizedBox(width: 8,),
                (isMe!=0)?Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red
                    ),
                    child: InkWell(
                        onTap: (){
                          setState(() {
                            accept=2;
                            status=true;
                          });
                        },
                        child: Icon(Icons.clear,color: Colors.white,size: 34,))):Container(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget AnswerStatus(double isMe){

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(right: 8,top: 8),
      child: (isMe!=0)?Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          (accept==1)?Text("Accepted",style: TextStyle(fontSize: 12),):Text("Rejected",style: TextStyle(fontSize: 12),)
        ],
      ):Container(),
    );
  }

  Widget answerTextField( FocusNode focusNode, TextEditingController txtFeild,String text ,bool isSecure, TextInputType keyboardType ) {
    return UnderLineTextField(
      focusNode: focusNode,
      txtHint: text,
      isSecure: isSecure,
      keyboardType: keyboardType,
// enableBorderColor: Colors.white,
      focusBorderColor: Colors.grey,
      textColor: Colors.black,
      txtController: txtFeild,
      onTapFunc: () {
        setState(() {
          FocusScope.of(context).requestFocus(FocusNode());

        });
      },
    );
  }

  ///API Call
  void getRoundsQuestion(){
    Map<String, dynamic> body = {
    };

    try {
      ApiBaseHelper().fetchService(method: HttpMethod.get,authorization: false, url: WebService.rounds+"/${widget.catId}",body: body,isFormData: false).then(
              (response) async{

            var res = response as http.Response;
            if (res.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(res.body);
              if(responseJson.containsKey('success')){
                responseJson["success"].forEach((v) {
                  roundsQuestion.add(OnBoardingDataModel.fromJson(v));
                });
                apiCall = 0;
                setState(() {});

              }else{
                apiCall = 0;
                setState(() {});
                print("Oh no response");
              }
            }else if (res.statusCode == 401){
              apiCall = 0;
              setState(() {});
              Map<String, dynamic> err = json.decode(res.body);
              GFunction.showError(err['error'].toString(), context);
            }else{
              apiCall = 0;
              setState(() {});
              GFunction.showError(res.reasonPhrase.toString(), context);
            }
          });
    } on FetchDataException catch(e) {
      apiCall = 0;
      setState(() {});
      GFunction.showError(e.toString(), context);
    }
  }



}



