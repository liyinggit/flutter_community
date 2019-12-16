

import 'package:flutter/material.dart';

class taps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("taps"),
      ),
      body: new Center(
        child: new InkWell(
          onTap: (){
            Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text('Tap'),
            ));
          },
          child: new Container(
            padding: new EdgeInsets.all(12.0),
            decoration: new BoxDecoration(
              color: Theme.of(context).buttonColor,
              borderRadius: new BorderRadius.circular(8.0),
            ),
            child: new Text('my button'),
          ),
        ),
      ),
    );
  }
}
