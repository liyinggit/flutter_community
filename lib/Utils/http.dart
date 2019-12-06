import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_community/models/auth.dart';

class HttpRequest {
  final Dio dio = Dio();

  HttpRequest() {
    // api地址
    dio.options.baseUrl = 'http://192.168.50.105:8181/';
    // 请求超时时间
    dio.options.receiveTimeout = 15000;
    //请求连接时间
    dio.options.connectTimeout = 5000;
    // 增加拦截器(也可以使用自定义的拦截器)
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      print('send request：path:${options.path}，baseURL:${options.baseUrl}');
      // 在请求被发送之前做一些事情

      return options; //continue
      // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onResponse: (Response response) async {
      // 在返回响应数据之前做一些预处理
      print(response.data);
      print(response.statusCode);
      return response;
    }, onError: (DioError e) async {
      // 当请求失败时做一些预处理
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
        print(e.type);
      }
      return e; //continue
    }));
  }
}
