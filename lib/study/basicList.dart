
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicListRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("基础的list"),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            leading: new Icon(Icons.map),
            title:new Text('Map')
          ),
          new ListTile(
              leading: new Icon(Icons.photo_album),
              title:new Text('album')
          ),
          new ListTile(
              leading: new Icon(Icons.phone),
              title:new Text('phome')
          )
        ],
      ),
    );
  }
}
