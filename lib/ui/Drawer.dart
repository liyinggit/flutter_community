

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AvatarEdit.dart';

class showDrawer extends StatefulWidget {
  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<showDrawer> {
  @override
  Widget build(BuildContext context) {

    final String avatarUrl = 'http://admin.soscoon.com/uploadImages/2bdcbd37d2fae6874cce4bba45d14573630925b1.jpeg';
    return Drawer(
      child: Column(
        children: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AvatarEdit(
                      avatarUrl: avatarUrl,
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 30.0),
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Color(0xff2A2C33),
                    image: DecorationImage(image: NetworkImage(avatarUrl)),
                ),
              ),
          ),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
              child: _drawerItem(context),
            ),
          )
        ],
      ),
    );
  }

  /// 抽屉里的每个item
  Widget _drawerItem(BuildContext context) {
    DateTime time = DateTime.now();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.done_outline),
          title: Text("开门"),
          trailing: Icon(Icons.chevron_right),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.color_lens),
          title: Text("切换主题"),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

}