import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("水平的list"),
      ),
      body: new Container(
        margin: new EdgeInsets.symmetric(vertical: 20.0),   ///margin
        height: 200,
        child: new ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            new Container(
              width: 160,
              color: Colors.blue,
            ),
            new Container(
              width: 160,
              color: Colors.pink,
            ),
            new Container(
              width: 160,
              color: Colors.orange,
            ),
            new Container(
              width: 160,
              color: Colors.red,
            ),
            new Container(
              width: 160,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
