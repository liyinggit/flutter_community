import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Lake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ///标题部分
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32),
      child: new Row(
        children: <Widget>[
          new Expanded(

            ///放入Expanded会拉伸该列已使用该行中的所有剩余空间
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,  ///使得该行左对齐


                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      'Oeschien Lake Campground',
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  new Text(
                    'Kandersteg,Switzerland',
                    style: new TextStyle(
                      color: Colors.grey[500],
                    ),
                  )
                ],
              )
          ),
          new Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          new Text("41"),
        ],
      ),
    );


    Column buildButtonColumn(IconData icon, String lable) {
      Color color = Theme
          .of(context)
          .primaryColor;

      return new Column(
        mainAxisSize: MainAxisSize.min,

        ///紧凑在一起
        mainAxisAlignment: MainAxisAlignment.center,

        ///居中
        children: <Widget>[
          new Icon(icon, color: color),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(
              lable,
              style: new TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          )
        ],
      );
    }

    ///按钮部分
    Widget buttonSetion = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        ///平均分配每个列占据的空间
        children: <Widget>[
          buildButtonColumn(Icons.call, "call"),
          buildButtonColumn(Icons.near_me, 'ROUTE'),
          buildButtonColumn(Icons.share, 'share'),
        ],
      ),
    );

    ///文本部分
    Widget textSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
        softWrap: true,    ///是否使用软换行符
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("demo"),
      ),
      body: new ListView(
        children: <Widget>[
          new Image.asset(
            'images/lake.jpg',
            height: 240.0,
            fit:BoxFit.cover,  ///告诉框架图像尽可能小，弹药覆盖整个渲染框
          ),
          titleSection,
          buttonSetion,
          textSection
        ],
      ),
    );
  }
}
