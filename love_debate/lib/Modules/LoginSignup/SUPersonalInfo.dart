
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovedebate/Modules/LoginSignup/SUAccountInfo.dart';
import 'package:lovedebate/Utils/Designables/Toast.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/CustomAppBar.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';
import 'package:lovedebate/Utils/Designables/CustomTextFeilds.dart';
import 'package:lovedebate/Utils/Globals/SignUpGlobal.dart';
import '../../Utils/Constants/WebService.dart';
import '../../Utils/Controllers/ApiBaseHelper.dart';
import '../../Utils/Controllers/AppExceptions.dart';
import 'package:intl/intl.dart';


class SUPersonalInfo extends StatefulWidget {
  @override
  _SUPersonalInfoState createState() => _SUPersonalInfoState();
}
enum Gender { male, female}
class _SUPersonalInfoState extends State<SUPersonalInfo> {

  //New
  int index1=1;
  int index2=2;
  int selectedradio=0;

  DateFormat dateFormat = DateFormat("MM/dd/yyyy");
  //end
  TextEditingController fnameTF = TextEditingController();
  TextEditingController lnameTF = TextEditingController();
  TextEditingController emailTF = TextEditingController();
  TextEditingController passTF = TextEditingController();
  TextEditingController confirmTF = TextEditingController();
  TextEditingController heightTF = TextEditingController();
  TextEditingController dobTF = TextEditingController();
  Gender _genderValue = Gender.male;

  FocusNode fnameFN = FocusNode();
  FocusNode lnameFN = FocusNode();
  FocusNode passFN = FocusNode();
  FocusNode confirmFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode heightFN = FocusNode();
  FocusNode dobFN = FocusNode();

  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    //if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
      dobTF.text=DateFormat("dd/MM/yyyy").format(selectedDate);
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
        dobTF.text=DateFormat("dd/MM/yyyy").format(selectedDate);
        //dobTF.text=date.toString().split(" ")[0];
      },
    );
  }

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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 32,),
                Center(
                  child: Text(
                    "Personal Info",
                    style: TextStyle(
                        fontSize: GlobalFont.navFontSize,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey
                    ),
                  ),
                ),

                emailTextField(fnameFN,fnameTF,'First Name',false, TextInputType.text),

                emailTextField(lnameFN,lnameTF,'Last Name',false,TextInputType.text),

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
                btnSignUp(),
              ],

            ),
          ),
        ),
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
            FocusScope.of(context).requestFocus(focusNode);
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

//      CustomRaisedButton(
//      buttonText: '',
//      cornerRadius: 30,
//      textColor: Colors.white,
//      backgroundColor:GlobalColors.firstColor,
//      borderWith: 0,
//      action: (){
//        setState(() {
//          ValidateFields();
//        });
//      },
//    );
  }


  void SignUpUser(){
    var gnd = "";
    if ( _genderValue  == Gender.male){
      gnd = "1";
    }else{
      gnd = "2";
    }
    Map<String, dynamic> body = {
      'f_name': fnameTF.text,
      'l_name': lnameTF.text,
      'email': emailTF.text,
      'password' : passTF.text,
      'c_password' : confirmTF.text,
      'gender': gnd,
      'dob' : dobTF.text,
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
    if (fnameTF.text != "" && fnameTF.text!=null){
      if (fnameTF.text != "" && fnameTF.text!=null){
        if (dobTF.text != "" && dobTF.text != null){
          if (heightTF.text != "" && heightTF.text != null){

            SignUpGlobal.f_name = fnameTF.text;
            SignUpGlobal.l_name = lnameTF.text;
            SignUpGlobal.dob = dobTF.text;
            SignUpGlobal.gender = _genderValue.toString();
            SignUpGlobal.personHeight = heightTF.text;

            Navigator.push(context, CupertinoPageRoute(builder: (context) => SUAcountInfo()));
          }else{
            Toast.show("Enter Confirm Password", context, duration: Toast.LENGTH_LONG);
          }
        }else{
          Toast.show("Enter Date of Birth", context, duration: Toast.LENGTH_LONG);
        }
      }else{
        Toast.show("Enter Last Name", context, duration: Toast.LENGTH_LONG);
      }

    }else{
      Toast.show("Enter First Name", context, duration: Toast.LENGTH_LONG);
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