//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:lovedebate/Utils/Globals/Colors.dart';
//import 'package:lovedebate/Utils/Globals/CustomAppBar.dart';
//import '../../Utils/Globals/Fonts.dart';
//import 'Login.dart';
//import 'SUPersonalInfo.dart';
//
//
//
//class SignUp extends StatefulWidget {
//  @override
//  _SignUpState createState() => _SignUpState();
//}
//class _SignUpState extends State<SignUp> {
//  @override
//  Widget build(BuildContext context) {
//    double _height=MediaQuery.of(context).size.height;
//    double _width=MediaQuery.of(context).size.width;
//
//    double _signupButtonwidth=_width/0.75;
//    double _signupButtonHeight=_height/1.4;
//    return Scaffold(
//      appBar:  CustomAppbar.setNavigation(""),
//      body:SafeArea(
//        top: false,
//        bottom: false,
//        child: Container(
//          height: _height,
//          width: _width,
//          color: Colors.white,
//          child: SingleChildScrollView(
//            child: Stack(
//              children: <Widget>[
//
//                Column(
//                  children: <Widget>[
//                    topSection(_height),
//                    centerSection(_height,_width),
//                    bottomSection(_height, _width),
//                  ],
//                ),
//              ],
//            ),
//          ),
//        ),
//      ) ,
//    );
//  }
//  Container BottomSection(double height, double width,BuildContext context,double _signupButtonheight) {
//    return Container(
//      height: (50/100)* height,
//      //color: Colors.lightBlue,
//      child: Column(
//        children: <Widget>[
//          // SizedBox(height: 18,),
//          SignupMethod(context,_signupButtonheight, width,'Sign Up with Email',true,GlobalColors.firstColor,'images/mail.png',Colors.white),
//          SignupMethod(context,_signupButtonheight, width,'Sign Up with Facebook',true,Color(0xff0072CD),'images/icons8-facebook-f-48.png',Colors.white),
//          SignupMethod(context,_signupButtonheight, width,'Sign Up with Google',true,Colors.white,'images/googleicon.png',Colors.black),
//
//        ],
//      ),
//    );
//  }
//  Container topSection(double _height) {
//    return Container(
//      height: (30/100)*_height,
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.end,
//        children: <Widget>[
//          Center(
//            child: Container(
//                height: 180,
//                width: 180,
//                child: Image.asset("images/LoveDebatelogo.png")
//            ),
//          )
//
//        ],
//      ),
//    );
//  }
//
//  Container centerSection(double height, double width) {
//    double _signupButtonwidth= width/0.75;
//    double _signupButtonHeight=height/1.4;
//    return Container(
//      height: (35/100)*height,
//      //color: Colors.blue,
//      margin: EdgeInsets.only(left: 16,right: 16),
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          SignupMethod(context,_signupButtonHeight, _signupButtonwidth,'Sign Up with Email',true,GlobalColors.firstColor,'images/mail.png',Colors.white),
//          SignupMethod(context,_signupButtonHeight, _signupButtonwidth,'Sign Up with Facebook',true,Color(0xff0072CD),'images/icons8-facebook-f-48.png',Colors.white),
//          SignupMethod(context,_signupButtonHeight, _signupButtonwidth,'Sign Up with Google',true,Colors.white,'images/googleicon.png',Colors.black),
//        ],
//      ),
//    );
//  }
//
//  Container bottomSection(double _height,double _width) {
//    return Container(
//        height: (35/100)*_height,
//        child: Column(
//          children: <Widget>[
//            Container(
//              height: (25/100)*_height,
//              width: _width,
//              // color: Colors.lightBlue,
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.end,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  InkWell(
//                    child: RichText(
//                      text: TextSpan(
//                        text: "Already have an account? ",
//                        style: Theme.of(context).textTheme.body1.copyWith(fontSize: GlobalFont.textFontSize,),
//                        children: <TextSpan>[
//                          TextSpan(text: 'Login', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
//                        ],
//                      ),
//                    ),
//                    onTap: (){
//                      setState(() {
//                        Navigator.pop(context);
//                      });
//                    },
//                  ),
//                ],
//              ),
//            ),
//
//          ],
//        )
//    );
//  }
//
//}
//Container AppBarPic() {
//  return Container(
//      width: 120,
//      height:120,
//      margin: EdgeInsets.all(8),
//      decoration: new BoxDecoration(
//          shape: BoxShape.circle,
//          image: new DecorationImage(
//              fit: BoxFit.cover,
//              image: AssetImage("images/BackGround.jpeg",)
//          )
//      ));
//}
//InkWell SignupMethod(BuildContext context,double height, double width,String text,bool isIcon,Color bgColor,String image,Color textcolor) {
//  return InkWell(
//    onTap: (){
//      Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => SUPersonalInfo()),
//      );
//    },
//    child: Container(
//      height: 55,
////      decoration: BoxDecoration(
////          color:bgColor,
////        borderRadius: BorderRadius.all(Radius.circular(5))
////      ),
//      margin: EdgeInsets.only(left: 12, right: 12,bottom: 12),
//      child: Card(
//        elevation: 7,
//        color: bgColor,
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Container(
//              child:  bgColor ==GlobalColors.firstColor ? Image.asset(image,fit: BoxFit.fitWidth,color: Colors.white ) :Image.asset(image,fit: BoxFit.fitWidth,),
//              width: 25.0,
//              height: 25.0,  // borde width
//            ),
//            SizedBox(width: 12,),
//            Container(
//                width: 200,
//                // color: Colors.yellow,
//                child: Text(text,style: TextStyle(fontSize: 18,color: textcolor),)),
//          ],
//        ),
//      ),
//    ),
//  );
//}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/CustomAppBar.dart';
import '../../Utils/Globals/Fonts.dart';
import 'Login.dart';
import 'SUPersonalInfo.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    double _height=MediaQuery.of(context).size.height;
    double _width=MediaQuery.of(context).size.width;

    double _signupButtonwidth=_width/0.75;
    double _signupButtonHeight=_height/1.4;
    return Scaffold(
      appBar:  CustomAppbar.setNavigation(""),
      body:Container(
        height: _height,
        width: _width,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TopSection(_height),
              BottomSection(_height, _signupButtonwidth,context,_signupButtonHeight),
            ],
          ),
        ),
      ) ,
    );
  }
  Container BottomSection(double height, double width,BuildContext context,double _signupButtonheight) {
    return Container(
      height: (50/100)* height,
      // color: Colors.white,
      child: Column(
        children: <Widget>[
          // SizedBox(height: 18,),
          SignupMethod(context,_signupButtonheight, width,'Sign Up with Email',true,GlobalColors.firstColor,'images/mail.png',Colors.white),
          SignupMethod(context,_signupButtonheight, width,'Sign Up with Facebook',true,Color(0xff0072CD),'images/icons8-facebook-f-48.png',Colors.white),
          SignupMethod(context,_signupButtonheight, width,'Sign Up with Google',true,Colors.white,'images/googleicon.png',Colors.black),
          Expanded(
            child: Container(
//            height:((50/100)*height),
              width: width,
              margin: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(context).textTheme.body1.copyWith(fontSize: GlobalFont.textFontSize,),
                        children: <TextSpan>[
                          TextSpan(text: 'Login', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue)),
                        ],
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
  Container TopSection(double _height) {
    return Container(
      height:(35/100)*_height ,
      //color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
//          AppBarPic(),
//          SizedBox(height: 16,),
//          Text('Love Debate',style: TextStyle(fontSize: 38,color: Colors.black),),
//          //Text('Debate',style: TextStyle(fontSize: 45,color: Colors.white),),
//          //Text('Login or Create account',style: TextStyle(color: Colors.white),),
//          SizedBox(height: 16,)
          Container(
              height: 220,
              width: 220,
              //color: Colors.lightBlue,
              child: Image.asset("images/LoveDebatelogo.png")
          )

        ],
      ),
    );
  }
}
Container AppBarPic() {
  return Container(
      width: 120,
      height:120,
      margin: EdgeInsets.all(8),
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("images/BackGround.jpeg",)
          )
      ));
}
InkWell SignupMethod(BuildContext context,double height, double width,String text,bool isIcon,Color bgColor,String image,Color textcolor) {
  return InkWell(
    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SUPersonalInfo()),
      );
    },
    child: Container(
      height: 55,
//      decoration: BoxDecoration(
//          color:bgColor,
//        borderRadius: BorderRadius.all(Radius.circular(5))
//      ),
      margin: EdgeInsets.only(left: 12, right: 12,bottom: 12),
      child: Card(
        elevation: 7,
        color: bgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child:  bgColor ==GlobalColors.firstColor ? Image.asset(image,fit: BoxFit.fitWidth,color: Colors.white ) :Image.asset(image,fit: BoxFit.fitWidth,),
              width: 25.0,
              height: 25.0,  // borde width
            ),
            SizedBox(width: 12,),
            Container(
                width: 200,
                // color: Colors.yellow,
                child: Text(text,style: TextStyle(fontSize: 18,color: textcolor),)),
          ],
        ),
      ),
    ),
  );
}
