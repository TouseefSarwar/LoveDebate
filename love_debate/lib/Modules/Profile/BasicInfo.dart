
//import 'package:app_push_notifications/Utils/Globals/Colors.dart';
//import 'package:app_push_notifications/Utils/Globals/CustomAppBar.dart';
//import 'package:app_push_notifications/Utils/Globals/Fonts.dart';
//import 'package:app_push_notifications/Utils/Designables/CustomButtons.dart';
//import 'package:app_push_notifications/Utils/Designables/CustomTextFeilds.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:gradient_app_bar/gradient_app_bar.dart';
//
//class BasicInfo extends StatefulWidget {
//  @override
//  _BasicInfoState createState() => _BasicInfoState();
//}
//
//class _BasicInfoState extends State<BasicInfo> {
//
//  int index1=1;
//  int index2=2;
//  int selectedradio=0;
//
//
//  @override
//  void initState() {
//    super.initState();
//    selectedradio=0;
//  }
//
//  setSelectedRadio(int val) {
//    setState(() {
//      selectedradio = val;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    TextEditingController txtEmailController = TextEditingController();
//    FocusNode txtEmailFocusNode = FocusNode();
//
//    double height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
//    double width=MediaQuery.of(context).size.width;
//    return Scaffold(
//      appBar: CustomAppbar.setNavigation("Basic Info"),
//      body: Container(
//      height: height,
////      color: Colors.white,
//      width: width,
//      margin: EdgeInsets.all(16),
//      child: ListView(
//        children: <Widget>[
//          emailTextField(txtEmailFocusNode,txtEmailController,'First Name'),
//          emailTextField(txtEmailFocusNode,txtEmailController,'Last Name'),
//
//          emailTextField(txtEmailFocusNode,txtEmailController,'Date of Birth'),
//          emailTextField(txtEmailFocusNode,txtEmailController,'Height'),
//          Padding(
//            padding: const EdgeInsets.only(left: 16,top: 16),
//            child: Text("Gender",style: TextStyle(fontSize: GlobalFont.textFontSize,color: Colors.grey),),
//          ),
//          SizedBox(height: 16,),
//          Row(
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                    width: 100,
//                    child:customRadioButton(index1, selectedradio, 'Male ',context, (value){
//                      var index  =index1;
//                      setState(() {
//                        selectedradio=index1;
//                      });
//                    })
//                ),
//              ),
//              Expanded(
//                child: Container(
//                    width: 100,
//                    child: customRadioButton(index2, selectedradio, 'Female',context, (value){
//                      var index  =index2;
//                      setState(() {
//                        selectedradio=index2;
//                      });
//                    })
//                ),
//              ),
//            ],
//          ),
////          emailTextField(txtEmailFocusNode,txtEmailController,'Martial Status'),
////          emailTextField(txtEmailFocusNode,txtEmailController,'Willing to move Abroad'),
////          emailTextField(txtEmailFocusNode,txtEmailController,'Nationality'),
//          emailTextField(txtEmailFocusNode,txtEmailController,'Country of Residence'),
//          emailTextField(txtEmailFocusNode,txtEmailController,'City'),
//          btnContinue(),
//
//
//
//
//        ],
//      ),
//    ),
//    );
//  }
//  Widget emailTextField( FocusNode txtEmailFocusNode, TextEditingController txtEmailController,String text) {
//    return Padding(
//      padding: const EdgeInsets.all(16),
//      child: UnderLineTextField(
//        focusNode: txtEmailFocusNode,
//        txtHint: text,
//        isSecure: false,
//        keyboardType: TextInputType.emailAddress,
//        enableBorderColor: Colors.white,
//        focusBorderColor: Colors.white,
//        textColor: Colors.white,
//        txtController: txtEmailController,
//        onTapFunc: () {
//          setState(() {
//            FocusScope.of(context).requestFocus(txtEmailFocusNode);
//          });
//        },
//      ),
//    );
//  }
//  Widget customRadioButton(int value, int groupedValue, String text,BuildContext context, ValueChanged _onChange) {
//    return InkWell(
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.start,
//        children: <Widget>[
//          Radio(value: value, groupValue: groupedValue, onChanged: _onChange,activeColor: Theme.of(context).primaryColor,),
//          Text(text,style: TextStyle(fontSize: 18),),
//        ],
//      ),
//    );
//  }
//
//  Widget btnContinue() {
//    return SizedBox(
//      height: 45,
//      width: double.infinity,
//      child: CustomRaisedButton(
//        buttonText: 'Update',
//        cornerRadius: 5,
//        textColor: Colors.white,
//        backgroundColor:GlobalColors.firstColor,
//        borderWith: 0,
//        action: (){
//          setState(() {
//           // Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
//          });
////
//        },
//      ),
//    );
//  }
//}


import 'dart:convert';

import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:app_push_notifications/Models/LoginModel.dart';
import 'package:app_push_notifications/Models/UserDetailModel.dart';
import 'package:app_push_notifications/Modules/LoginSignup/HeightDialogBox.dart';
import 'package:app_push_notifications/Modules/Preferences/GooglePlaces.dart';
import 'package:app_push_notifications/Modules/Profile/ProfileAddressDialogBox.dart';
import 'package:app_push_notifications/Utils/Constants/WebService.dart';
import 'package:app_push_notifications/Utils/Controllers/ApiBaseHelper.dart';
import 'package:app_push_notifications/Utils/Controllers/Loader.dart';
import 'package:app_push_notifications/Utils/Designables/Toast.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:app_push_notifications/Utils/Globals/CustomAppBar.dart';
import 'package:app_push_notifications/Utils/Globals/Fonts.dart';
import 'package:app_push_notifications/Utils/Designables/CustomButtons.dart';
import 'package:app_push_notifications/Utils/Designables/CustomTextFeilds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:app_push_notifications/Utils/Globals/GlobalFunctions.dart';
import 'package:app_push_notifications/Utils/Globals/UserSession.dart';
import 'dart:math';
import '../../Utils/Controllers/AppExceptions.dart';
import 'package:http/http.dart' as http;

const kGoogleApiKey = "AIzaSyDkrmNt7yLpSO4JA9k7JdzVmX3KQrvvyzg";
// to get places detail (lat/lng)
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class BasicInfo extends StatefulWidget {


  @override
  _BasicInfoState createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {

  int index1=1;
  int index2=2;
  int selectedradio=0;


  TextEditingController fnameTF = TextEditingController(text: "");
  TextEditingController lnameTF = TextEditingController(text: "");
  TextEditingController emailTF = TextEditingController(text: "");
  TextEditingController passTF = TextEditingController(text: "");
  TextEditingController confirmTF = TextEditingController(text: "");
  TextEditingController heightTF = TextEditingController(text: "");
  TextEditingController dobTF = TextEditingController(text: "");
  TextEditingController addressTF = TextEditingController(text: "");


  FocusNode fnameFN = FocusNode();
  FocusNode lnameFN = FocusNode();
  FocusNode cityFN = FocusNode();
  FocusNode countryFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode heightFN = FocusNode();
  FocusNode dobFN = FocusNode();

  int apiCall = 0;
  Map<String, dynamic> val;


  DateFormat dateFormat = DateFormat("MM/dd/yyyy");

  @override
  void initState() {
    super.initState();
    selectedradio=0;
    fnameTF.text = UserSession.userData.firstName;
    lnameTF.text = UserSession.userData.lastName;
    heightTF.text = UserSession.userData.height;
    dobTF.text = UserSession.userData.dob;
    addressTF.text = UserSession.userData.city +", "+UserSession.userData.state;
    selectedradio = int.parse(UserSession.userData.gender);

  }

  setSelectedRadio(int val) {
    setState(() {
      selectedradio = val;
    });
  }


  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    setState(() {
      DateTime now = DateTime.now();
      String limit=DateFormat("yyyy-MM-dd").format(now);
      selectedDate = picked;
      final selected=DateFormat("yyyy-MM-dd").format(selectedDate);
      final difference=DateTime.now().difference(picked).inDays;
      if(!difference.isNegative){
        dobTF.text=selected;
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
        DateTime now = DateTime.now();
        String limit=DateFormat("yyyy-MM-dd").format(now);
        selectedDate = selectedDate;
        final selected=DateFormat("yyyy-MM-dd").format(selectedDate);
        final difference=DateTime.now().difference(selectedDate).inDays;
        print("Diffderence "+difference.toString());
        if(!difference.isNegative){
          dobTF.text=selected;
        }
        else{
          dobTF.text=" ";
          Toast.show("Invalid Date", context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppbar.setNavigation("Basic Info"),
      body: (apiCall == 0) ?Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            emailTextField(fnameFN,fnameTF,'First Name'),
            emailTextField(lnameFN,lnameTF,'Last Name'),
            dateTime(dobFN,dobTF,'Date of Birth'),
            emailTextField(heightFN,heightTF,'Height'),
//            Padding(
//              padding: const EdgeInsets.only(left: 16,top: 16),
//              child: Text("Gender",style: TextStyle(fontSize: GlobalFont.textFontSize,color: Colors.grey),),
//            ),
//            SizedBox(height: 0,),
//            Row(
//              children: <Widget>[
//                Expanded(
//                  child: Container(
//                      width: 100,
//                      child:customRadioButton(index1, selectedradio, 'Male ',context, (value){
//                        setState(() {
//                          selectedradio=index1;
//                        });
//                      })
//                  ),
//                ),
//                Expanded(
//                  child: Container(
//                      width: 100,
//                      child: customRadioButton(index2, selectedradio, 'Female',context, (value){
//                        var index =index2;
//                        setState(() {
//                          selectedradio=index2;
//                        });
//                      })
//                  ),
//                ),
//              ],
//            ),
            emailTextField(countryFN,addressTF,'Current Address'),
            btnContinue(),
          ],
        ),
      ) : Center(child: Loading(),),
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
        textColor: Colors.black,
        txtController: txtEmailController,
        onTapFunc: () {
          setState(() {
            FocusScope.of(context).requestFocus(txtEmailFocusNode);

            if(text=='Height'){
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
            if(text=='Current Address'){
              FocusScope.of(context).requestFocus(FocusNode());
              _handlePressButton();
            }
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
          Radio(value: value, groupValue: groupedValue, onChanged: _onChange,activeColor: GlobalColors.firstColor,),
          Text(text,style: TextStyle(fontSize: 18),),
        ],
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
        buttonText: 'Update',
        cornerRadius: 5,
        textColor: Colors.white,
        backgroundColor:GlobalColors.firstColor,
        borderWith: 0,
        action: (){
          apiCall = 1;
          setState(() {

            updateProfile();
// Navigator.push(context, CupertinoPageRoute(builder: (context) => TabBarControllerPage()));
          });
//
        },
      ),
    );
  }

///////////////Update Function////////////////////////////////////////////
  void updateProfile(){

    Map<String, dynamic> body = {
      'first_name': fnameTF.text,
      'last_name': lnameTF.text,
      'address' : val,
      'dob':dobTF.text,
      'height':heightTF.text,
    };
    print(body);
    try {

      ApiBaseHelper().fetchService(method: HttpMethod.post,authorization: true, url: WebService.updateProfile,body: body,isFormData: false).then(
              (response){

            var res = response as http.Response;
            if (res.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(res.body);
              if(responseJson.containsKey('success')){
                print("SuccesFully Updated.");
                UserSession.userData.firstName = fnameTF.text;
                UserSession.userData.lastName = lnameTF.text;
                UserSession.userData.city = val['city'];
                UserSession.userData.city = val['state'];
                UserSession.userData.city = val['formatted_address'];
                UserSession.userData.city = val['lat'];
                UserSession.userData.city = val['lng'];
                UserSession.userData.dob = dobTF.text;
                UserSession.userData.height = heightTF.text;
                apiCall =0;
                setState(() {});
              }else{
                apiCall =0;
                setState(() {});
                print("Oh no response");
              }

            }else if (res.statusCode == 401){
              apiCall =0;
              setState(() {});
              Toast.show(res.reasonPhrase.toString(), context, duration: Toast.LENGTH_LONG);
            }else{
              apiCall =0;
              setState(() {});
              Toast.show(res.reasonPhrase.toString(), context, duration: Toast.LENGTH_LONG);
            }
          });
    } on FetchDataException catch(e) {
      apiCall =0;
      setState(() {});
    }
  }




  /// Gooogle Place Work belowww....

  Future<void> _handlePressButton() async {
// show input autocomplete with selected mode
// then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: Mode.overlay,

// language: "fr",
// components: [Component(Component.country, "fr")],
    );
    displayPrediction(p, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
// get detail (lat/lng)
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      var lat = detail.result.geometry.location.lat != null && detail.result.geometry.location.lat.toString() != "" ? detail.result.geometry.location.lat.toString() : "";
      var lng = detail.result.geometry.location.lng != null && detail.result.geometry.location.lng.toString() != "" ? detail.result.geometry.location.lng.toString() : "";
      var fortAdd= detail.result.formattedAddress != null && detail.result.formattedAddress.toString() != ""? detail.result.formattedAddress.toString() : "";
      var city="";
      var state="";
      for(int i=0;i<detail.result.addressComponents.length;i++){
        if(detail.result.addressComponents[i].types[0].toString()=="administrative_area_level_1"){
          if (detail.result.addressComponents[i].longName != null && detail.result.addressComponents[i].longName != ""){
            state =detail.result.addressComponents[i].longName.toString();
          }
        }
        if(detail.result.addressComponents[i].types[0]=="locality"){
          if (detail.result.addressComponents[i].longName != null && detail.result.addressComponents[i].longName != ""){
            city =detail.result.addressComponents[i].longName.toString();
          }
        }
      }
      if(city==''||state==''){

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return ProfileAddressDialogBox(tempCity: city,tempState: state,tempFAdd: fortAdd,tempLat: lat,tempLng: lng);
            }

        ).then((value){
          setState(() {
            addressTF.text=value["city"].toString()+", "+value["state"].toString();

            city = value["city"].toString();
            state = value["state"].toString();
            fortAdd = value["formatted_address"].toString();
            lat = value["lat"].toString();
            lng = value["lng"].toString();
          });
        });
      }
      else{
        addressTF.text=city+", "+state;
      }
     val = {"city" : city, "state" :state , "formatted_address":fortAdd,"lat":lat,"lng":lng};

// print(val["city"]);
//
// if ((val["city"].toString() == null || val["city"].toString() == "") || (val["state"].toString() == null || val["state"].toString() == "")){
// showDialog(
// barrierDismissible: false,
// context: context,
// builder: (context) {
// return DialogboxAddSlider(Question: AnswersGlobal.questions[AnswersGlobal.questionIndex],tempCity: val["city"],tempState: val["state"],);
// }
//
// ).then((value){
// setState(() {
// });
// });
// }else{
// AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns.clear();
// AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns.add(val["city"].toString());
// AnswersGlobal.questions[AnswersGlobal.questionIndex].qaAns.add(val["state"].toString());
// setState(() {
// });
// }

    }
  }
}

class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold()
      : super(
    apiKey: kGoogleApiKey,
    sessionToken: Uuid().generateV4(),
    language: "en",
    components: [Component(Component.country, "uk")],
  );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
    final body = PlacesAutocompleteResult(
      onTap: (p) {
        displayPrediction(p, searchScaffoldKey.currentState);
      },
      logo: Row(
        children: [FlutterLogo()],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
    return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    searchScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {
      searchScaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Got answer")),
      );
    }
  }
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
// Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(generateBits(bitCount), digitCount);

  int generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}


