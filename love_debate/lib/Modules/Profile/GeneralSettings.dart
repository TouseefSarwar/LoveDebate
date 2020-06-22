import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/CustomAppBar.dart';
import 'package:lovedebate/Utils/Designables/CustomButtons.dart';
import 'package:lovedebate/Utils/Designables/CustomTextFeilds.dart';


class GeneralSettings extends StatefulWidget {
  @override
  _GeneralSettingsState createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  TextEditingController emailTF = TextEditingController();
  TextEditingController passTF = TextEditingController();
  TextEditingController c_passTF = TextEditingController();

  FocusNode emailFN = FocusNode();
  FocusNode passFN = FocusNode();
  FocusNode c_passFN = FocusNode();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.setNavigation("General Settings"),
      body: SafeArea(
        bottom: false,
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              emailTextField(emailFN, emailTF, "Email"),
              emailTextField(passFN, passTF, "Password"),
              emailTextField(c_passFN, c_passTF, "Confirm Password"),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: saveButton(),
              ),

            ],
          ),
        ),

      ),
    );
  }

  Widget emailTextField( FocusNode txtEmailFocusNode, TextEditingController txtEmailController,String text) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: UnderLineTextField(
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
      ),
    );
  }

  Widget saveButton() {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: CustomRaisedButton(
        buttonText: 'Update Password',
        cornerRadius: 5,
        textColor: Colors.white,
        backgroundColor:GlobalColors.firstColor,
        borderWith: 0,
        action: (){
          setState(() {
            // Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
          });
//
        },
      ),
    );
  }

}
