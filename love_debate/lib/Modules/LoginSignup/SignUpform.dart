import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Widgets/CustomButtons.dart';
import 'package:lovedebate/Widgets/CustomTextFeilds.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  TextEditingController txtEmailController = TextEditingController();
  TextEditingController txtPasswordController = TextEditingController();
  FocusNode txtEmailFocusNode = FocusNode();
  FocusNode txtPasswordFocusNode = FocusNode();

  TextEditingController txtOpenTime = TextEditingController();


  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    localizations.formatTimeOfDay(picked, alwaysUse24HourFormat: true);
    setState(() {

      txtOpenTime.text = localizations.formatTimeOfDay(picked, alwaysUse24HourFormat: true);
//      if(no=='open'){
//        txtOpenTime.text = localizations.formatTimeOfDay(picked, alwaysUse24HourFormat: true);}
//      else{
//        txtCloseTime.text = localizations.formatTimeOfDay(picked, alwaysUse24HourFormat: true);
//      }
    });
  }

  Widget _selectTimeIos(){
    return CupertinoDatePicker(
      initialDateTime: DateTime.now(),
      onDateTimeChanged: (DateTime date){
        //txtCloseTime.text=TimeOfDay.now().toString();
      },
      use24hFormat: true,
    );
  }

  @override
  Widget build(BuildContext context) {

    double _height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double _width=MediaQuery.of(context).size.width;
    double _itemheight=(10/100)*_height;

    return Scaffold(
      appBar: GradientAppBar(
        centerTitle: true,
        title: Text('SignUp',style:TextStyle(color: Colors.white ,fontSize: 30, fontFamily: 'Satisfy', fontWeight:  FontWeight.bold)),
        backgroundColorStart: GlobalColors.firstColor,
        backgroundColorEnd: GlobalColors.secondColor,
      ),
      body: SafeArea(
        top: true,
        child: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              emailTextField(txtEmailFocusNode,txtEmailController,'Name'),
              SizedBox(height: 16,),
              emailTextField(txtEmailFocusNode,txtEmailController,'Password'),
              SizedBox(height: 16,),
              emailTextField(txtEmailFocusNode,txtEmailController,'Confirm Password'),
              SizedBox(height: 16,),
              dateTime(txtEmailFocusNode,txtOpenTime,'Date of Birth'),
              SizedBox(height: 16,),
              btnSignUp(),


            ],

          ),
        ),
      ),
    );
  }
  Widget emailTextField( FocusNode focusNode, TextEditingController txtFeild,String text) {
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
  Widget dateTime( FocusNode focusNode, TextEditingController txtFeild,String text) {
    return UnderLineTextField(
      focusNode: focusNode,
      txtHint: text,
      isSecure: false,
      keyboardType: TextInputType.emailAddress,
      enableBorderColor: Colors.white,
      focusBorderColor: Colors.white,
      textColor: Colors.black,
      txtController: txtFeild,
      onTapFunc: () {
        setState(() {
          if (Theme.of(context).platform == TargetPlatform.iOS){
            showModalBottomSheet(
                context: context,
                builder: (BuildContext builder) {
                  return Container(
                      height:
                      MediaQuery.of(context).copyWith().size.height / 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 50,
                            color: Theme.of(context).primaryColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: SizedBox(
                                    height: 35,
                                    width: 85,
                                    child: RaisedButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      color: Colors.white,
                                      child: Text("Cancel", style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0)
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: SizedBox(
                                    height: 35,
                                    width: 85,
                                    child: RaisedButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      color: Colors.blueAccent,
                                      child: Text("Done", style: TextStyle(fontSize: 16, color: Colors.white),),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0)
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(child: _selectTimeIos())
                        ],
                      )
                  );
                });
          }else{
            _selectTime(context);
          }
        });
      },
    );
  }
  Widget btnSignUp() {
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
//
//            Map<String, dynamic> body = {
//              'email': txtEmailController.text,
//              'password' : txtPasswordController.text,
//            };
//            try {
//              ApiBaseHelper().fetchService(method: HttpMethod.post, url: WebService.login,body: body,isFormData: true).then(
//                      (response) => {
//                    if (response is String){
//
//                    }
//                  });
//
//            } on FetchDataException catch(e) {
//              setState(() {
//
//              });
//            }


          });
//
        },
      ),
    );
  }
}
