import 'dart:async';

import 'package:app_push_notifications/Screens/TabBarcontroller.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class EmailVerification extends StatefulWidget {
  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {

  Timer _timer;
  int _start = 60;

  String thisText = "";
  int pinLength = 4;
  bool hasError = false;
  String errorMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.vertical - AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        //remove Shadow
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: (Theme.of(context).platform == TargetPlatform.iOS) ? BackButton(color: GlobalColors.firstColor) : Container(),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              height: ((30/100)*height),
              width: MediaQuery.of(context).size.width/1.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Verify your email address", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),),
                  SizedBox(height: 4,),
                  Text("Enter the code sent via email address", style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
                ],
              ),
            ),
            Container(
//                color: Colors.red,
                height: ((40/100)*height),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      PinCodeTextField(
                        pinBoxWidth: 45,
                        pinBoxHeight: 45,
                        pinBoxRadius: 3.0,
                        pinBoxBorderWidth: 2,
                        pinBoxOuterPadding: EdgeInsets.all(4.0),
                        pinTextStyle: TextStyle(fontSize: 24.0),
                        autofocus: false,
                        wrapAlignment: WrapAlignment.center,
                        defaultBorderColor: Colors.black54,
                        hasTextBorderColor: GlobalColors.firstColor,
                        maxLength: 4,
                        hasError: hasError,
                        pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
                        keyboardType: TextInputType.number,
                        onTextChanged: (text) {
                          setState(() {
                            hasError = false;
                          });
                        },
                        onDone: (text) {
                          print("DONE $text");


                          //OnVerification Functionality there


//                          Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
                        },
                      ),

                      SizedBox(height: 12),
                      (_start == 0) ?
                      InkWell(
                        onTap: (){
                          setState(() {
                            _start = 60;
                            startTimer();
                          });
                        },
                        child: Text("Resend code again", style: TextStyle(color: Theme.of(context).primaryColorLight, fontSize: 14, ), textAlign: TextAlign.center,),
                      ) : Text("You should be getting a code shortly: $_start", style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
                    ],
                  ),
                )
            ),
            Container(
//                color: Colors.orangeAccent,
              height: ((30/100)*height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: Text("Problem receiving the code?", style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}