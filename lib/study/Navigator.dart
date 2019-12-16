import 'package:flutter/material.dart';

///创建了一个列表
class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

class FirstScreen extends StatelessWidget {

  List<Todo> todos = new List.generate(20, (i) =>
  new Todo(
    'Todo $i',
    'A description of what needs to be done for Todo $i',
  ),
  );


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("导航1"),
        ),
        body: new ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return new ListTile(
                  title: new Text(todos[index].title),
                  onTap: () {
                    _navigateAndDisplaySelection(context, index);
                  }
              );
            }
        )
    );
  }

  _navigateAndDisplaySelection(BuildContext context, index) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    final result = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) =>
        new SecondScreen(todo: todos[index]),   //给新页面传值
      ),
    );

    // After the Selection Screen returns a result, show it in a Snackbar!
    Scaffold
        .of(context)
        .showSnackBar(new SnackBar(content: new Text("$result")));  ///将新页面得值以snackBar的方式显示
  }
}

class SecondScreen extends StatelessWidget {

  final Todo todo;

  SecondScreen({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("${todo.title}"),
        ),
        body: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.all(16.0),
                  child: new Text('${todo.description}'),
                ),

                new Padding(
                    padding: new EdgeInsets.all(8.0),
                    child: new RaisedButton(
                        child: new Text('pop'),
                        onPressed: () {
                          Navigator.pop(context, "${todo.title}");   ///这是从新页面返回数据给上一页
                        }
                    )
                )
              ],
            )

        )

    );
  }
}

