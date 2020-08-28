import 'package:app_push_notifications/Modules/EmailVerification/emailVerification.dart';
import 'package:app_push_notifications/Screens/TabBarcontroller.dart';
import 'package:app_push_notifications/Utils/Designables/CustomButtons.dart';
import 'package:app_push_notifications/Utils/Designables/CustomTextFeilds.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswoprd extends StatefulWidget {
  @override
  _ForgotPasswoprdState createState() => _ForgotPasswoprdState();
}

class _ForgotPasswoprdState extends State<ForgotPasswoprd> {
  TextEditingController txtEmail = TextEditingController();
//  TextEditingController txtDOB = TextEditingController();

  FocusNode txtEmailFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.vertical - AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        //remove Shadow
        elevation: 0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
        leading: (Theme.of(context).platform == TargetPlatform.iOS) ? BackButton(color: GlobalColors.firstColor) : Container(),
      ),
      body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: ListView(
//              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Container(
                  height: ((30/100)*totalHeight),
                  width: MediaQuery.of(context).size.width/1.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Reset Your Password", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),),
//                      SizedBox(height: 4,),
//                      Text("Enter the code sent via email address", style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),\
                    ],
                  ),
                ),

                Container(
//                color: Colors.red,
                    height: ((40/100)*totalHeight),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: UnderLineTextField(
                              focusNode: txtEmailFocusNode,
                              txtHint: "Email",
                              isSecure: false,
                              keyboardType: TextInputType.emailAddress,
                              txtController: txtEmail,
                            ),
                          ),
                          SizedBox(height: 16),

                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: CustomRaisedButton(
                              buttonText: 'Send Email',
                              cornerRadius: 5,
                              textColor: Colors.white,
                              backgroundColor:GlobalColors.firstColor,
                              borderWith: 0,
                              action: (){
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => EmailVerification()));
                              },
                            ),
                          ),

                        ],
                      ),
                    )
                ),

                Container(
//                color: Colors.orangeAccent,
                  height: ((30/100)*totalHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
//                      Padding(
//                        padding: const EdgeInsets.only(bottom: 32.0),
//                        child: Text("Problem receiving the code?", style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
//                      ),
                    ],
                  ),
                )

              ],
            ),
          )),
    );
  }
  Container bottomSection({double totalHeight}) {
    return Container(
//      height: ((20 / 100) * totalHeight),
      color: Colors.greenAccent,
    );
  }
}