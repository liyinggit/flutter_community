import 'dart:async';
import '../utils/HttpUtils.dart';

const url = 'http://192.168.0.106:8181';

///登录
Future login() async {
  var result = await HttpUtils.request(
    url + '/authenticate',
    method: HttpUtils.POST,
    data: {"username": "user", "password": "test"},
  );
  return result;
}
