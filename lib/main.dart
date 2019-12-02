import 'package:flutter/material.dart';
import 'package:flutter_community/ui/Register.dart';
import 'package:flutter_community/ui/house.dart';
import 'package:flutter_community/ui/login.dart';
import 'package:flutter_community/ui/open.dart';



void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(primaryColor: Colors.white),

      ///主题颜色
      home: Open(), //当前页面
      routes: <String, WidgetBuilder>{
        ///添加路由
        "Open":(BuildContext context) => Open(),
        "LoginPage": (BuildContext context) => LoginPage(),  //登录页面
        "House": (BuildContext  context) => House(),   //绑定房屋页面
        "Register": (BuildContext context) => Register(),  //绑定账号页面
      },
    );
  }
}
