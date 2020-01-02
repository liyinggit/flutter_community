import 'package:flutter/material.dart';
import 'package:flutter_community/aws/imagePicker.dart';
import 'package:flutter_community/stores/ThemeState.dart';
import 'package:flutter_community/study/imageList.dart';
import 'package:flutter_community/study/study.dart';
import 'package:flutter_community/ui/CounterPage.dart';
import 'package:flutter_community/ui/Drawer.dart';
import 'package:flutter_community/ui/Register.dart';
import 'package:flutter_community/ui/ThemeChange.dart';
import 'package:flutter_community/ui/house.dart';
import 'package:flutter_community/ui/login.dart';
import 'package:flutter_community/ui/open.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///主题颜色
      theme: Provider.of<ThemeState>(context).themeData, //获取provider中的数据
      home: Open(), //当前页面
      routes: <String, WidgetBuilder>{
        ///添加路由
        "Open": (BuildContext context) => Open(),
        "LoginPage": (BuildContext context) => LoginPage(), //登录页面
        "House": (BuildContext context) => House(), //绑定房屋页面
        "Register": (BuildContext context) => Register(), //绑定账号页面
        "showDrawer": (BuildContext context) => showDrawer(), //drawer
        "ThemeChange": (BuildContext context) => ThemeChange(), //更换主题
        "ImagePiker": (BuildContext context) => ImagePiker(), //上传图片页面
        "CounterPage": (BuildContext context) => CounterPage(), //mobx状态管理小例子
        "SecondPage": (BuildContext context) => SecondPage(), //mobx状态管理小例子第二个页面
        ///学习的列表
        "study": (BuildContext context) => study(),
        "ImageList": (BuildContext context) => ImageList(),
      },
    );
  }
}
