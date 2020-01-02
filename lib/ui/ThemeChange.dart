
import 'package:flutter/material.dart';
import 'package:flutter_community/common/Global.dart';
import 'package:flutter_community/stores/ThemeState.dart';
import 'package:provider/provider.dart';

class ThemeChange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("更换主题"),
      ),
      body: ListView(
        children: Global.themes.map<Widget>((color){
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 16),
              child: Container(
                color: color,
                height: 40,
              ),
            ),
            onTap: (){
              ThemeData themeData = ThemeData(primaryColor: color);//颜色
              Provider.of<ThemeState>(context).changeThemeData(themeData);
            },
          );
        }).toList(),
      ),
    );
  }
}
