

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewSeparated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context,int index){
          return ListTile(
            title: Text("标题"),
            subtitle: Text("副标题"),
            leading: Icon(Icons.add_a_photo),
            trailing: Text("尾部"),
          );
        },
        separatorBuilder: (BuildContext context,int index){
          return Divider(
            indent: 10,
            endIndent: 10,
            color: Colors.grey,
          );
        },
        itemCount: 10
    );
  }
}
