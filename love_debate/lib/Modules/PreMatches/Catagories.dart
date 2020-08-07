
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:app_push_notifications/Models/CategoryModel.dart';
import 'package:app_push_notifications/Models/OnBoardingModel.dart';
import 'package:app_push_notifications/Models/PreMatches.dart';
import 'package:app_push_notifications/Utils/Constants/WebService.dart';
import 'package:app_push_notifications/Utils/Controllers/ApiBaseHelper.dart';
import 'package:app_push_notifications/Utils/Controllers/AppExceptions.dart';
import 'package:app_push_notifications/Utils/Controllers/Loader.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:app_push_notifications/Modules/PreMatches/Rounds/Rounds.dart';
import 'package:app_push_notifications/Utils/Globals/CustomAppBar.dart';
import 'package:app_push_notifications/Utils/Globals/Fonts.dart';
import 'package:app_push_notifications/Utils/Globals/GlobalFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Catagories extends StatefulWidget {
  Matches roundDetail;
  Catagories({this.roundDetail});

  @override
  _CatagoriesState createState() => _CatagoriesState();
}

class _CatagoriesState extends State<Catagories> {
  int apiCall = 0;
  List<CatagoryModel> catData = List<CatagoryModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.roundDetail.prId);
    apiCall =1;
    setState(() {
      getCatogeries();
    });
  }

  @override
  Widget build(BuildContext context) {

    double _height=(MediaQuery.of(context).size.height-MediaQuery.of(context).padding.vertical)-AppBar().preferredSize.height;
    return Scaffold(
      appBar: CustomAppbar.setNavigation("Catagories"),
      body: SafeArea(
        top: true,
        child: (apiCall == 0) ? ListView.builder(
          itemCount: catData.length,
          itemBuilder: (context,index){
            return CatagoryItem(catData[index], context);
          },
        ):Center(child: Loading(),),

//        child: ListView(
//            children: <Widget>[
//              CatagoryItem('Kids',context),
//              CatagoryItem("Hobbies",context),
//              CatagoryItem("Preferences",context),
//              CatagoryItem("Family",context),
//              CatagoryItem("Home Town",context),
//              CatagoryItem("Job",context),
//              CatagoryItem("Future ",context),
//            ],
//
//        ),
      ),
    );
  }

  InkWell CatagoryItem(CatagoryModel cat,BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => Rounds(catId: cat.cId.toString(),)));

      },
      child: Container(
        height:75,
        width:double.infinity,
        child: Card(
          elevation: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 16,),
              Expanded(child: Text(cat.cName,style: TextStyle(fontSize: GlobalFont.textFontSize , fontWeight: FontWeight.w500,color: Colors.black,),)),
              Icon(Icons.navigate_next,size: 25,color:  GlobalColors.firstColor,),
              SizedBox(width: 12,),

            ],
          ),
        ),
      ),
    );
  }


///API Call
  void getCatogeries(){
    Map<String, dynamic> body = {
    };
    print(body);
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.get,authorization: false, url: WebService.roundCategories,body: body,isFormData: false).then(
              (response) async{

            var res = response as http.Response;
            if (res.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(res.body);
              if(responseJson.containsKey('success')){
                responseJson["success"].forEach((v) {
                  catData.add(CatagoryModel.fromJson(v));
                });
                apiCall = 0;
                setState(() {});

              }else{
                apiCall = 0;
                setState(() {});
                print("Oh no response");
              }
            }else if (res.statusCode == 401){
              apiCall = 0;
              setState(() {});
              Map<String, dynamic> err = json.decode(res.body);
              GFunction.showError(err['error'].toString(), context);
            }else{
              apiCall = 0;
              setState(() {});
              GFunction.showError(res.reasonPhrase.toString(), context);
            }
          });
    } on FetchDataException catch(e) {
      apiCall = 0;
      setState(() {});
      GFunction.showError(e.toString(), context);
    }
  }
}