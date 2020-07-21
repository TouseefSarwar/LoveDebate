//ErrorDialog

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Utils/Designables/CustomButtons.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';


//class ErrorDialog extends StatelessWidget {
//
//
//  String errorMsg;
//
//  ErrorDialog({this.errorMsg});
//
//  @override
//  Widget build(BuildContext context) {
//    var totalDialogWidth = (MediaQuery.of(context).size.width - 20)/2.2;
//    // var centerBoxWidth = (MediaQuery.of(context).size.width - 80)/ 2.2;
//    var totalHeight = totalDialogWidth + 121;
//    return Dialog(
//      shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.all(Radius.circular(22.5))
//      ),
//      child: Container(
//        decoration: BoxDecoration(
//          //color: Colors.pink,
//            borderRadius: BorderRadius.all(Radius.circular(22.5))
//        ),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            SizedBox(height: 12,),
//            Container(
//              height: 30,
//              width: 30,
//              child: Image.asset("images/close.png"),
//            ),
//            SizedBox(height: 16,),
//            Text("Oops!",style: TextStyle(fontSize: GlobalFont.textFontSize,fontWeight: FontWeight.bold),),
//            SizedBox(height: 16,),
//            Text(errorMsg,style: TextStyle(fontSize: GlobalFont.textFontSize,),textDirection: TextDirection.ltr,maxLines: 5,),
//            SizedBox(height: 16,),
//            Container(
//              height: 45,
//              width: 100,
//              // color: Colors.pink,
//              child: CustomRaisedButton(
//                buttonText: 'Ok',
//                cornerRadius:22.5,
//                textColor: Colors.white,
//                backgroundColor:Color(0xffff0000),
//                borderWith: 0,
//                action: (){
//                  ///validateFields();
//                },
//              ),
//            ),
//
//          ],
//        ),
//      ),
//    );
//  }
//}


class ErrorDialog extends StatefulWidget {

  String errorMsg;
  ErrorDialog({this.errorMsg});
  @override
  _ErrorDialogState createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  Widget build(BuildContext context) {

    var totalDialogWidth = (MediaQuery.of(context).size.width - 20)/2.2;
    // var centerBoxWidth = (MediaQuery.of(context).size.width - 80)/ 2.2;
    var totalHeight = totalDialogWidth + 121;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(22.5))
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 12,),
            Container(
              height: 30,
              width: 30,
              child: Image.asset("images/close.png"),
            ),
            SizedBox(height: 16,),
            Text("Oops!",style: TextStyle(fontSize: GlobalFont.textFontSize,fontWeight: FontWeight.bold),),
            SizedBox(height: 8,),
            Text(widget.errorMsg,style: TextStyle(fontSize: GlobalFont.textFontSize,),textDirection: TextDirection.ltr,maxLines: 5,),
            SizedBox(height: 16,),
            Container(
              height: 45,
              width: 100,
              // color: Colors.pink,
              child: CustomRaisedButton(
                buttonText: 'Ok',
                cornerRadius:22.5,
                textColor: Colors.white,
                backgroundColor:GlobalColors.firstColor,
                borderWith: 0,
                action: (){
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }
}



class SuccesfullDialog extends StatefulWidget {

  String sucMsg;
  String titleMsg;
  VoidCallback action;

  SuccesfullDialog({this.sucMsg,this.titleMsg, this.action});
  @override
  _SuccesfullDialog createState() => _SuccesfullDialog();
}

class _SuccesfullDialog extends State<SuccesfullDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(22.5))
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 12,),
            Container(
              height: 40,
              width: 40,
              child: Image.asset("images/tick.png"),
            ),
            SizedBox(height: 16,),
            Text("Welcome to LoveDebate!",style: TextStyle(fontSize: GlobalFont.textFontSize,fontWeight: FontWeight.bold),),
            SizedBox(height: 16,),
            Text("Please continue to our onboarding process so that we come up with the best possible matches for you.",style: TextStyle(fontSize: GlobalFont.textFontSize,),textAlign: TextAlign.center,maxLines: 5,),
            SizedBox(height: 16,),
            Container(
              height: 45,
              width: 100,
              // color: Colors.pink,
              child: CustomRaisedButton(
                buttonText: 'Continue',
                cornerRadius:22.5,
                textColor: Colors.white,
                backgroundColor: GlobalColors.firstColor,
                borderWith: 0,
                action:  widget.action,
              ),
            ),
            SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }
}