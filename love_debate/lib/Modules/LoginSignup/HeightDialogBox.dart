import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lovedebate/Models/HeightDataModel.dart';
import 'package:lovedebate/Utils/Designables/CustomButtons.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';


class HeightDialogBox extends StatefulWidget {
  @override
  _HeightDialogBoxState createState() => _HeightDialogBoxState();
}

class _HeightDialogBoxState extends State<HeightDialogBox> {

  List<HeightDataModel> _heightList=[];
  var heightArray=[];

  @override
  Widget build(BuildContext context) {
    var totalDialogWidth = (MediaQuery.of(context).size.width - 20)/2.2;
    // var centerBoxWidth = (MediaQuery.of(context).size.width - 80)/ 2.2;
    var totalHeight = totalDialogWidth*3.5;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(22.5))
      ),
      child: Container(
        height: totalHeight,
        width: totalDialogWidth,
        child: Column(
          children: <Widget>[
            Container(
              height:(10/100)*totalHeight,
              child: Center(child: Text("Select Your Height",style: TextStyle(fontSize: GlobalFont.textFontSize),)),
            ),
            Expanded(child: Container(child:FutureBuilder(
              future:  DefaultAssetBundle.of(context)
                  .loadString('files/HeightList.json'),
              builder: (context,snapshot){
                var jsonData = jsonDecode(snapshot.data);
                // print(jsonData["heightArray"]);
                heightArray=jsonData["heightArray"];

                if (heightArray != null) {
                  heightArray=jsonData["heightArray"];
                  for(var u in heightArray){
                    var item =HeightDataModel(height:u,checkValue: false);
                    _heightList.add(item);
                  }
                }
                print(heightArray.length);


                return HeightListItem();
              },
            ))),
            Container(
              //height: 100,
              width: double.infinity,
              //color: Colors.blue,
              margin: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: OnBoardingDialogBoxBtn("Cancel",Colors.grey,Colors.black)),
                  SizedBox(width: 16,),
                  Expanded(child: OnBoardingDialogBoxBtn("Done",GlobalColors.firstColor,Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  ListView HeightListItem() {
    return ListView.builder(
        itemCount:_heightList.length,
        itemBuilder:(BuildContext context,int index){
          return Container(
            height: 60,
            width: double.infinity,
            margin: EdgeInsets.all(8),
            //color: Colors.blue,
            child: Row(
              children: <Widget>[
                //SizedBox(width: 16,),
                new Checkbox(
                  value: _heightList[index].checkValue,
                  onChanged: (checkBoxValue){
                    setState(() {
                      if(_heightList[index].checkValue==false){
                        for (int i =0; i<_heightList.length; i++){
                          if(i == index) {
                            _heightList[i].checkValue=true;
                          }else{
                            _heightList[i].checkValue=false;
                          }
                        }
                      } else{
                        _heightList[index].checkValue=false;
                      }
                    });
                  },
                  checkColor: Colors.white,
                  activeColor: GlobalColors.firstColor,),
                SizedBox(width: 8,),
                Expanded(
                  child: Container(
                      child: Text((_heightList[index].height) ,style: TextStyle(fontSize: GlobalFont.textFontSize,),textAlign: TextAlign.left,overflow: TextOverflow.ellipsis,maxLines: 5,)),
                )
              ],
            ),
          );
        });
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
            String selectedResults=" ";
            _heightList.forEach((f){
              if(f.checkValue==true){
                selectedResults=selectedResults+""+f.height;
              }
            });

            if(text=="Done"){
              Navigator.pop(context, selectedResults,);
            }
            else if(text=="Cancel"){
              Navigator.pop(context);
            }

          });
//
        },
      ),
    );
  }

}
class HeightsArray {
  List<String> heightArray;
  HeightsArray({this.heightArray});
  HeightsArray.fromJson(Map<String, dynamic> json) {
    heightArray = json["heightArray"].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['heightArray'] = this.heightArray;
    return data;
  }
}