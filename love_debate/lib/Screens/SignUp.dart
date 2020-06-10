import 'package:lovedebate/Globals/Colors.dart';
import 'package:lovedebate/Utils/HexColor.dart';
import 'package:flutter/material.dart';

import 'Login.dart';
class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}
class _LaunchScreenState extends State<LaunchScreen> {
  @override
  Widget build(BuildContext context) {
    double _height=MediaQuery.of(context).size.height;
    double _width=MediaQuery.of(context).size.width;

    double _signupButtonwidth=_width/0.75;
    double _signupButtonHeight=_height/1.4;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF01090E),
      ),
      body:SafeArea(
        top: false,
        child: DecoratedBox(
          decoration: BoxDecoration(
//              gradient: LinearGradient(
//                  begin: Alignment.topLeft,
//                  end: Alignment.bottomRight,
//                  colors: <Color>[HexColor('#ED2E77'),HexColor('#942ED8'),]
//              )
            image: DecorationImage(image: AssetImage('images/BackGround.jpeg'), fit: BoxFit.cover),
          ),
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  TopSection(_height),
                  BottomSection(_height, _signupButtonwidth,context,_signupButtonHeight)
                ],
              ),
            ],
          ),
        ),
      ) ,
    );
  }
  Container BottomSection(double _height, double _width,BuildContext context,double _signupButtonheight) {
    return Container(
      height: (60/100)*_height,
      child: Column(
        children: <Widget>[
          SizedBox(height: 18,),
          SignupMethod(context,_signupButtonheight, _width,'Signup with Email',true,GlobalColors.firstColor,'images/email.png',Colors.white),
          SignupMethod(context,_signupButtonheight, _width,'Signup with FaceBook',true,Color(0xff0072CD),'images/icons8-facebook-f-48.png',Colors.white),
          SignupMethod(context,_signupButtonheight, _width,'Signup with Google',true,Color(0xffFFFFFF),'images/googleicon.png',Colors.black),

        ],
      ),
    );
  }
  Container TopSection(double _height) {
    return Container(
      height:(40/100)*_height ,
      //color: Colors.greenAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text('Love',style: TextStyle(fontSize: 45,color: Colors.white),),
          Text('Debate',style: TextStyle(fontSize: 45,color: Colors.white),),
          //Text('Login or Create account',style: TextStyle(color: Colors.white),),
          SizedBox(height: 8,)

        ],
      ),
    );
  }
}
InkWell SignupMethod(BuildContext context,double height, double width,String text,bool isIcon,Color bgColor,String image,Color textcolor) {
  return InkWell(
    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    },
    child: Container(
      height: 45,
      decoration: BoxDecoration(
          color:bgColor,
        borderRadius: BorderRadius.all(Radius.circular(22.5))
      ),
      margin: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset(image,fit: BoxFit.fitWidth,),
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
  );
}
