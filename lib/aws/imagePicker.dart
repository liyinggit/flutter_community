import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:amazon_cognito_identity_dart/cognito.dart';


class ImagePiker extends StatefulWidget {
  @override
  _ImagePikerState createState() => _ImagePikerState();
}



class _ImagePikerState extends State<ImagePiker> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source:ImageSource.camera);   //ImageSource.gallery

    setState(() {
      _image = image;
      print("图片：");
      print(_image.path);
    });
  }

  void clearPic (){
    setState(() {
      _image = null;
      print("图片：");
      print(_image);
    });
  }

  void uploadImage() async {

    Dio dio = new Dio();
    Response response;
    String path = _image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    const s3url = "https://community2.s3-ap-northeast-1.amazonaws.com/";

    FormData formData = new FormData.fromMap({
      "key": name,
      "Content-Type": "image/jpeg",
      'acl':'public-read',
      'AWSAccessKeyId':'AKIAIXC3CCBXJ7NYNV3Q',
//      'policy':'eyAKICAiY29uZGl0aW9ucyI6IFsKICAgIHsiYnVja2V0IjogImNvbW11bml0eTEifQogIF0KfQ==',
      "file":_image,
    });

    response = await dio.post(s3url,data:formData);
    print("返回：");
    print(response);
  }

  void showImage() async {

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child:
            Container(
              child: Column(
                children: <Widget>[
                  _image == null
                      ? Text('No image selected.')
                      : Image.file(_image),
                  RaisedButton(
                    child: new Text(
                      "上传",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),  ////圆角按钮
                    onPressed:()=> uploadImage(),
                    color: Colors.amber,
                  ),
                  RaisedButton(
                    child: new Text(
                      "清除图片",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),  ////圆角按钮
                    onPressed:()=> clearPic(),
                    color: Colors.amber,
                  )
                ],
              ),
            )

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}