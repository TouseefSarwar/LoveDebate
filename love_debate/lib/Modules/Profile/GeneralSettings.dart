import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:lovedebate/Models/UserDetailModel.dart';
import 'package:lovedebate/Utils/Constants/WebService.dart';
import 'package:lovedebate/Utils/Controllers/ApiBaseHelper.dart';
import 'package:lovedebate/Utils/Controllers/AppExceptions.dart';
import 'package:lovedebate/Utils/Controllers/Loader.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/CustomAppBar.dart';
import 'package:lovedebate/Utils/Designables/CustomButtons.dart';
import 'package:lovedebate/Utils/Designables/CustomTextFeilds.dart';
import 'package:lovedebate/Utils/Globals/GlobalFunctions.dart';


class GeneralSettings extends StatefulWidget {
  UserDetail userData;

  GeneralSettings({this.userData});

  @override
  _GeneralSettingsState createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  TextEditingController emailTF = TextEditingController();
  TextEditingController oldPassTF = TextEditingController();
  TextEditingController newPassTF = TextEditingController();
  TextEditingController cPassTF = TextEditingController();

  FocusNode emailFN = FocusNode();
  FocusNode oldPassFN = FocusNode();
  FocusNode newPassFN = FocusNode();
  FocusNode cPassFN = FocusNode();
  int apiCall =0;
  bool showTooltip =false;
  String _password;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailTF.text = widget.userData.email;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.setNavigation("General Settings"),
      body: SafeArea(
        bottom: false,
        top: false,
        child: (apiCall ==0 )? SingleChildScrollView(
          child: Column(
            children: <Widget>[
              emailTextField(emailFN, emailTF, "Email",false),
              emailTextField(oldPassFN, oldPassTF, "Old Password",true),
              passwordTextField(newPassFN,newPassTF,"New Password"),
//              emailTextField(newPassFN, newPassTF, "New Password",true),
              emailTextField(cPassFN, cPassTF, "Confirm Password",true),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: saveButton(),
              ),

            ],
          ),
        ): Center(child: Loading(),),
      ),
    );
  }

  Widget emailTextField( FocusNode txtEmailFocusNode, TextEditingController txtEmailController,String text,bool secure) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: UnderLineTextField(
        focusNode: txtEmailFocusNode,
        txtHint: text,
        isSecure: secure,
        keyboardType: TextInputType.emailAddress,
        enableBorderColor: Colors.white,
        focusBorderColor: Colors.white,
        textColor: Colors.black,
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
            validateFields();
          });
        },
      ),
    );
  }


  UpdatePassword(){

      Map<String, dynamic> body = {
        "current_password": oldPassTF.text,
        "password" : newPassTF.text,
        "c_password" : cPassTF.text,
        "email" : widget.userData.email.toString(),
      };
      try {
        ApiBaseHelper().fetchService(method: HttpMethod.post,authorization: true, url: WebService.updatePassword,body: body,isFormData: true).then(
                (response) async {
              List<String> val = List<String>();
              if (response.statusCode == 200){
                Map<String, dynamic> responseJson = json.decode(response.body);
                if(responseJson.containsKey('success')) {
                  print("Password successfully Updated.");
                  apiCall =0;
                  Navigator.pop(context);
                } else{
                  print("Oh no response");
                }

              }else if (response.statusCode == 401){
                apiCall=0;
                setState(() {});
                GFunction.showError(response.body["error"].toString(), context);

              }else{
                apiCall=0;
                setState(() {});
                GFunction.showError(response.reasonPhrase.toString(), context);
              }
            });

      } on FetchDataException catch(e) {
        setState(() {
          GFunction.showError(e.toString(), context);
        });
      }
  }

  validateFields(){
    if (oldPassTF.text != "" && oldPassTF.text != null){
      if (newPassTF.text != "" && newPassTF.text != null){
        if (cPassTF.text != "" && cPassTF.text != null){
          if (newPassTF.text == cPassTF.text){
            if(newPassTF.text.length >7){
              apiCall=1;
              setState(() {
                UpdatePassword();
              });
            }else{
              GFunction.showError("Password should have atleast 8 characters.", context);
            }
          }else{
            GFunction.showError("New Password & Confirm should be same.", context);
          }
        }else{
          GFunction.showError("Enter Confirm Password", context);
        }
      }else{
        GFunction.showError("Enter New Password", context);
      }
    }else{
      GFunction.showError("Enter Old Password", context);
    }
  }



  Widget passwordTextField(FocusNode focusNode,TextEditingController txtFeild, String placeholder) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              PasswordTextField(txtHint: placeholder,
                txtIsSecure: true,
                keyboardType: TextInputType.text,
                txtController:txtFeild ,
                onSaved: (String value){
                  _password = value;
                },
                onChanged: (String value){
                  setState(() {
                    _password = value;
                  });
                },
              ),
              (_password != '') ? FlutterPasswordStrength(password:_password, height: 4) : Container(),
            ],
          ),
          Positioned(
            right: 4,
            child: InkWell(
              onTap: (){
                setState(() {
                  showTooltip = showTooltip ? false : true;
                });
              },
              child: Container(height: 30,width: 50),
//child: Icon(Icons.help_outline, color: Colors.black, size: 20,)
            ),
          )
        ],
      ),
    );
  }


}
