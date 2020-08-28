

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_push_notifications/Utils/Globals/Colors.dart';
import 'package:app_push_notifications/Utils/Globals/Fonts.dart';

class CameraDialog extends StatefulWidget {
  @override
  _CameraDialogState createState() => _CameraDialogState();
}

class _CameraDialogState extends State<CameraDialog> {


  File image;
  final picker = ImagePicker();
  Future openCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    image = File(pickedFile.path);
    Navigator.pop(context,image);
  }
  Future openGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 50);
    image = File(pickedFile.path);
    Navigator.pop(context,image);

  }


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
//                      openCamera();
                      Navigator.pop(context,"camera");
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
//                    openGallery();
                    Navigator.pop(context,"gallery");
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
