import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_community/stores/Counter.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

///使用可观察的对象来展示数据,将要观察的组件用Observer包裹
class _CounterPageState extends State<CounterPage> {
//  final Counter counter = Counter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mobx管理例子"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Observer(
              builder: (_) => Text(
                '${counter.value}',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            SizedBox(height: 100),
            RaisedButton(
              child: Text('加'),
              onPressed: counter.increment,
            ),
            RaisedButton(
              child: Text('减'),
              onPressed: counter.decrement,
            ),
            RaisedButton(
                child: Text('go to second page'),
                onPressed: () => Navigator.pushNamed(context, 'SecondPage')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter.set(0);
        },
        tooltip: '归零',
        child: Text('归零'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

///想多个页面共享
///第二个页面
class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
//  final Counter counter = Counter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('second page'),
      ),
      body: Center(
        child: Observer(
          builder: (_) => Text(
            'count is ${counter.value}',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: counter.increment,
      ),
    );
  }

}
