import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class House extends StatefulWidget {
  @override
  _HouseState createState() => _HouseState();
}

class _ListItem {
  _ListItem(this.value, this.checkState);

  final String value;

  bool checkState;
}

class _HouseState extends State<House> {
  Widget checkBoxList = Container();

  bool _check = false;

  List items = <String>['房屋1', '房屋2', '房屋3', '房屋4']
      .map((String item) => _ListItem(item, false))
      .toList();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(primaryColor: Colors.grey),

      ///主题颜色
      home: Scaffold(
        floatingActionButton: new FloatingActionButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  "Open",
                  (Route route) => false,
                ),
            backgroundColor: Colors.green,
            tooltip: '绑定',
            child: Container(
              child: Text(
                "绑定",
                style: TextStyle(color: Colors.white),
              ),
            )),
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
                "绑定房屋",
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
        body: new Scrollbar(
            child: new ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return new CheckboxListTile(
//                    key:Key(items[index].value),
                      title: Text('${items[index].value}'),
                      value: items[index].checkState ?? false,
                      onChanged: (bool value) {
                        setState(() {
                          items[index].checkState = value;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading);
                })
//            new ListView(
//              children: <Widget>[
//                new CheckboxListTile(
//
////                  secondary: const Icon(Icons.shutter_speed),
//                  title: const Text('房子111'),
//                  value: this._check,
//                  onChanged: (bool value) {
//                    setState(() {
//                      this._check = !this._check;
//                    });
//                  },
//                  controlAffinity: ListTileControlAffinity.leading,   //复选框在左
//                ),
//                new CheckboxListTile(
//
////                  secondary: const Icon(Icons.shutter_speed),
//                  title: const Text('房子111'),
//                  value: this._check,
//                  onChanged: (bool value) {
//                    setState(() {
//                      this._check = !this._check;
//                    });
//                  },
//                  controlAffinity: ListTileControlAffinity.trailing,  //复选框在右边
//
//                ),
//                new CheckboxListTile(
//
////                  secondary: const Icon(Icons.shutter_speed),
//                  title: const Text('房子111'),
//                  value: this._check,
//                  onChanged: (bool value) {
//                    setState(() {
//                      this._check = !this._check;
//                    });
//                  },
//                  controlAffinity: ListTileControlAffinity.platform,    //复选框根据平台而定
//
//                ),
//                new CheckboxListTile(
//
////                  secondary: const Icon(Icons.shutter_speed),
//                  title: const Text('房子111'),
//                  value: this._check,
//                  onChanged: (bool value) {
//                    setState(() {
//                      this._check = !this._check;
//                    });
//                  },
//                ),
//              ],
//            ),
            ),
      ),
    );
  }
}
