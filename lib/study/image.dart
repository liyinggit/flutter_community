import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = 'Images';

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new Image.asset(
            'images/lake.jpg'
        ),
      );
  }
}
