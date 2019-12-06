

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_community/Utils/http.dart';



//提供五套可选的主题色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global{

  //持久化信息
  static SharedPreferences _prefs;

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  //初始化全局信息，会在APP启动时执行
  static Future init() async{
    //这里可以初始化本地存储,网络请求等的相关配置


  }
}

