import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_community/ui/Drawer.dart';
import 'package:flutter_community/Utils/LocalStorage.dart' as localStorage;


class test extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //使用OrientationBuilder的builder模式感知屏幕旋转
      body: OrientationBuilder(
        builder: (context, orientation) {
          //根据屏幕旋转方向返回不同布局行为
          return orientation == Orientation.portrait
              ? Container()
              : Container();
        },
      ),
    );
  }
}


class Open extends StatefulWidget {
  @override
  _OpenState createState() => _OpenState();
}

class _OpenState extends State<Open> with WidgetsBindingObserver {
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); //注册监听器
  }

  @override
  @mustCallSuper
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this); //移除监听器
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("$state");
    if (state == AppLifecycleState.resumed) {
      //在前台的情况下
      print("进入了");
    }
  }

  String dropdownValue = '小区1';
  String dropdownValue2 = '大门1';

  final List<String> _allActivities = <String>[
    'hiking',
    'swimming',
    'boating',
    'fishing'
  ];
  String _activity = 'fishing';

  @override
  Widget build(BuildContext context) {


    if(MediaQuery.of(context).orientation == Orientation.portrait) {
      //表示处于竖屏状态
    }

    return new Scaffold(
      appBar: new AppBar(
          title: new Center(
        child: new Text(
          "开门",
          style: new TextStyle(
            color: Colors.black,
            backgroundColor: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      )),
      drawer: showDrawer(),
      body: new Column(
        children: <Widget>[
          new Center(
            child: new Container(
              margin: EdgeInsets.only(top: 70),
              width: 150,
              height: 150,
              child: new RaisedButton(
                child: new Text(
                  "open",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                onPressed: () {
                  localStorage.getStorage("auth").then((response) {
                    print("啦啦啦啦,获取到本地存储的token啦");
                    print(response);
                  });

                  Navigator.pushReplacementNamed(context, "LoginPage");
                },
//                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),  ////圆角按钮
                shape: CircleBorder(),
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: 24.0),
          Container(
            child: ListTile(
              title: const Text('小区'),
              trailing: DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>[
                  '小区1',
                  '小区2',
                  '小区3',
                  '小区4',
                  '小区5',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            width: MediaQuery.of(context).size.width / 2,
          ),
          SizedBox(height: 24.0),
          Container(
            child: ListTile(
              title: const Text('大门'),
              trailing: DropdownButton<String>(
                value: dropdownValue2,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue2 = newValue;
                  });
                },
                items: <String>[
                  '大门1',
                  '大门2',
                  '大门3',
                  '大门4',
                  '大门5',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            width: MediaQuery.of(context).size.width / 2,
          ),
          SizedBox(height: 24.0),
          Container(
              width: MediaQuery.of(context).size.width / 2,
              child: DropdownButtonHideUnderline(
                child: InputDecorator(
                  decoration: const InputDecoration(
//                      labelText: 'Activity',
                    hintText: 'Choose an activity',
                    prefixText: '小区：',
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(),
                  ),
                  isEmpty: _activity == null,
                  child: DropdownButton<String>(
                    value: _activity,
                    onChanged: (String newValue) {
                      setState(() {
                        _activity = newValue;
                      });
                    },
                    items: _allActivities
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
