
import 'package:app_push_notifications/Models/PreMatches.dart';
import 'package:app_push_notifications/Models/RoundsModel.dart';
import 'package:app_push_notifications/Utils/Constants/SharedPref.dart';
import 'package:app_push_notifications/Utils/Constants/WebService.dart';
import 'package:app_push_notifications/Utils/Controllers/ApiBaseHelper.dart';
import 'package:app_push_notifications/Utils/Controllers/AppExceptions.dart';
import 'package:app_push_notifications/Utils/Controllers/Loader.dart';
import 'package:app_push_notifications/Utils/Designables/CustomAppBar.dart';
import 'package:app_push_notifications/Utils/Designables/CustomButtons.dart';
import 'package:app_push_notifications/Utils/Designables/CustomTextFeilds.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:app_push_notifications/Utils/Globals/Fonts.dart';
import 'package:app_push_notifications/Utils/Globals/UserSession.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart'; 
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_push_notifications/Utils/Globals/GlobalFunctions.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Rounds extends StatefulWidget {
  String catId;
  Matches perMatch;
  String idNoti;
  Rounds({this.catId, this.perMatch, this.idNoti});
  @override
  _RoundsState createState() => _RoundsState();
}

class _RoundsState extends State<Rounds> {


  TextEditingController answerTF = TextEditingController();
  FocusNode answerFN = FocusNode();
  SharedPref prf = SharedPref();

  ///Variables....
  RoundsModel roundsQuestion;
  int currentIndex = 0;
  int apiCall = 0;
  var check = "";
  String myName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }
  getData() async{
    myName = await prf.getBy(UserSession.name);
    print("CHeckkkerr::: "+check);
    apiCall =1;
    setState(() {
      getRoundsQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:  CustomAppbar.setNavigation("Rounds"),
      body: SafeArea(
        bottom: false,
        child: (apiCall == 0)?Column(
          children: [
            Expanded(
              child: Stepper(
                physics : FixedExtentScrollPhysics(),
                type: StepperType.horizontal,
//                onStepTapped: (index){
//                  setState(() {
//                    print(index);
//                    currentIndex = index;
//                  });
//                },
                steps: [
                  Step(
                    isActive: (currentIndex == 0)? true: false,
                    title: Text(""),
                    content: CreateQuestionItem(size),
                  ),
                  Step(
                    isActive: (currentIndex == 1)? true: false,
                    title: Text(""),
                    content: CreateQuestionItem(size),
                  ),
                  Step(
                    isActive: (currentIndex == 2)? true: false,
                    title: Text(""),
                    content: CreateQuestionItem(size),
                  ),
                ],
                currentStep: currentIndex,
                controlsBuilder: (BuildContext context,  {VoidCallback onStepContinue, VoidCallback onStepCancel}){
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
          ],
        ) : Center(child: Loading(),),
      ),
    );
  }

  Widget CreateQuestionItem(Size size){
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffF1F1F1),
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25,),
          ///Avatars Row For Letf/Right
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UserAvatar(isMe: true),
                UserAvatar(isMe: false),
              ],
            ),
          SizedBox(height: 8,),
          ///Questions
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              (currentIndex == 0)?roundsQuestion.questionOne:(currentIndex ==1)?roundsQuestion.questionTwo:roundsQuestion.questionThree,
              style: TextStyle(fontSize: 19,fontWeight:FontWeight.bold,),
              textAlign: TextAlign.center,
            ),
          ),


          (check == "user") ? AnswersChatItem(isRight: check)
          :(check == "player") ? AnswersChatItem(isRight: check):
          Container(),

          SizedBox(height: 12,),
          (check =="first" && currentIndex == 0 &&  roundsQuestion.rUserAnsOne == null && roundsQuestion.rStatus != 0)?Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///Answer TextFeild
              Expanded(child: AnswerTextFeild(answerTF, answerFN)),
              SizedBox(width: 8,),
              StatusButton(backgroundColor: Colors.transparent, icon: Icons.send,iconColor: GlobalColors.firstColor, radius: 0, size: 32,action: (){
                SendAnswer();
              })
            ],
          )
          :(check == "player" && currentIndex == 0 &&  roundsQuestion.rUserAnsOne == null && roundsQuestion.rStatus != 0) ? Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///Answer TextFeild
            Expanded(child: AnswerTextFeild(answerTF, answerFN)),
            SizedBox(width: 8,),
            StatusButton(backgroundColor: Colors.transparent, icon: Icons.send,iconColor: GlobalColors.firstColor, radius: 0, size: 32,action: (){
              SendAnswer();
            })
          ],
        )
          : (check == "player" &&currentIndex == 1 &&  roundsQuestion.rUserAnsTwo == null && roundsQuestion.rStatus != 0) ? Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ///Answer TextFeild
        Expanded(child: AnswerTextFeild(answerTF, answerFN)),
        SizedBox(width: 8,),
        StatusButton(backgroundColor: Colors.transparent, icon: Icons.send,iconColor: GlobalColors.firstColor, radius: 0, size: 32,action: (){
          SendAnswer();
        })
      ],
    )
          :(check == "player" &&currentIndex == 2 &&  roundsQuestion.rUserAnsThree == null && roundsQuestion.rStatus != 0) ? Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ///Answer TextFeild
        Expanded(child: AnswerTextFeild(answerTF, answerFN)),
        SizedBox(width: 8,),
        StatusButton(backgroundColor: Colors.transparent, icon: Icons.send,iconColor: GlobalColors.firstColor, radius: 0, size: 32,action: (){
          SendAnswer();
        })
      ],
    )
          :(check == "user" &&currentIndex == 0 &&  roundsQuestion.rPlayerAnsOne == null && roundsQuestion.rStatus != 0) ? Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///Answer TextFeild
          Expanded(child: AnswerTextFeild(answerTF, answerFN)),
          SizedBox(width: 8,),
          StatusButton(backgroundColor: Colors.transparent, icon: Icons.send,iconColor: GlobalColors.firstColor, radius: 0, size: 32,action: (){
            SendAnswer();
          })
        ],
      )
          : (check == "user" &&currentIndex == 1 &&  roundsQuestion.rPlayerAnsTwo == null && roundsQuestion.rStatus != 0) ? Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///Answer TextFeild
          Expanded(child: AnswerTextFeild(answerTF, answerFN)),
          SizedBox(width: 8,),
          StatusButton(backgroundColor: Colors.transparent, icon: Icons.send,iconColor: GlobalColors.firstColor, radius: 0, size: 32,action: (){
            SendAnswer();
          })
        ],
      )
          :(check == "user" &&currentIndex == 2 &&  roundsQuestion.rPlayerAnsThree == null && roundsQuestion.rStatus != 0) ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///Answer TextFeild
              Expanded(child: AnswerTextFeild(answerTF, answerFN)),
              SizedBox(width: 8,),
              StatusButton(backgroundColor: Colors.transparent, icon: Icons.send,iconColor: GlobalColors.firstColor, radius: 0, size: 32,action: (){
                SendAnswer();
              })
            ],
          )
              :Container(),
          SizedBox(height: 8,),
          (currentIndex == 0 && roundsQuestion.rPlayerAnsOne!= null && roundsQuestion.rStatus != 0) ?Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomRaisedButton(
                    buttonText: (currentIndex==0 || currentIndex==1)?"Next": "Connect",
                    cornerRadius: 5.0,
                    textColor: Colors.white,
                    backgroundColor: GlobalColors.firstColor,
                    borderWith: 0.0,
                    action: (){
                      currentIndex = 1;
                      setState(() {});
                    },

                  ),
                ),
                SizedBox(width: 8,),
                (currentIndex ==2)?
                Expanded(
                  child: CustomRaisedButton(
                    buttonText: (currentIndex==0 || currentIndex==1)?"Next": "Another Round",
                    cornerRadius: 5.0,
                    textColor: Colors.white,
                    backgroundColor: GlobalColors.firstColor,
                    borderWith: 0.0,
                    action: (){
                    },

                  ),
                ): Container(),
              ],
            ),
          )
          :(currentIndex == 1 && roundsQuestion.rPlayerAnsTwo!= null && roundsQuestion.rStatus != 0) ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomRaisedButton(
                    buttonText: (currentIndex==0 || currentIndex==1)?"Next": "Connect",
                    cornerRadius: 5.0,
                    textColor: Colors.white,
                    backgroundColor: GlobalColors.firstColor,
                    borderWith: 0.0,
                    action: (){
                      currentIndex = 2;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: 8,),
                (currentIndex ==2)?
                Expanded(
                  child: CustomRaisedButton(
                    buttonText: (currentIndex==0 || currentIndex==1)?"Next": "Another Round",
                    cornerRadius: 5.0,
                    textColor: Colors.white,
                    backgroundColor: GlobalColors.firstColor,
                    borderWith: 0.0,
                    action: (){

                    },

                  ),
                ): Container(),
              ],

            ),
          )
          :(currentIndex == 2 && roundsQuestion.rPlayerAnsThree!= null && roundsQuestion.rStatus != 0)? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomRaisedButton(
                    buttonText: (currentIndex==0 || currentIndex==1)?"Next": "Connect",
                    cornerRadius: 5.0,
                    textColor: Colors.white,
                    backgroundColor: GlobalColors.firstColor,
                    borderWith: 0.0,
                    action: (){
                      print("connect is pressed");
                    },

                  ),
                ),
                SizedBox(width: 8,),
                (currentIndex ==2)?
                Expanded(
                  child: CustomRaisedButton(
                    buttonText: (currentIndex==0 || currentIndex==1)?"Next": "Another Round",
                    cornerRadius: 5.0,
                    textColor: Colors.white,
                    backgroundColor: GlobalColors.firstColor,
                    borderWith: 0.0,
                    action: (){
                      print("Another is pressed");
                      Navigator.pop(context);
                    },

                  ),
                ): Container(),
              ],

            ),
          )
          :Container(),

          SizedBox(height: 12,),


        ],
      ),
    );
  }
  ///Avatars/Images of Both Player and user...
  Container UserAvatar({bool isMe }) {
    return Container(
              height: 80,
              width: 100,
              decoration:BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: (isMe)? [Colors.orange, Colors.black]:[Colors.green, Colors.grey]),
                borderRadius: (isMe)?BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ):BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                ),),
              child: Center(child: Text((isMe)?myName[0]:widget.perMatch.firstName[0],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.white),)),
            );
  }

  //New One
  Widget AnswersChatItem({String isRight = null, String isLeft = null}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          (check =="user" && currentIndex == 0 && roundsQuestion.rUserAnsOne !=null)? Bubble(
              padding:BubbleEdges.all(16),
              style: BubbleStyle(
                nip: BubbleNip.rightTop,
                color: Colors.white,
                elevation: 3,
                margin: BubbleEdges.only(top: 8, left:8 ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    roundsQuestion.rUserAnsOne,
                    style: TextStyle(fontSize: GlobalFont.textFontSize + 2,color: Colors.black54,),

                  ),
                  SizedBox(width: 6,),
                ],
              ),
            )
          :(check =="user" && currentIndex == 1 && roundsQuestion.rUserAnsTwo !=null)? Bubble(
              padding:BubbleEdges.all(16),
              style: BubbleStyle(
                nip: BubbleNip.rightTop,
                color: Colors.white,
                elevation: 3,
                margin: BubbleEdges.only(top: 8, left:100 ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    roundsQuestion.rUserAnsTwo,
                    style: TextStyle(fontSize: GlobalFont.textFontSize + 2,color: Colors.black54,),

                  ),
                  SizedBox(width: 6,),
                ],
              ),
            )
          :(check =="user" && currentIndex == 2 && roundsQuestion.rUserAnsThree !=null)?  Bubble(
              padding:BubbleEdges.all(16),
              style: BubbleStyle(
                nip: BubbleNip.rightTop,
                color: Colors.white,
                elevation: 3,
                margin: BubbleEdges.only(top: 8, left:100 ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    roundsQuestion.rUserAnsThree,
                    style: TextStyle(fontSize: GlobalFont.textFontSize + 2,color: Colors.black54,),
                  ),
                  SizedBox(width: 6,),
                ],
              ),
            )
          :(check =="player" && currentIndex == 0 && roundsQuestion.rPlayerAnsOne !=null)? Bubble(
        padding:BubbleEdges.all(16),
        style: BubbleStyle(
          nip: BubbleNip.rightTop,
          color: Colors.white,
          elevation: 3,
          margin: BubbleEdges.only(top: 8, left:100 ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              roundsQuestion.rPlayerAnsOne,
              style: TextStyle(fontSize: GlobalFont.textFontSize + 2,color: Colors.black54,),
            ),
            SizedBox(width: 6,),
          ],
        ),
      )
          :(check =="player" && currentIndex == 1 && roundsQuestion.rPlayerAnsTwo !=null)?Bubble(
        padding:BubbleEdges.all(16),
        style: BubbleStyle(
          nip: BubbleNip.rightTop,
          color: Colors.white,
          elevation: 3,
          margin: BubbleEdges.only(top: 8, left:100 ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              roundsQuestion.rPlayerAnsTwo,
              style: TextStyle(fontSize: GlobalFont.textFontSize + 2,color: Colors.black54,),

            ),
            SizedBox(width: 6,),
          ],
        ),
      )
          :(check =="player" && currentIndex == 2 && roundsQuestion.rPlayerAnsThree !=null)?Bubble(
            padding:BubbleEdges.all(16),
            style: BubbleStyle(
              nip: BubbleNip.rightTop,
              color: Colors.white,
              elevation: 3,
              margin: BubbleEdges.only(top: 8, left:100 ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  roundsQuestion.rPlayerAnsThree,
                  style: TextStyle(fontSize: GlobalFont.textFontSize + 2,color: Colors.black54,),

                ),
                SizedBox(width: 6,),
              ],
            ),
          )
          :Container(),
          SizedBox(height: 8,),
          (roundsQuestion.rStatus == 1 && currentIndex == 0 && check == "user" && roundsQuestion.rUserAnsOne !=null)? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StatusButton(backgroundColor: Colors.red, icon: Icons.clear, radius: 13.0,size: 26.0,action: (){
                DeclineUpdateStatus();
              }),
            ],
          )
          :(roundsQuestion.rStatus == 1 && currentIndex == 1 && check == "user" && roundsQuestion.rUserAnsTwo !=null)? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                StatusButton(backgroundColor: Colors.red, icon: Icons.clear, radius: 13.0,size: 26.0,action: (){
                  DeclineUpdateStatus();
                }),
              ],
          )
          :(roundsQuestion.rStatus == 1 && currentIndex == 2 && check == "user" && roundsQuestion.rUserAnsThree !=null)? Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StatusButton(backgroundColor: Colors.red, icon: Icons.clear, radius: 13.0,size: 26.0,action: (){
            DeclineUpdateStatus();
          }),
        ],
      )
          :(roundsQuestion.rStatus == 1 && check == "player" && currentIndex == 0 && roundsQuestion.rPlayerAnsOne !=null)? Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StatusButton(backgroundColor: Colors.red, icon: Icons.clear, radius: 13.0,size: 26.0,action: (){
            DeclineUpdateStatus();
          }),
        ],
      )
          :(roundsQuestion.rStatus == 1 && check == "player" && currentIndex == 1 && roundsQuestion.rPlayerAnsTwo !=null)? Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StatusButton(backgroundColor: Colors.red, icon: Icons.clear, radius: 13.0,size: 26.0,action: (){
            DeclineUpdateStatus();
          }),
        ],
      )
          :(roundsQuestion.rStatus == 1 &&  check == "player" && currentIndex == 2 && roundsQuestion.rPlayerAnsThree !=null)? Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StatusButton(backgroundColor: Colors.red, icon: Icons.clear, radius: 13.0,size: 26.0,action: (){
            DeclineUpdateStatus();
          }),
        ],
      )
          :Container(),
          (isRight =="player" && currentIndex == 0 && roundsQuestion.rUserAnsOne !=null)? Bubble(
            padding:BubbleEdges.all(16),
            style: BubbleStyle(
              nip: BubbleNip.leftBottom,
              color: Colors.blueGrey,
              elevation: 3,
              margin:BubbleEdges.only(top: 8.0, right: 16.0),
            ),
            child: Text(
              roundsQuestion.rUserAnsOne,
              style: TextStyle(fontSize: GlobalFont.textFontSize + 2,color: Colors.white ,),

            ),
          )
          :(isRight =="player" && currentIndex == 1 && roundsQuestion.rUserAnsTwo !=null)? Bubble(
        padding:BubbleEdges.all(16),
        style: BubbleStyle(
          nip: BubbleNip.leftBottom,
          color: Colors.blueGrey,
          elevation: 3,
          margin:BubbleEdges.only(top: 8.0, right: 16.0),
        ),
        child: Text(
            roundsQuestion.rUserAnsTwo,
          style: TextStyle(fontSize: GlobalFont.textFontSize + 2,color: Colors.white ,),

        ),
      )
          :(isRight =="player" && currentIndex == 2 && roundsQuestion.rUserAnsThree !=null)? Bubble(
        padding:BubbleEdges.all(16),
        style: BubbleStyle(
          nip: BubbleNip.leftBottom,
          color: Colors.blueGrey,
          elevation: 3,
          margin:BubbleEdges.only(top: 8.0, right: 16.0),
        ),
        child: Text(
          roundsQuestion.rUserAnsThree,
          style: TextStyle(fontSize: GlobalFont.textFontSize + 2,color: Colors.white ,),

        ),
      )
          :(isRight =="user" && currentIndex == 0 && roundsQuestion.rPlayerAnsOne !=null)? Bubble(
        padding:BubbleEdges.all(16),
        style: BubbleStyle(
          nip: BubbleNip.leftBottom,
          color: Colors.blueGrey,
          elevation: 3,
          margin:BubbleEdges.only(top: 8.0, right: 16.0),
        ),
        child: Text(
          roundsQuestion.rPlayerAnsOne,
          style: TextStyle(fontSize: GlobalFont.textFontSize + 2,color: Colors.white ,),

        ),
      )
          :(isRight =="user" && currentIndex == 1 && roundsQuestion.rPlayerAnsTwo !=null)? Bubble(
        padding:BubbleEdges.all(16),
        style: BubbleStyle(
          nip: BubbleNip.leftBottom,
          color: Colors.blueGrey,
          elevation: 3,
          margin:BubbleEdges.only(top: 8.0, right: 16.0),
        ),
        child: Text(
         roundsQuestion.rPlayerAnsTwo,
          style: TextStyle(fontSize: GlobalFont.textFontSize + 2,color: Colors.white ,),

        ),
      )
          :(isRight =="user" && currentIndex == 2 && roundsQuestion.rPlayerAnsThree !=null)? Bubble(
        padding:BubbleEdges.all(16),
        style: BubbleStyle(
          nip: BubbleNip.leftBottom,
          color: Colors.blueGrey,
          elevation: 3,
          margin:BubbleEdges.only(top: 8.0, right: 16.0),
        ),
        child: Text(
          roundsQuestion.rPlayerAnsThree,
          style: TextStyle(fontSize: GlobalFont.textFontSize + 2,color: Colors.white ,),

        ),
      )
          :Container(),
        ],
      ),
    );
  }

  ///Accept and Decline Status Buttons
  Widget StatusButton({Color backgroundColor, IconData icon,Color iconColor , double radius, double size, VoidCallback action}){
    return CupertinoButton(
      minSize: double.minPositive,
      color: backgroundColor,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: Icon(
          icon,
          color: (iconColor == null) ?Colors.white: iconColor,
          size: size,
      ),
      onPressed: action,
    );

  }
  Widget AnswerTextFeild(TextEditingController tf, FocusNode fn){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: UnderLineTextField(
        focusNode: fn,
        txtHint: "Write your answer",
        isSecure: false,
        keyboardType: TextInputType.emailAddress,
        enableBorderColor: Colors.white,
        focusBorderColor: Colors.grey,
        textColor: Colors.black,
        txtController: tf,
        onTapFunc: () {
          setState(() {
            FocusScope.of(context).requestFocus(fn);
          });
        },
      ),
    );
  }
  ///Send My Answer action
  void SendAnswer(){

    if (answerTF.text.isNotEmpty){
      AnswerQuestion();
    }else{
      GFunction.showError("Write your answer please!", context);
    }
  }
  ///API Call Round Details getting....
  void getRoundsQuestion(){
    Map<String, dynamic> body = {
      "cate_id":"${widget.catId}",
      "id" :  (widget.idNoti == null)?"${widget.perMatch.prUserId}":"${widget.idNoti}",  //player_id
    };
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post,authorization: true, url: WebService.rounds,body: body,isFormData: true).then(
              (response) async{

            var res = response as http.Response;
            if (res.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(res.body);
              if(responseJson.containsKey('success')){
                roundsQuestion = RoundsModel.fromJson(responseJson['success']);
                print("Response: ${responseJson['success']}");
                if(widget.perMatch.prUserId == roundsQuestion.rUserId && roundsQuestion.rUserId!=null){
                  check = "user";
                }else if (widget.perMatch.prUserId == roundsQuestion.rPlayerId && roundsQuestion.rPlayerId!=null){
                  check = "player";
                }else{
                  check = "first";
                }

                if (roundsQuestion.rStatus != 0){
                  if (roundsQuestion.rUserAnsThree != null && roundsQuestion.rPlayerAnsThree != null){
                    GFunction.showSuccess(() {
                      Navigator.pop(context); //First to close popup
                      Navigator.pop(context); // Second to close rounds.
                    }, context,title: "Round Status",subMsg: "This round has been completed.",imageStatus: true);
                  }else {
                    if (roundsQuestion.rUserAnsTwo != null && roundsQuestion.rPlayerAnsTwo != null){
                      currentIndex = 2;
                    }else{
                      if (roundsQuestion.rUserAnsOne != null && roundsQuestion.rPlayerAnsOne != null){
                        currentIndex = 1;
                      }else{
                        currentIndex = 0;
                      }
                    }
                  }
                }else {
                  GFunction.showSuccess(() {
                    Navigator.pop(context);//First to close popup
                    Navigator.pop(context);// Second to close rounds.
                  }, context,title: "Round Status",subMsg: "This round has been Rejected.",imageStatus: false);
                }
                apiCall = 0;
                setState(() {});
              }else{
                apiCall = 0;
                setState(() {});
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
      setState(() {
        GFunction.showError(e.toString(), context);
      });

    }
  }
  ///API Call Round Decline Status....
  void DeclineUpdateStatus(){

    Map<String, dynamic> body = {
      "status": "${roundsQuestion.rStatus}",
      "round_id": "${roundsQuestion.rId}",
      "id": "${widget.perMatch.prUserId}",
      "cate_id":"${roundsQuestion.rCateId}"
    };
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post,authorization: true, url: WebService.updateStatusDecline,body: body,isFormData: true).then(
              (response) async{

            var res = response as http.Response;
            if (res.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(res.body);
              if(responseJson.containsKey('success')){
                print("Response ====> "+ responseJson['success']);
                apiCall = 0;
                Navigator.pop(context);
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

  ///API Call Round Decline Status....
  void AnswerQuestion(){
    Map<String, dynamic> body = {
      'cate_id' : "${widget.catId}",
      'id' : "${widget.perMatch.prUserId}", //player_id
      'answer':'${answerTF.text}',
      'question_id' : (currentIndex == 0) ? "${roundsQuestion.rQuesOneId}" : (currentIndex==1) ? "${roundsQuestion.rQuesTwoId}" : "${roundsQuestion.rQuesThreeId}",
      'q1': "${roundsQuestion.rQuesOneId}",
      'q2' : "${roundsQuestion.rQuesTwoId}",
      'q3' : "${roundsQuestion.rQuesThreeId}",
    };
    print(body);
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post,authorization: true, url: WebService.answerRound,body: body,isFormData: true).then(
              (response) async{

            var res = response as http.Response;
            if (res.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(res.body);
              if(responseJson.containsKey('success')){
                print("Response ====> "+ responseJson['success']);

                if (check == "player" && currentIndex == 0 && roundsQuestion.rUserAnsOne ==null){
                  roundsQuestion.rUserAnsOne = answerTF.text;
                }else if (check == "player" && currentIndex == 1 && roundsQuestion.rUserAnsTwo ==null){
                  roundsQuestion.rUserAnsTwo = answerTF.text;
                }else if (check == "player" && currentIndex == 2 && roundsQuestion.rUserAnsThree ==null){
                  roundsQuestion.rUserAnsThree = answerTF.text;
                }else if (check == "user" && currentIndex == 0 && roundsQuestion.rPlayerAnsOne ==null){
                  roundsQuestion.rPlayerAnsOne = answerTF.text;
                }else if (check == "user" && currentIndex == 1 && roundsQuestion.rPlayerAnsTwo ==null){
                  roundsQuestion.rPlayerAnsTwo = answerTF.text;
                }else if (check == "user" && currentIndex == 2 && roundsQuestion.rPlayerAnsThree ==null){
                  roundsQuestion.rPlayerAnsThree = answerTF.text;
                }else if (check =="first" && currentIndex == 0){
                  roundsQuestion.rPlayerId = widget.perMatch.prUserId;
                  roundsQuestion.rUserAnsOne = answerTF.text;
                  check = "player";
                }
                answerTF.text = "";
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