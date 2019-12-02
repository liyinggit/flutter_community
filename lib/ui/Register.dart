import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //表单状态
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget phoneTextArea = new Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new TextField(
              decoration: InputDecoration(
                labelText: "手机",
                hintText: "手机",
                prefixIcon: Icon(Icons.phone),
              ),
            ),
          ),
          new Container(
            color: Colors.green,
            height: 55.0,
            child: new RaisedButton(
              child: new Text(
                "验证码",
                style: new TextStyle(color: Colors.white),
              ),
              onPressed: null,
            ),
          )
        ],
      ),
    );

    //输入文本框区域
    Widget inputTextArea = new Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
      ),
      child: new Form(
        key: _formKey,
        child: new Column(
          children: <Widget>[
            new TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "用户名",
                hintText: "用户名",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            new TextFormField(
              decoration: InputDecoration(
                labelText: "密码",
                hintText: "密码",
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            new TextFormField(
              decoration: InputDecoration(
                labelText: "手机",
                hintText: "手机",
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            new TextFormField(
              decoration: InputDecoration(
                labelText: "验证码",
                hintText: "验证码",
                prefixIcon: Icon(Icons.lock),
              ),
            ),
          ],
        ),
      ),
    );

    ///绑定按钮
    Widget registerButton = new Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 45.0,
      child: new RaisedButton(
        color: Colors.green,
        child: Text(
          "绑定",
          style: new TextStyle(color: Colors.white),
        ),
        //设置按钮圆角
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onPressed: () => Navigator.pushNamed(context, "House"),
      ),
    );

    return MaterialApp(
      theme: new ThemeData(primaryColor: Colors.grey),

      ///主题颜色
      home: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          title: new Center(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new IconButton(
                color: Colors.grey,
                //第三方icon图标
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              new Text(
                "绑定账号",
                style: new TextStyle(
                  color: Colors.black,
                  backgroundColor: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              new Icon(null),
            ],
          )),
        ),
        backgroundColor: Colors.white,
        body: new ListView(
          children: <Widget>[
            new SizedBox(
              height: ScreenUtil().setHeight(80),
            ),
            inputTextArea,
            new SizedBox(
              height: ScreenUtil().setHeight(80),
            ),
            registerButton,
            new SizedBox(
              height: ScreenUtil().setHeight(80),
            ),
            phoneTextArea
          ],
        ),
      ),
    );
  }
}
