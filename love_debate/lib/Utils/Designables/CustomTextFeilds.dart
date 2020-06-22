import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';

class UnderLineTextField extends StatelessWidget {

  final FocusNode focusNode;
  final String txtHint;
  final bool isSecure;
  final TextInputType keyboardType;
  final Color enableBorderColor;
  final Color focusBorderColor;
  final Color textColor;
  final TextEditingController txtController;
  final VoidCallback onTapFunc;


  UnderLineTextField({
    this.focusNode,
    this.txtHint,
    this.isSecure,
    this.keyboardType,
    this.enableBorderColor,
    this.focusBorderColor,
    this.textColor,
    this.txtController,
    this.onTapFunc
  });
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          accentColor: focusBorderColor
      ),
      child: SizedBox(
        height: 50,
        child: TextField(
          focusNode: focusNode,
          onTap: onTapFunc,
          style: TextStyle(color: textColor, fontSize: GlobalFont.textFontSize),
          textAlign: TextAlign.justify,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: keyboardType,
          obscureText: isSecure,
          controller: txtController,
          decoration: InputDecoration(
            labelText: txtHint,
            labelStyle: TextStyle(color: focusNode.hasFocus ? focusBorderColor : Colors.grey, fontSize: GlobalFont.textFontSize),
            contentPadding: EdgeInsets.symmetric(vertical: 8),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                    color: Colors.grey
                )
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.3,
                  style: BorderStyle.solid,
                  color: GlobalColors.firstColor,
              )
          ),
          ),
        ),
      ),
    );
  }
}
class NewUnderLineTextField extends StatelessWidget {

  final FocusNode focusNode;
  final String txtHint;
  final bool isSecure;
  final TextInputType keyboardType;
  final Color enableBorderColor;
  final Color focusBorderColor;
  final Color textColor;
  final TextEditingController txtController;
  final VoidCallback onTapFunc;


  NewUnderLineTextField({
    this.focusNode,
    this.txtHint,
    this.isSecure,
    this.keyboardType,
    this.enableBorderColor,
    this.focusBorderColor,
    this.textColor,
    this.txtController,
    this.onTapFunc
  });
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          accentColor: focusBorderColor
      ),
      child: SizedBox(
        height: 50,
        child: TextField(
          focusNode: focusNode,
          onTap: onTapFunc,
          style: TextStyle(color: textColor, fontSize: GlobalFont.textFontSize),
          textAlign: TextAlign.justify,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: keyboardType,
          obscureText: isSecure,
          controller: txtController,
          decoration: InputDecoration(
            labelText: txtHint,
            labelStyle: TextStyle(color: focusNode.hasFocus ? focusBorderColor : Colors.grey, fontSize: GlobalFont.textFontSize),
            contentPadding: EdgeInsets.symmetric(vertical: 8),
//            enabledBorder: UnderlineInputBorder(
//                borderSide: BorderSide(
//                    width: 1,
//                    style: BorderStyle.solid,
//                    color: Colors.grey
//                )
//            ),
//            focusedBorder: UnderlineInputBorder(
//                borderSide: BorderSide(
//                  width: 1.3,
//                  style: BorderStyle.solid,
//                  color: GlobalColors.firstColor,
//                )
//            ),
          ),
        ),
      ),
    );
  }
}