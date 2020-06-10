import 'package:lovedebate/Globals/Colors.dart';
import 'package:lovedebate/Screens/SignUp.dart';
import 'package:lovedebate/Screens/TabBarcontroller.dart';
import 'package:lovedebate/Widgets/CustomButtons.dart';
import 'package:lovedebate/Widgets/CustomTextFeilds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import '../Utils/HexColor.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  Color _textcolor=Colors.white;

  @override
  Widget build(BuildContext context) {
    double _height=MediaQuery.of(context).size.height;
    double _width=MediaQuery.of(context).size.width;
    TextEditingController txtEmailController = TextEditingController();
    FocusNode txtEmailFocusNode = FocusNode();
    return Scaffold(
      body: SafeArea(
        top: false,
        child:DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/BackGround.jpeg'), fit: BoxFit.fitHeight),
          ),
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  TopSection(_height),
                  CenterSection(_height, txtEmailFocusNode, txtEmailController),
                  BottomSection(_height)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Container BottomSection(double _height) {
    return Container(
        height: (50/100)*_height,
        // color: Colors.greenAccent,
        margin: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            btnContinue(),
            SizedBox(height: 16,),
            InkWell(
                onTap: (){
                  setState(() {
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => LaunchScreen()));

                  });
                },
                child: Text('Signup or Create account',style: TextStyle(color: _textcolor,fontSize: 18),)),
          ],
        )
    );
  }
  Container CenterSection(double _height, FocusNode txtEmailFocusNode, TextEditingController txtEmailController) {
    return Container(
      height: (15/100)*_height,
      //color: Colors.blue,
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          emailTextField(txtEmailFocusNode,txtEmailController,'Email'),
          SizedBox(height: 9,),
          emailTextField(txtEmailFocusNode,txtEmailController,'Password'),
          SizedBox(height: 8,),

        ],
      ),
    );
  }
  Container TopSection(double _height) {
    return Container(
      height: (40/100)*_height,
      //color: Colors.greenAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text('Love',style: TextStyle(fontSize: 45,color: _textcolor),),
          Text('Debate',style: TextStyle(fontSize: 45,color: _textcolor),),

          SizedBox(height: 8,)

        ],
      ),
    );
  }
  Widget emailTextField( FocusNode txtEmailFocusNode, TextEditingController txtEmailController,String text) {
    return UnderLineTextField(
      focusNode: txtEmailFocusNode,
      txtHint: text,
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
    );
  }
  Widget btnContinue() {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: CustomRaisedButton(
        buttonText: 'Login',
        cornerRadius: 22.5,
        textColor: Colors.white,
        backgroundColor:GlobalColors.firstColor,
        borderWith: 0,
        action: (){
          setState(() {
            Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
          });
//
        },
      ),
    );
  }
}
//UnderLineTextField(
//focusNode: txtEmailFocusNode,
//txtHint: "Email",
//isSecure: false,
//keyboardType: TextInputType.emailAddress,
//enableBorderColor: Colors.white,
//focusBorderColor: Colors.white,
//textColor: Colors.white,
//txtController: txtEmailController,
//onTapFunc: () {},
//),

//class UnderLineTextField extends StatelessWidget {
//
//  final FocusNode focusNode;
//  final String txtHint;
//  final bool isSecure;
//  final TextInputType keyboardType;
//  final Color enableBorderColor;
//  final Color focusBorderColor;
//  final Color textColor;
//  final TextEditingController txtController;
//  final VoidCallback onTapFunc;
//
//  UnderLineTextField({
//    this.focusNode,
//    this.txtHint,
//    this.isSecure,
//    this.keyboardType,
//    this.enableBorderColor,
//    this.focusBorderColor,
//    this.textColor,
//    this.txtController,
//    this.onTapFunc
//  });
//  @override
//  Widget build(BuildContext context) {
//    return Theme(
//      data: Theme.of(context).copyWith(
//          accentColor: focusBorderColor
//      ),
//      child: SizedBox(
//        height: 50,
//        child: TextField(
//          focusNode: focusNode,
//          onTap: onTapFunc,
//          style: TextStyle(color: textColor, fontSize: 18),
//          textAlign: TextAlign.justify,
//          textAlignVertical: TextAlignVertical.center,
//          keyboardType: keyboardType,
//          obscureText: isSecure,
//          controller: txtController,
//          decoration: InputDecoration(
//            labelText: txtHint,
//            labelStyle: TextStyle(color: focusNode.hasFocus ? focusBorderColor : Colors.grey, fontSize: 18),
//            contentPadding: EdgeInsets.symmetric(vertical: 8),
//            enabledBorder: UnderlineInputBorder(
//                borderSide: BorderSide(
//                    width: 1,
//                    style: BorderStyle.solid,
//                    color: Colors.grey
//                )
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
//class NewUnderLineTextField extends StatelessWidget {
//
//  final IconData prefixIcon;
//  final IconButton suffixIcon;
//  final TextCapitalization capitalization;
//  final String txtHint;
//  final bool txtIsSecure;
//  final TextInputType keyboardType;
//  final TextEditingController txtController;
//  final Function validator;
//  final Function onSaved;
//  final Function onChanged;
//
//  NewUnderLineTextField({this.prefixIcon, this.suffixIcon, this.capitalization = TextCapitalization.words, this.txtHint, this.txtIsSecure = false, this.keyboardType, this.txtController, this.validator, this.onSaved, this.onChanged});
//
//  @override
//  Widget build(BuildContext context) {
//    return Theme(
//      data: Theme.of(context).copyWith(
//          accentColor: Theme.of(context).primaryColor
//      ),
//      child: TextFormField(
//        style: TextStyle(fontSize: 14),
//        textAlign: TextAlign.justify,
//        textCapitalization: capitalization,
//        textAlignVertical: TextAlignVertical.center,
//        keyboardType: keyboardType,
//        obscureText: txtIsSecure,
//        controller: txtController,
//        validator: validator,
//        onSaved: onSaved,
//        onChanged: onChanged,
//        decoration: InputDecoration(
//          prefixIcon: prefixIcon != null ? Container(transform: Matrix4.translationValues(0.0, 0.0, 0.0), child: Icon(prefixIcon, size: 16,)) : null,
//          suffixIcon: suffixIcon,
//          hintText: txtHint,
//          hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
//          filled: false,
//          fillColor: Colors.white,
//          focusedBorder: UnderlineInputBorder(
//              borderSide: BorderSide(
//                  width: 1.3,
//                  style: BorderStyle.solid,
//                  color: Theme.of(context).primaryColor
//              )
//          ),
//          enabledBorder: UnderlineInputBorder(
//              borderSide: BorderSide(
//                  width: 1,
//                  style: BorderStyle.solid,
//                  color: Colors.grey.withOpacity(0.4)
//              )
//          ),
//        ),
//      ),
//    );
//  }
//}
//class CustomRaisedButton extends StatelessWidget {
//  final String buttonText;
//  final double cornerRadius;
//  final Color backgroundColor;
//  final Color textColor;
//  final double borderWith;
//  final VoidCallback action;
//
//  CustomRaisedButton({this.buttonText, this.cornerRadius, this.backgroundColor, this.textColor, this.borderWith, this.action});
//
//  @override
//  Widget build(BuildContext context) {
//    return RaisedButton(
//        onPressed: action,
//        color: backgroundColor,
//        shape: RoundedRectangleBorder(
//
//            borderRadius: BorderRadius.circular(cornerRadius),
//            side: BorderSide(color:Colors.white, width: borderWith)),
//        child: Text(
//          buttonText,
//          style: TextStyle(
//            color: textColor,
//            fontSize: 18,
//          ),
//          textAlign: TextAlign.center,
//        ));
//  }
//}
//
//
//class CustomFlatButton extends StatelessWidget {
//
//  final String titleText;
//  final IconData icon;
//  final VoidCallback onTapFunc;
//
//  CustomFlatButton({this.titleText, this.icon, this.onTapFunc});
//
//  @override
//  Widget build(BuildContext context) {
//    IconThemeData iconThemeData = IconTheme.of(context);
//    return FlatButton(
//      onPressed: onTapFunc,
//      child: Row(
//        children: <Widget>[
//          Icon(icon,size: iconThemeData.size, color: iconThemeData.color),
//          SizedBox(width: 12,),
//          Text(titleText,style: TextStyle(fontSize: 16),),
//        ],
//      ),
//    );
//  }
//}


