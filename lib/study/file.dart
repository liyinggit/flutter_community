//使用快捷键 stful创建有状态的widget
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileRoute extends StatefulWidget {
  @override
  _FlutterDemoState createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FileRoute> {
  int _counter;

  @override
  void initState() {
    super.initState();

    _readCounter().then((int value) {
      setState(() {
        _counter = value;
      });
    });
  }

  /// 创建了一个文件
  Future<File> _getLocalFile() async {
    // get the path to the document directory.
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/counter.txt');
  }

  /// 读取文件
  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();

      // read the variable as a string from the file.
      String contents = await file.readAsString();

      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  /// 写文件
  Future<Null> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    // write the variable as a string to the file
    await (await _getLocalFile()).writeAsString('$_counter');
  }

  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
        appBar: new AppBar(
          title: new Text('文件读写'),
        ),
        body: new Center(
          child: new Text(
              'Button tapped $_counter time${_counter == 1 ? "" : "s"}'),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: '写',
          child: new Icon(Icons.add),
        ),
      );
  }
}
