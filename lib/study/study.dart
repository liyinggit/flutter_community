
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class study extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("学习列表"),

      ),
      body: Scrollbar(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical:5.0 ),
          children: <Widget>[
            Container(
              child: ListTile(
                leading: Icon(Icons.image),
                title: Text("ImageList"),
                subtitle: Text("图片列表"),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pushNamed(context, "ImageList");
                },
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
