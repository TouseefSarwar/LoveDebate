import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Utils/Designables/Toast.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/CustomAppBar.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';
import 'package:lovedebate/Utils/Globals/GlobalFunctions.dart';
import 'package:lovedebate/Widgets/CustomTextFeilds.dart';
import '../../Utils/Constants/WebService.dart';
import '../../Utils/Controllers/ApiBaseHelper.dart';
import '../../Utils/Controllers/AppExceptions.dart';
import '../OnBoarding/OnBoarding.dart';

class SUAcountInfo extends StatefulWidget {
  @override
  _SUAcountInfoState createState() => _SUAcountInfoState();
}
enum Gender { male, female}
class _SUAcountInfoState extends State<SUAcountInfo> {


  //New

  int index1=1;
  int index2=2;
  int selectedradio=0;

  //end


  TextEditingController emailTF = TextEditingController();
  TextEditingController passTF = TextEditingController();
  TextEditingController confirmTF = TextEditingController();

  FocusNode passFN = FocusNode();
  FocusNode confirmFN = FocusNode();
  FocusNode emailFN = FocusNode();

  @override
  Widget build(BuildContext context) {

    double _height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double _width=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppbar.setNavigation(""),
      body: SafeArea(
        top: true,
        child: Container(
          height: _height,
          width: _width,
          color: Colors.white,
//          margin: EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 64,),
              Center(
                child: Text(
                  "Account Info",
                  style: TextStyle(
                      fontSize: GlobalFont.navFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87
                  ),
                ),
              ),
              SizedBox(height: 16,),
              emailTextField(emailFN,emailTF,'Email Address',false),
              SizedBox(height: 16,),
              emailTextField(passFN,passTF,'Password', true),
              SizedBox(height: 16,),
              emailTextField(confirmFN,confirmTF,'Confirm Password',true),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  text: TextSpan(
                    text: 'By clicking sign up, you agree to our ',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: GlobalFont.textFontSize),
                    children: <TextSpan>[
                      TextSpan(text: 'Terms of Service', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                      TextSpan(text: ' and '),
                      TextSpan(text: 'Privacy Policy', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16,),
              btnSignUp(),
            ],

          ),
        ),
      ),
    );
  }

  Widget emailTextField( FocusNode focusNode, TextEditingController txtFeild,String text ,bool isSecure ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: UnderLineTextField(
        focusNode: focusNode,
        txtHint: text,
        isSecure: isSecure,
        keyboardType: TextInputType.emailAddress,
//      enableBorderColor: Colors.white,
        focusBorderColor: Colors.grey,
        textColor: Colors.black,
        txtController: txtFeild,
        onTapFunc: () {
          setState(() {
            FocusScope.of(context).requestFocus(focusNode);
          });
        },
      ),
    );
  }

  Widget btnSignUp() {
    return SizedBox(
      height: 60,
      child: FloatingActionButton(
        backgroundColor: GlobalColors.firstColor,
        onPressed: () => {
          setState(() {
            ValidateFields();
          })
        },
        tooltip: 'Increment',
        child: Icon(Icons.arrow_forward),
      ),
    );
  }


  void SignUpUser(){
    var gnd = "";
//    if ( _genderValue  == Gender.male){
//      gnd = "1";
//    }else{
//      gnd = "2";
//    }
    Map<String, dynamic> body = {
//      'f_name': fnameTF.text,
//      'l_name': lnameTF.text,
      'email': emailTF.text,
      'password' : passTF.text,
      'c_password' : confirmTF.text,
      'gender': gnd,
//      'dob' : dobTF.text,
    };
    print(body);
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post, url: WebService.login,body: body,isFormData: true).then(
              (response){
            Map<String, dynamic> responseJson = json.decode(response);
            if(responseJson.containsKey('success')){

            }else{
              print(responseJson);
            }
          });

    } on FetchDataException catch(e) {
      setState(() {

      });
    }
  }

  void ValidateFields(){
    if (emailTF.text != "" && emailTF.text != null){
      if (GFunction.validateEmail(emailTF.text)){
        //SignUpUser();
        if (passTF.text != "" && passTF.text != null){
          if (confirmTF.text != "" && confirmTF.text != null){
            if (passTF.text == confirmTF.text){
              Navigator.push(context, CupertinoPageRoute(builder: (context) => OnBoarding()));
            }else{
              Toast.show("Password and Confirm Password should be same", context, duration: Toast.LENGTH_LONG);
            }
          }else{
            Toast.show("Enter Confirm Password", context, duration: Toast.LENGTH_LONG);
          }
        }else{
          Toast.show("Enter Password", context, duration: Toast.LENGTH_LONG);
        }
      }else{
        Toast.show("Invalid Email Formate", context, duration: Toast.LENGTH_LONG);
      }
    }else{
      Toast.show("Enter Email Address", context, duration: Toast.LENGTH_LONG);
    }

  }

  Widget customRadioButton(int value, int groupedValue, String text,BuildContext context, ValueChanged _onChange) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(value: value, groupValue: groupedValue, onChanged: _onChange,activeColor: GlobalColors.firstColor,),
          Text(text,style: TextStyle(fontSize: 18),),
        ],
      ),
    );
  }

}
