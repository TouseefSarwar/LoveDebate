import 'package:flutter/material.dart';
import 'package:lovedebate/Modules/OnBoarding/OnBoardingDialogBox/OnBoardingDropDown.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';
import 'package:lovedebate/Widgets/CustomButtons.dart';
import 'package:lovedebate/Widgets/CustomTextFeilds.dart';

class OnBoardingDialogBox extends StatefulWidget {
  @override
  _OnBoardingDialogBoxState createState() => _OnBoardingDialogBoxState();
}

class _OnBoardingDialogBoxState extends State<OnBoardingDialogBox> {






  bool _value1 = false;
  bool _value2 = false;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value2Changed(bool value) => setState(() => _value2 = value);


  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  String _selectedLocation;

  double _itemcount=5;


  @override
  Widget build(BuildContext context) {

    var totalDialogWidth = (MediaQuery.of(context).size.width - 20)/2.2;
    // var centerBoxWidth = (MediaQuery.of(context).size.width - 80)/ 2.2;
    var totalHeight = totalDialogWidth + 121;

    TextEditingController passwordController = new TextEditingController();

    var width=MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(22.5))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
         // OnBoardingSlider(width),
         // OnBoardingCheckBox(),
          OnBoardingDropDownList(width),

        ],
      ),
    );
  }

  Container OnBoardingDropDownList(double width) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16,),
            Text("Select the Option",style: TextStyle(fontSize: GlobalFont.textFontSize),),
            SizedBox(height: 16,),
            Container(
              height: _itemcount*50,
              child: ListView.builder(
                 itemCount: _itemcount.toInt(),
                  itemBuilder: (BuildContext context,int index){
                    return OnBoardingCheckBox();
                  }),
            ),
            Container(
              //height: 100,
              width: width,
              //color: Colors.blue,
              margin: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: OnBoardingDialogBoxBtn("Cancel",Colors.grey,Colors.black)),
                  SizedBox(width: 16,),
                  Expanded(child: OnBoardingDialogBoxBtn("Done",GlobalColors.firstColor,Colors.white)),
                ],
              ),
            )
          ],
        ),
        );
  }

  Container OnBoardingCheckBox() {
    return Container(
            height: 50,
            //color: Colors.blue,
            margin: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                //SizedBox(width: 16,),
                new Checkbox(value: _value1, onChanged: _value1Changed,checkColor: GlobalColors.secondColor,activeColor: GlobalColors.firstColor,),
                SizedBox(width: 16,),
                Text("Select",style: TextStyle(fontSize: GlobalFont.textFontSize),)
              ],
            ),
          );
  }




  Widget OnBoardingDialogBoxBtn(String text,Color color,Color textColor) {
    return SizedBox(
      height: 45,
      //width: width,
      child: CustomRaisedButton(
        buttonText: text,
        cornerRadius: 22.5,
        textColor: textColor,
        backgroundColor:color,
        borderWith: 0,
        action: (){
          setState(() {
          });
//
        },
      ),
    );
  }

  Widget OnBoardingTextFeild( FocusNode focusNode, TextEditingController txtFeild,String text) {
    return UnderLineTextField(
      focusNode: focusNode,
      txtHint: text,
      isSecure: false,
      keyboardType: TextInputType.emailAddress,
      enableBorderColor: Colors.white,
      focusBorderColor: Colors.white,
      textColor: Colors.white,

      txtController: txtFeild,
      onTapFunc: () {
        setState(() {
          FocusScope.of(context).requestFocus(focusNode);
        });
      },
    );
  }

}
//DropdownButton(
//            hint: Text('Please choose a location'), // Not necessary for Option 1
//            value: _selectedLocation,
//            onChanged: (newValue) {
//              setState(() {
//                _selectedLocation = newValue;
//              });
//            },
//            items: _locations.map((location) {
//              return DropdownMenuItem(
//                child: new Text(location),
//                value: location,
//              );
//            }).toList(),
//          ),
