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
      body:SafeArea(
        top: false,
        bottom: false,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white
//              gradient: LinearGradient(
//                  begin: Alignment.topLeft,
//                  end: Alignment.bottomRight,
//                  colors: <Color>[HexColor('#ED2E77'),HexColor('#942ED8'),]
//              )
            // image: DecorationImage(image: AssetImage('images/BackGround.jpeg'), fit: BoxFit.cover),
          ),
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  TopSection(_height),
                  BottomSection(_height, _signupButtonwidth,context,_signupButtonHeight),
                ],
              ),
              Positioned(
                bottom: 24,
                child: Container(
                  width: _width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: RichText(
                          text: TextSpan(
                            text: 'Already Have an account? ',
                            style: Theme.of(context).textTheme.body1.copyWith(fontSize: GlobalFont.textFontSize,),
                            children: <TextSpan>[
                              TextSpan(text: 'Login', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                            ],
                          ),
                        ),
                        onTap: (){
                          setState(() {
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => Login()));
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ) ,
    );
  }
  Container BottomSection(double height, double width,BuildContext context,double _signupButtonheight) {
    return Container(
      height: (60/100)* height,
      //color: Colors.lightBlue,
      child: Column(
        children: <Widget>[
          SizedBox(height: 18,),
          SignupMethod(context,_signupButtonheight, width,'Signup with Email',true,GlobalColors.firstColor,'images/gmailfilled.png',Colors.white),
          SignupMethod(context,_signupButtonheight, width,'Signup with FaceBook',true,Color(0xff0072CD),'images/icons8-facebook-f-48.png',Colors.white),
          SignupMethod(context,_signupButtonheight, width,'Signup with Google',true,Colors.white,'images/googleicon.png',Colors.black),

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
          AppBarPic(),
          SizedBox(height: 16,),
          Text('Love Debate',style: TextStyle(fontSize: 38,color: Colors.black),),
          //Text('Debate',style: TextStyle(fontSize: 45,color: Colors.white),),
          //Text('Login or Create account',style: TextStyle(color: Colors.white),),
          SizedBox(height: 16,)

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
      height: 45,
//      decoration: BoxDecoration(
//          color:bgColor,
//        borderRadius: BorderRadius.all(Radius.circular(5))
//      ),
      margin: EdgeInsets.all(8),
      child: Card(
        color: bgColor,
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
    ),
  );
}