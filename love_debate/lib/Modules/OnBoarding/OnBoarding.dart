import 'package:lovedebate/Utils/Globals/Fonts.dart';
import 'package:lovedebate/Widgets/CustomButtons.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Widgets/CustomTextFeilds.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {

    double _height=(MediaQuery.of(context).size.height)-AppBar().preferredSize.height;
    double _width=MediaQuery.of(context).size.width;
    //MediaQuery.of(context).padding.vertical

    TextEditingController txtEmailController = TextEditingController();
    FocusNode txtEmailFocusNode = FocusNode();

    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: GlobalColors.firstColor,
        backgroundColorEnd: GlobalColors.secondColor,
        title:  Text('OnBaording',style:TextStyle(color: Colors.white ,fontSize: GlobalFont.navFontSize, fontFamily: 'Satisfy', fontWeight:  FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: _height,
          width: _width,
          color: Colors.grey.withOpacity(0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: (50/100)*_height,
                width: _width,
                //color: Colors.blue,
                child:Card(
                  elevation: 1,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                       // SizedBox(height: 16,),
                        Text("What is Your Height?",style: TextStyle(fontSize: 24),),
                        //SizedBox(height: 16,),
                        Container(
                          height: 50,
                          margin: EdgeInsets.all(16),
                          child: UnderLineTextField(
                            focusNode: txtEmailFocusNode,
                            txtHint: "Your Height",
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

                      ],
                    ),
                  ),
                ) ,
              ),
              Container(
                height: (20/100)*_width,
                width: _width,
               // color: Colors.cyan,
                child: Row(
                 // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 16,),
                   btnContinue("Skip"),
                    Expanded(child: SizedBox(width: 16,)),
                    onBoardingQANo(),
                    Expanded(child: SizedBox(width: 16,)),
                    btnContinue("Next"),
                    SizedBox(width: 16,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container onBoardingQANo() {
    return Container(
      height: 45,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.all(Radius.circular(22.5))
      ),
      child:Center(child: Text("1/25",style: TextStyle(fontSize: 18),)),
    );
  }
  Widget btnContinue(String text) {
    return SizedBox(
      height: 45,
      //width: double.infinity,
      child: CustomRaisedButton(
        buttonText:text ,
        cornerRadius: 22.5,
        textColor: Colors.white,
        backgroundColor:GlobalColors.firstColor,
        borderWith: 0,
        action: (){
          setState(() {
   //         Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
          });
//
        },
      ),
    );
  }
}
