import 'package:flutter/material.dart';

class LongList extends StatelessWidget {
  final List<String> items;

  LongList({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("长列表"),
      ),
      body: new ListView.builder(
          itemCount: items.length,
          itemBuilder: (context,index){
            return new ListTile(
              title: new Text('${items[index]}'),
            );
          }
      ),
    );
  }
}
