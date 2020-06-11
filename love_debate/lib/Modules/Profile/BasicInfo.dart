import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Widgets/CustomButtons.dart';
import 'package:lovedebate/Widgets/CustomTextFeilds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class BasicInfo extends StatefulWidget {
  @override
  _BasicInfoState createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {

  int index1=1;
  int index2=2;
  int selectedradio=0;


  @override
  void initState() {
    super.initState();
    selectedradio=0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedradio = val;
    });
  }

  @override
  Widget build(BuildContext context) {

    TextEditingController txtEmailController = TextEditingController();
    FocusNode txtEmailFocusNode = FocusNode();

    double height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: GlobalColors.firstColor,
        backgroundColorEnd: GlobalColors.secondColor,
        title:  Text('Basic Info',style:TextStyle(color: Colors.white ,fontSize: 30, fontFamily: 'Satisfy', fontWeight:  FontWeight.bold)),
        centerTitle: true,
      ),body: Container(
      height: height,
      width: width,
      margin: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          emailTextField(txtEmailFocusNode,txtEmailController,'Name'),
          Padding(
            padding: const EdgeInsets.only(left: 16,top: 16),
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
          emailTextField(txtEmailFocusNode,txtEmailController,'Date of Birth'),
          emailTextField(txtEmailFocusNode,txtEmailController,'Height'),
          emailTextField(txtEmailFocusNode,txtEmailController,'Martial Status'),
          emailTextField(txtEmailFocusNode,txtEmailController,'Willing to move Abroad'),
          emailTextField(txtEmailFocusNode,txtEmailController,'Nationality'),
          emailTextField(txtEmailFocusNode,txtEmailController,'Country of Residence'),
          emailTextField(txtEmailFocusNode,txtEmailController,'City'),
          btnContinue(),




        ],
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
  Widget customRadioButton(int value, int groupedValue, String text,BuildContext context, ValueChanged _onChange) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(value: value, groupValue: groupedValue, onChanged: _onChange,activeColor: Theme.of(context).primaryColor,),
          Text(text,style: TextStyle(fontSize: 18),),
        ],
      ),
    );
  }

  Widget btnContinue() {
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
           // Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
          });
//
        },
      ),
    );
  }
}
