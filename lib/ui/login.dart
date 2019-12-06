import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_community/Utils/http.dart';
import 'package:flutter_community/models/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //焦点
  FocusNode _focusNodeUserName = new FocusNode();
  FocusNode _focusNodePassWord = new FocusNode();

  //用户名输入框控制器,此控制器可以监听用户名输入框操作
  TextEditingController _userNameController = new TextEditingController();

  //表单状态
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _password = ""; //密码
  var _username = ""; //账号
  var _isShowPwd = false; //是否显示密码
  var _isShowClear = false; //是否显示输入框尾部的清除按钮

  @override
  void initState() {
    //设置焦点监听
    _focusNodePassWord.addListener(_focusNodeListener);
    _focusNodeUserName.addListener(_focusNodeListener);

    _userNameController.addListener(() {
      if (_userNameController.text.length > 0) {
        _isShowClear = true;
      } else {
        _isShowClear = false;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // 移除焦点监听
    _focusNodeUserName.removeListener(_focusNodeListener);
    _focusNodePassWord.removeListener(_focusNodeListener);
    _userNameController.dispose();
    super.dispose();
  }

  // 监听焦点
  Future<Null> _focusNodeListener() async {
    if (_focusNodeUserName.hasFocus) {
      print("用户名框获取焦点");
      // 取消密码框的焦点状态
      _focusNodePassWord.unfocus();
    }
    if (_focusNodePassWord.hasFocus) {
      print("密码框获取焦点");
      // 取消用户名框焦点状态
      _focusNodeUserName.unfocus();
    }
  }

  ///验证用户名
  String validateUserName(value) {
    // 正则匹配手机号
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    if (value.isEmpty) {
      return '用户名不能为空!';
    }
//    else if (!exp.hasMatch(value)) {
//      return '请输入正确手机号';
//    }
    return null;
  }

  ///验证密码
  String validatePassWord(value) {
    if (value.isEmpty) {
      return '密码不能为空';
    } else if (value.trim().length < 1 || value.trim().length > 18) {
      return '密码长度不正确';
    }
    return null;
  }

  ///登录
  _login() async {
    const url = 'http://192.168.50.105:8181/authenticate';

//    Response response = await HttpRequest().dio.post(
//      url,
//      data: {"username": _username, "password": _password},
//    );

    await HttpRequest().dio.post(
      url,
      data: {"username": _username, "password": _password},
    ).then((response) {
      print(response.data);
      print("headers:");
      print(response.headers);
      print("request:");
      print(response.request);
      print("statusCode:");
      print(response.statusCode);
      Auth auth = new Auth.fromJson(response.data);
      print("token：" + auth.token);

      if(response.statusCode == 200){
        //登录成功后跳转到绑定账号页面
        Navigator.of(context).pushNamed("Register");
      }else{
        print("登录失败");
      }
    }).catchError((Object error) {
      print('Http is catch：$error');
    }).whenComplete(() {
      print('Http is Complete');
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    //logo图片区域
    Widget logoImageArea = new Container(
      alignment: Alignment.topCenter,
      child: Image.asset(
        "images/lake.jpg",
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
    );

    //输入文本框区域
    Widget inputTextArea = new Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new TextFormField(
              controller: _userNameController,
              focusNode: _focusNodeUserName,
              //输入键盘类型
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "用户名/手机/邮箱",
                hintText: "用户名/手机/邮箱",
                prefixIcon: Icon(Icons.person),
                //尾部清除按钮
                suffixIcon: (_isShowClear)
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          //清除输入框内容
                          _userNameController.clear();
                        },
                      )
                    : null,
              ),
              //验证用户名
              validator: validateUserName,
              //保存用户数据
              onSaved: (String value) {
                _username = value;
              },
            ),
            new TextFormField(
              focusNode: _focusNodePassWord,
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "请输入密码",
                  prefixIcon: Icon(Icons.lock),
                  //是否显示密码
                  suffixIcon: IconButton(
                    icon: Icon(
                        (_isShowPwd) ? Icons.visibility : Icons.visibility_off),
                    //点击改变显示或隐藏密码
                    onPressed: () {
                      setState(() {
                        _isShowPwd = !_isShowPwd;
                      });
                    },
                  )),
              obscureText: !_isShowPwd,
              //密码验证
              validator: validatePassWord,
              //保存数据
              onSaved: (String value) {
                _password = value;
              },
            )
          ],
        ),
      ),
    );

    ///登录按钮
    Widget loginButtonArea = new Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 45.0,
      child: new RaisedButton(
          color: Colors.green,
          child: Text(
            "登录",
            style: new TextStyle(color: Colors.white),
          ),
          //设置按钮圆角
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          onPressed: () {
            //点击登录按钮，解除焦点，回收键盘
            _focusNodePassWord.unfocus();
            _focusNodeUserName.unfocus();
            if (_formKey.currentState.validate()) {
              //只有输入通过验证，才会执行这里
              _formKey.currentState.save();

              print('账号密码' + "$_username + $_password");
              //登录获取token
              _login();
            }
          }),
    );

    Widget thridLoginArea = new Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 80,
                height: 1.0,
                color: Colors.grey,
              ),
              Text('第三方登录'),
              Container(
                width: 80,
                height: 1.0,
                color: Colors.grey,
              )
            ],
          ),
          new SizedBox(
            height: 18,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                color: Colors.green[200],
                //第三方icon图标
                icon: Icon(FontAwesomeIcons.weixin),
                iconSize: 30,
                onPressed: () {},
              ),
              IconButton(
                color: Colors.green[200],
                //第三方icon图标
                icon: Icon(FontAwesomeIcons.qq),
                iconSize: 30,
                onPressed: () {},
              ),
              IconButton(
                color: Colors.green[200],
                //第三方icon图标
                icon: Icon(FontAwesomeIcons.facebook),
                iconSize: 30,
                onPressed: () {},
              ),
              IconButton(
                color: Colors.green[200],
                //第三方icon图标
                icon: Icon(Icons.android),
                iconSize: 30,
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );

    ///注册按钮
    Widget registerButtonArea = new Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 45.0,
      child: new RaisedButton(
          color: Colors.orangeAccent,
          child: Text(
            "注册",
            style: new TextStyle(color: Colors.white),
          ),
          //设置按钮圆角
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          onPressed: () => Navigator.of(context).pushNamed("Register")),
    );

    return MaterialApp(
        theme: new ThemeData(primaryColor: Colors.grey),

        ///主题颜色
        home: new Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.white,
            title: new Center(
              child: new Text(
                "登录",
                style: new TextStyle(
                  color: Colors.black,
                  backgroundColor: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          //外层添加一个手势，用于点击空白部分，回收键盘
          body: new GestureDetector(
            onTap: () {
              //点击空白区域，回收键盘
              _focusNodePassWord.unfocus();
              _focusNodeUserName.unfocus();
            },
            child: new ListView(
              children: <Widget>[
                new SizedBox(
                  height: ScreenUtil().setHeight(80),
                ),
//                logoImageArea,
                new SizedBox(
                  height: ScreenUtil().setHeight(70),
                ),
                inputTextArea,
                new SizedBox(
                  height: ScreenUtil().setHeight(80),
                ),
                loginButtonArea,
                new SizedBox(
                  height: ScreenUtil().setHeight(60),
                ),
                thridLoginArea,
                new SizedBox(
                  height: ScreenUtil().setHeight(60),
                ),
                registerButtonArea
              ],
            ),
          ),
        ));
  }
}
