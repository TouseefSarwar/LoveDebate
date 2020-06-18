import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final String buttonText;
  final double cornerRadius;
  final Color backgroundColor;
  final Color textColor;
  final double borderWith;
  final VoidCallback action;
  final String shape;
  CustomRaisedButton({this.buttonText, this.cornerRadius, this.backgroundColor, this.textColor, this.borderWith, this.action,this.shape});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: action,
        color: backgroundColor,
        shape: shape == "circle"? CircleBorder(

        ) : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
            side: BorderSide(color: Theme.of(context).primaryColor, width: borderWith)),
        child: Text(
          buttonText,
          style: TextStyle(
            color: textColor,
            fontSize: 13,
          ),
          textAlign: TextAlign.center,
        ));
  }
}


class CustomFlatButton extends StatelessWidget {

  final String titleText;
  final IconData icon;
  final VoidCallback onTapFunc;

  CustomFlatButton({this.titleText, this.icon, this.onTapFunc});

  @override
  Widget build(BuildContext context) {
    IconThemeData iconThemeData = IconTheme.of(context);
    return FlatButton(
      onPressed: onTapFunc,
      child: Row(
        children: <Widget>[
          Icon(icon,size: iconThemeData.size, color: iconThemeData.color),
          SizedBox(width: 12,),
          Text(titleText,style: TextStyle(fontSize: 16),),
        ],
      ),
    );
  }
}
