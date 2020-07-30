

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovedebate/Utils/Globals/Colors.dart';
import 'package:lovedebate/Utils/Globals/Fonts.dart';

class CameraDialog extends StatefulWidget {
  @override
  _CameraDialogState createState() => _CameraDialogState();
}

class _CameraDialogState extends State<CameraDialog> {

  ImagePicker _picker;
  var picture;
//  openCamera()async{
//    picture = await ImagePicker.pickImage(
//      source: ImageSource.camera,
//    );
//  }
//  openGallery() async{
//    picture = await ImagePicker.pickImage(
//      source: ImageSource.gallery,
//    );
//    print(picture);
//  }
//  File _image;
//  final picker = ImagePicker();
//
//  Future getImage() async {
//    final pickedFile = await picker.getImage(source: ImageSource.camera);
//
//    setState(() {Future getImage() async {
//      final pickedFile = await picker.getImage(source: ImageSource.camera);
//
//      setState(() {
//        _image = File(pickedFile.path);
//      });
//    }
//      _image = File(pickedFile.path);
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(22.5))
      ),
      child: Padding(
        padding:const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Select An Action",style: TextStyle(fontSize: GlobalFont.textFontSize),),
            SizedBox(height: 16,),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: (){
                    setState(() {
//                      openCamera();

                      Navigator.pop(context,picture);

                    });
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.camera_alt,size: 35,color: GlobalColors.firstColor,),
                      SizedBox(height: 8,),
                      Text("Take Photo",style: TextStyle(fontSize: GlobalFont.textFontSize),)
                    ],
                  ),
                ),
                SizedBox(width: 16,),
                InkWell(
                  onTap: (){
                    setState(() {
//                      openGallery();
                      Navigator.pop(context,picture);
                    });
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.camera,size: 35,color: GlobalColors.firstColor,),
                      SizedBox(height: 8,),
                      Text("Open Gallery",style: TextStyle(fontSize: GlobalFont.textFontSize),)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
