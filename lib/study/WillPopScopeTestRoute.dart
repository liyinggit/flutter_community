
import 'package:flutter/material.dart';
import 'package:flutter_community/common/Funs.dart';

class WillPopScopeTestRoute extends StatefulWidget {
  @override
  _WillPopScopeTestRouteState createState() => _WillPopScopeTestRouteState();
}

///导航拦截
class _WillPopScopeTestRouteState extends State<WillPopScopeTestRoute> {
  DateTime _lastPressedAt; //上次点击时间
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        if(_lastPressedAt == null || DateTime.now().difference(_lastPressedAt) >Duration(seconds: 1)){

          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          return false;
        }
        showToast("双击两次退出了");
        return true;
      },
      child: Container(
        alignment: Alignment.center,
        child: Text("1秒内连续按两次返回键退出"),
      ),
    );
  }
}
