import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class AvatarEdit extends StatefulWidget {
  final String avatarUrl;

  AvatarEdit({@required this.avatarUrl}) : assert(avatarUrl != null);

  @override
  _AvatarEditState createState() => _AvatarEditState(avatarUrl);
}

class _AvatarEditState extends State<AvatarEdit> {
  final String avatarUrl;
  File imageFile;
  String _activeKey;

  _AvatarEditState(this.avatarUrl);

  final List<Map<String, dynamic>> _actionListData = [
    {'title': '拍照', 'value': 'takePhoto'},
    {'title': '相册', 'value': 'ablum'},
    {'title': '视频', 'value': 'vidio'},
  ];

  // 选择图片
  Future<Null> _pickImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {}
  }

  //拍照
  Future<Null> _takePhoto() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    if (imageFile != null) {}
  }

  Future<Null> _takeVideo() async {
    await ImagePicker.pickVideo(source: ImageSource.camera);

  }


  //图片裁剪
  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      print("图片");
      print(croppedFile);
    }
  }

  // 弹窗选项点击事件
  void _handleClick(String key) {
    print(key);
    switch (key) {
      case 'takePhoto':
        _takePhoto().then((_) {
          _cropImage();
        });
        break;
      case 'ablum':
        _pickImage().then((_) {
          _cropImage();
        });
        break;
      case 'vidio':
        _takeVideo().then((_) {

        });
        break;
      default:
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("头像"),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            alignment: Alignment.centerLeft,
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return ClipRect(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) =>
                                  Column(
                            mainAxisSize: MainAxisSize.min, // 设置最小的弹出
                            children: <Widget>[
                              Column(
                                children: _actionListData
                                    .map((Map<String, dynamic> data) =>
                                        GestureDetector(
                                          onTapUp: (TapUpDetails details) {
                                            setState(() {
                                              _activeKey = null;
                                            });
                                          },
                                          onTap: () =>
                                              _handleClick(data['value']),
                                          onTapDown: (TapDownDetails detail) {
                                            setState(() {
                                              _activeKey = data['value'];
                                            });
                                          },
                                          onTapCancel: () {
                                            setState(() {
                                              _activeKey = null;
                                            });
                                          },
                                          child: Container(
                                              width: double.infinity,
                                              child: Text(
                                                data['title'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              color: _activeKey == data['value']
                                                  ? Color(0xfffafafa)
                                                  : Colors.white),
                                        ))
                                    .toList(),
                              ),
                              ListTile(
                                title: Text(
                                  '取消',
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            icon: SvgPicture.asset(
              'images/icon_setting.svg',
              width: 20,
              height: 20,
            ),
          )
        ],
      ),
      body: FullScreenWrapper(
        backgroundDecoration: BoxDecoration(color: Color(0xff21272E)),
        imageProvider: NetworkImage(avatarUrl),
      ),
    );
  }
}

///图片的显示
class FullScreenWrapper extends StatelessWidget {
  const FullScreenWrapper(
      {this.imageProvider,
      this.loadingChild,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale,
      this.initialScale,
      this.basePosition = Alignment.center});

  final ImageProvider imageProvider;
  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final dynamic initialScale;
  final Alignment basePosition;

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoView(
          imageProvider: imageProvider,
          loadingChild: loadingChild,
          backgroundDecoration: backgroundDecoration,
          minScale: minScale,
          maxScale: maxScale,
          initialScale: initialScale,
          basePosition: basePosition,
        ));
  }
}
