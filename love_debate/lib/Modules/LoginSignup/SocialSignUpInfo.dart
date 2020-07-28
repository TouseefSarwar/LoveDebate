import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Modules/LoginSignup/HeightDialogBox.dart';
import 'package:lovedebate/Modules/Preferences/PreferencesOnBoarding.dart';
import 'package:lovedebate/Utils/Constants/SharedPref.dart';
import 'package:lovedebate/Utils/Constants/WebService.dart';
import 'package:lovedebate/Utils/Controllers/ApiBaseHelper.dart';
import 'package:lovedebate/Utils/Controllers/Loader.dart';
import 'package:lovedebate/Utils/Designables/CustomButtons.dart';
import 'package:lovedebate/Utils/Designables/CustomTextFeilds.dart';
import 'package:lovedebate/Utils/Designables/Toast.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/CustomAppBar.dart';
import 'package:intl/intl.dart';
import 'package:lovedebate/Utils/Globals/GlobalFunctions.dart';
import 'package:lovedebate/Utils/Globals/SignUpGlobal.dart';
import 'package:lovedebate/Utils/Controllers/AppExceptions.dart';
import 'package:http/http.dart' as http;
import 'package:lovedebate/Utils/Globals/UserSession.dart';

class SocialSignUpForm extends StatefulWidget {

  String email;
  String firstName;
  String lastName;

  SocialSignUpForm({this.email,this.firstName,this.lastName});
  @override
  _SocialSignUpFormState createState() => _SocialSignUpFormState();
}
enum Gender { male, female}
class _SocialSignUpFormState extends State<SocialSignUpForm> {

  DateFormat dateFormat = DateFormat("MM/dd/yyyy");
  SharedPref prf = SharedPref();
  TextEditingController heightTF = TextEditingController();
  TextEditingController dobTF = TextEditingController();
  TextEditingController emailTF = TextEditingController();
  Gender _genderValue = Gender.male;

  FocusNode heightFN = FocusNode();
  FocusNode dobFN = FocusNode();
  FocusNode emailFN = FocusNode();

  int index1=1;
  int index2=2;
  int selectedradio=0;
  bool islaoding = false;

  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    //if (picked != null && picked != selectedDate)
    setState(() {
      DateTime now = DateTime.now();
      String limit=DateFormat("yyyy-MM-dd").format(now);
      print("Today"+limit);
      selectedDate = picked;
      final selected=DateFormat("yyyy-MM-dd").format(selectedDate);
      //dobTF.text=selected;
      final difference=DateTime.now().difference(picked).inDays;
      print("Diffderence "+difference.toString());
      if(!difference.isNegative){
        dobTF.text=selected;
        print(dobTF.text);
      }
      else{
        dobTF.text=" ";
        Toast.show("Invalid Date", context);
      }
      // print(DateFormat("dd/MM/yyyy").format(selectedDate));
      //DateFormat.M.format(selectedDate);
      //dobTF.text = selectedDate.toString();
    });
  }
  Widget _selectTimeIos(){
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.date,
      initialDateTime: DateTime.now(),
      onDateTimeChanged: (DateTime date){
        // dobTF.text=DateFormat("yyyy-MM-dd").format(selectedDate);
        DateTime now = DateTime.now();
        String limit=DateFormat("yyyy-MM-dd").format(now);
        print("Today"+limit);
        selectedDate = selectedDate;
        final selected=DateFormat("yyyy-MM-dd").format(selectedDate);
        //dobTF.text=selected;

        final difference=DateTime.now().difference(selectedDate).inDays;
        print("Diffderence "+difference.toString());
        if(!difference.isNegative){
          dobTF.text=selected;
          print(dobTF.text);
        }
        else{
          dobTF.text=" ";
          Toast.show("Invalid Date", context);

        }

        //dobTF.text=date.toString().split(" ")[0];
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    double _height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double _width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppbar.setNavigation("SignIn"),
      body: SafeArea(
        child: (!islaoding) ? Container(
          height: _height,
          width: _width,
          // color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[

                (widget.email=="" || widget.email== null)?emailTextField(emailFN,emailTF,'Email',false,TextInputType.text):Container(),

                dateTime(dobFN,dobTF,'Date of Birth'),

                emailTextField(heightFN,heightTF,'Height (ft. in.)',false,TextInputType.number),

                Padding(
                  padding: const EdgeInsets.only(left: 16 ,top: 16),
                  child: Text("Gender",style: TextStyle(fontSize: 18,color: Colors.grey),),
                ),
                SizedBox(height: 16,),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          width: 100,
                          child:customRadioButton(index1, selectedradio, 'Male ',context, (value){
                            var index  =index1;
                            setState(() {
                              selectedradio=index1;
                            });
                          })
                      ),
                    ),
                    Expanded(
                      child: Container(
                          width: 100,
                          //color: Colors.green,
                          child: customRadioButton(index2, selectedradio, 'Female',context, (value){
                            var index  =index2;
                            setState(() {
                              selectedradio=index2;
                            });
                          })
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                btnContinue(),
              ],
            ),
          ),
        ): Center(child: Loading(),),
      ),
    );
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

  Widget emailTextField( FocusNode focusNode, TextEditingController txtFeild,String text ,bool isSecure, TextInputType keyboardType ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: UnderLineTextField(
        focusNode: focusNode,
        txtHint: text,
        isSecure: isSecure,
        keyboardType: keyboardType,
//      enableBorderColor: Colors.white,
        focusBorderColor: Colors.grey,
        textColor: Colors.black,
        txtController: txtFeild,
        onTapFunc: () {
          setState(() {
            // FocusScope.of(context).requestFocus(focusNode);
            if(text=='Height (ft. in.)'){
              //focusNode.unfocus();
              FocusScope.of(context).requestFocus(FocusNode());
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return HeightDialogBox();
                  }
              ).then((value){
                heightTF.text=value;
              });
            }
          });
        },
      ),
    );
  }


  Widget dateTime( FocusNode focusNode, TextEditingController txtFeild,String text) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: UnderLineTextField(
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

            FocusScope.of(context).requestFocus(FocusNode());
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
              _selectDate(context);
            }
          });
        },
      ),
    );
  }

  Widget btnContinue() {
    return SizedBox(


      height: 45,
      width: double.infinity,
      child: CustomRaisedButton(
        buttonText: 'Continue',
        cornerRadius: 5,
        textColor: Colors.white,
        backgroundColor:GlobalColors.firstColor,
        borderWith: 0,
        action: (){
          // validateFields();
          Map<String, dynamic> body;
          if (widget.email == null || widget.email == ""){
            if (emailTF.text.isNotEmpty){
              if (dobTF.text.isNotEmpty){
                if (heightTF.text.isNotEmpty){
                  if (selectedradio == 0){
                    GFunction.showError("Select gender", context);
                  }else{
                    islaoding = true;
                    setState(() {});
                    body = {
                      'first_name': widget.firstName,
                      'last_name': widget.lastName,
                      'email' : emailTF.text,
                      'dob':dobTF.text,
                      'height':heightTF.text,
                      'gender' : selectedradio.toString()
                    };
                    SignUpUser(body);
                  }
                }else{
                  GFunction.showError("Enter Height", context);
                }
              }else{
                GFunction.showError("Enter Date of birth", context);
              }

            }else{
              GFunction.showError("Enter Email", context);
            }
          }else{
            if (dobTF.text.isNotEmpty){
              if (heightTF.text.isNotEmpty){
                var lst = heightTF.text.replaceAll('\"', "");
                var ht = lst.replaceAll("\'",".");
                if (selectedradio == 0){
                  GFunction.showError("Select gender", context);
                }else{
                  islaoding = true;
                  setState(() {});
                  body = {
                    'first_name': widget.firstName,
                    'last_name': widget.lastName,
                    'dob':dobTF.text,
                    'height':ht,
                    'gender' : selectedradio.toString()
                  };
                  SignUpUser(body);
                }
              }else{
                GFunction.showError("Enter Height", context);
              }
            }else{
              GFunction.showError("Enter Date of birth", context);
            }
          }

        },
      ),
    );
  }

  void SignUpUser(Map<String, dynamic> body ){

    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post,authorization: true, url: WebService.updateProfile,body: body,isFormData: false).then(
              (response) async{

            var res = response as http.Response;
            if (res.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(res.body);
              if(responseJson.containsKey('success')){
                await prf.set(UserSession.signUp,true);
                UserSession.isSignup = await prf.getBy(UserSession.signUp);
                islaoding = false;
                setState(() {});
                 Navigator.push(context, CupertinoPageRoute(builder: (context) => PreferencesOnBoarding()));
              }else{
                print("Oh no response");
              }

            }else if (res.statusCode == 401){
              islaoding = false;
              setState(() {});
              GFunction.showError(jsonDecode(res.body)["error"].toString(), context);
            }else{
              islaoding = false;
              setState(() {});
              GFunction.showError(res.reasonPhrase.toString(), context);
            }

          });
    } on FetchDataException catch(e) {
      setState(() {

      });
    }
  }

}