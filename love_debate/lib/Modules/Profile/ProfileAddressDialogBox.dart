import 'package:flutter/material.dart';
import 'package:lovedebate/Utils/Designables/CustomButtons.dart';
import 'package:lovedebate/Utils/Designables/CustomTextFeilds.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';

class ProfileAddressDialogBox extends StatefulWidget {
  String tempCity;
  String tempState;
  String tempFAdd ="";
  String tempLat ="";
  String tempLng ="";

  ProfileAddressDialogBox({this.tempCity,this.tempState, this.tempFAdd,this.tempLat,this.tempLng});
  @override
  _ProfileAddressDialogBoxState createState() => _ProfileAddressDialogBoxState();
}

class _ProfileAddressDialogBoxState extends State<ProfileAddressDialogBox> {


  TextEditingController txtCityController = TextEditingController();
  TextEditingController txtStateController = TextEditingController();
  FocusNode txtCityFocusNode = FocusNode();
  FocusNode txtStateFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    txtStateController.text=(widget.tempState==null)?"":widget.tempState;
    txtCityController.text=(widget.tempCity==null)?"":widget.tempCity;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(22.5))
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
//height:(10/100)*totalHeight,
              child: Center(child: Text("Select City and State",style: TextStyle(fontSize: GlobalFont.textFontSize),)),
            ),
            placesTextField(txtStateFocusNode, txtStateController, "State",false),
            placesTextField(txtCityFocusNode,txtCityController,'City',false),
            SizedBox(height: 16,),
            btnUpdate()
          ],
        ),
      ),
    );
  }
  Widget placesTextField( FocusNode focusNode, TextEditingController txtFeild,String text, bool isSecure ) {
    return UnderLineTextField(
      focusNode: focusNode,
      txtHint: text,
      isSecure: isSecure,
      keyboardType: TextInputType.emailAddress,
      enableBorderColor: Colors.white,
      focusBorderColor: Colors.grey,
      textColor: Colors.black,
      txtController: txtFeild,
      onTapFunc: () {
        setState(() {
          FocusScope.of(context).requestFocus(focusNode);
        });
      },
    );
  }
  Widget btnUpdate() {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: CustomRaisedButton(
        buttonText: 'Update',
        cornerRadius: 5,
        textColor: Colors.white,
        backgroundColor:GlobalColors.firstColor,
        borderWith: 0,
        action: (){
          setState(() {
            Map<String, dynamic> val = {
            "city" : txtCityController.text, "state" :txtStateController.text , "formatted_address":widget.tempFAdd,"lat":widget.tempLat,"lng":widget.tempLng,
            };
//            var result=txtCityController.text+" , "+txtStateController.text;

            Navigator.pop(context,val);
// Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
          });
//
        },
      ),
    );
  }
}