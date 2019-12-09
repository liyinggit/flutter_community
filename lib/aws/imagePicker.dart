import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_cognito_identity_dart/sig_v4.dart';
import './policy.dart';

class ImagePiker extends StatefulWidget {
  @override
  _ImagePikerState createState() => _ImagePikerState();
}

class _ImagePikerState extends State<ImagePiker> {
  File _image;
  String url;

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera); //ImageSource.gallery

    setState(() {
      _image = image;
      print("图片：");
      print(_image.path);
    });
  }

  void clearPic() {
    setState(() {
      _image = null;
      print("图片：");
      print(_image);
    });
  }

  ///目前能上传上去
  void uploadImage() async {
    String path = _image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);

    const _accessKeyId = 'AKIAIXC3CCBXJ7NYNV3Q';
    const _secretKeyId = 'plIuwTxlr+N78zLUbDfZcwk6BROQWuDvnVYR03dA';
    const _region = 'ap-northeast-1';
    const _s3Endpoint = 'https://community2.s3-ap-northeast-1.amazonaws.com';

    final stream = http.ByteStream(DelegatingStream.typed(_image.openRead()));
    final length = await _image.length();

    final uri = Uri.parse(_s3Endpoint);
    final req = http.MultipartRequest("POST", uri);
    final multipartFile =
        http.MultipartFile('file', stream, length, filename: name);

    final policy = Policy.fromS3PresignedPost(
        name, 'community2', _accessKeyId, 15, length,
        region: _region);
    final key =
        SigV4.calculateSigningKey(_secretKeyId, policy.datetime, _region, 's3');
    final signature = SigV4.calculateSignature(key, policy.encode());
    print("签名：" + signature);
    print("policy:" + policy.toString());
    print("key:" + key.toString());

    req.files.add(multipartFile);
    req.fields['key'] = policy.key;
    req.fields['acl'] = 'public-read';
    req.fields['X-Amz-Credential'] = policy.credential;
    req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
    req.fields['X-Amz-Date'] = policy.datetime;
    req.fields['Policy'] = policy.encode();
    req.fields['X-Amz-Signature'] = signature;

    try {
      final res = await req.send();
      print("结果");
      print(res.statusCode);

        setState(() {
          url = _s3Endpoint+"/"+name;
        });

      await for (var value in res.stream.transform(utf8.decoder)) {
        print(value);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void downImage() async {
    const _accessKeyId = 'ASIAZT6NFEICHC7IUSRV';
    const _secretKeyId = 'ZQuyS4mhDicGo4iIwEosFximHaOZishopeywct4o';
    const _sessionToken = 'FwoGZXIvYXdzEIH//////////wEaDLPOyQV4tSp86a68cyJq279cz48TvcA8pA9oiYZWjz3vHcxqNW77I5GmAlSw2RCiH60eA9NxJ6b7/2q74Cq5gceMqQ1HEJoIK6HuB3EqYPMTxWwV7ifvAqARgerKIVyw24/vUl3VQlCxcV9cyealK4uKDnS6Se4UDyjn6rfvBTIot2AGIpj3hM3PlgBD5ROq/GX6oFY5hZIyJkJHEmDsTAA/JZ1gQsp82A==';

    const region = 'ap-northeast-1';
    final host = 's3.ap-northeast-1.amazonaws.com';
    final key = 'https://community2.s3-ap-northeast-1.amazonaws.com/2.jpg';
    final service = 's3';
    final payload = SigV4.hashCanonicalRequest('');
    final datetime = SigV4.generateDatetime();
    final canonicalRequest = '''GET
          ${'/$key'.split('/').map((s) => Uri.encodeComponent(s)).join('/')}
          
          host:$host
          x-amz-content-sha256:$payload
          x-amz-date:$datetime
          x-amz-security-token:${_sessionToken}
         
          host;x-amz-content-sha256;x-amz-date;x-amz-security-token
          $payload''';
    final credentialScope =
    SigV4.buildCredentialScope(datetime, region, service);
    final stringToSign = SigV4.buildStringToSign(datetime, credentialScope,
        SigV4.hashCanonicalRequest(canonicalRequest));
    final signingKey = SigV4.calculateSigningKey(
        _secretKeyId, datetime, region, service);
    final signature = SigV4.calculateSignature(signingKey, stringToSign);

    final authorization = [
      'AWS4-HMAC-SHA256 Credential=${_accessKeyId}/$credentialScope',
      'SignedHeaders=host;x-amz-content-sha256;x-amz-date;x-amz-security-token',
      'Signature=$signature',
    ].join(',');


    final uri = Uri.https(host, key);
    http.Response response;
    try {
      response = await http.get(uri, headers: {
        'Authorization': authorization,
        'x-amz-content-sha256': payload,
        'x-amz-date': datetime,
        'x-amz-security-token': _sessionToken,
      });
      print(response);
    } catch (e) {
      print(e);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
          child: Container(
        child: Column(
          children: <Widget>[
            _image == null ? Text('No image selected.') : Image.file(_image),
            RaisedButton(
              child: new Text(
                "上传",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)), ////圆角按钮
              onPressed: () => uploadImage(),
              color: Colors.amber,
            ),
            RaisedButton(
              child: new Text(
                "清除图片",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)), ////圆角按钮
              onPressed: () => clearPic(),
              color: Colors.amber,
            )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
