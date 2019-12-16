

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageList extends StatelessWidget {

  Widget divider = Container(
    color: Colors.blue,
    padding:EdgeInsets.all(8.0) ,
    child: Text(
      "这是标题",
      style: TextStyle(
        fontSize: 24,color: Colors.white
      ),
    ),
  );

  Widget item = Container(
    margin: EdgeInsets.all(20.0),
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey,width: 1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRect(
            child: Image.asset("images/lake.jpg"),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text("标题",style: TextStyle(fontSize: 24),),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
            child: Text("这是一个副标题"),
          )
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
       title: Text(
          "图片列表"
        )
      ) ,
       body: ListView.separated(
            itemBuilder: (BuildContext context,int index){
              return GestureDetector(
                child: item,
                onTap:(){
                  print("点击l$index");
                },
              );
            },
            separatorBuilder: (BuildContext context,int index ){
              return index>0 && index %6 ==0 ?
              divider
                  :
              Divider(
                color: Colors.grey,
              );
            },
            itemCount: 50
        )
    ) ;
  }
}
