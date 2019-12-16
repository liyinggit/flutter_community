import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("grid list"),
      ),
      body: new GridView.count(
        crossAxisCount: 2,
        children: new List.generate(
          100,
          (index) {
            return new Center(
              child: new Container(
                child: new Text(
                  'Item $index',
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
