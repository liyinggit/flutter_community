import 'package:shared_preferences/shared_preferences.dart';

///存储
Future setStorage(String key, dynamic value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isOk = false;
  if (value is String) {
    isOk = await prefs.setString(key, value);
  } else if (value is int) {
    isOk = await prefs.setInt(key, value);
  } else if (value is bool) {
    isOk = await prefs.setBool(key, value);
  }
  return isOk;
}

///获取string类型的
Future<String> getStorage(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String data = prefs.getString(key);

  return data;
}
